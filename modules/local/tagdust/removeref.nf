process TAGDUST_REFREMPE {
    tag "$meta.id"
    label 'process_high'
    
    container = 'cagescan/tagdust2:20211222'

    input:
    tuple val(meta), path(reads)
    path(arch)
    path(rrna)

    output:
    path "*_REFREM_READ1.fq.gz",  emit: REFREM_R1_FASTQ
    path "*_REFREM_READ2.fq.gz",  emit: REFREM_R2_FASTQ
    path "*_logfile.txt",         emit: TagDust2LogFile
    path "versions.yml",          emit: versions

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    # Remove trailing \1s and \2s only when needed
    # Note that 'zcat foo | head' would trigger pipefail
    # and cause the 'else' clause to be always selected.
    if head -n1 <(zcat ${reads[0]}) | grep -cq '/1\$'
    then
        gzip -cdf ${reads[0]} | sed -e 1~4's,/1\$,,' | gzip > __clean__read1.fq.gz
        gzip -cdf ${reads[1]} | sed -e 1~4's,/2\$,,' | gzip > __clean__read2.fq.gz
    else
        ln -s ${reads[0]} __clean__read1.fq.gz
        ln -s ${reads[1]} __clean__read2.fq.gz
    fi

    # Then run TagDust
    tagdust                      \\
        -t    $task.cpus         \\
        -ref  $rrna              \\
        -arch $arch              \\
        -o    ${prefix}_REFREM   \\
        __clean__read1.fq.gz     \\
        __clean__read2.fq.gz

    # compress the output
    for f in *fq ; do gzip \$f ; done

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tagdust: \$(echo \$(tagdust --version 2>&1) | sed 's/^Tagdust //' )
    END_VERSIONS
    """
}