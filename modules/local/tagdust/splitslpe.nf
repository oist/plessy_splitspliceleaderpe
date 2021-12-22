process TAGDUST_SPLITSLPE {
    tag "$meta.id"
    label 'process_high'
    
    container = 'cagescan/tagdust2:20211222'

    input:
    tuple val(meta), path(reads)
    path(arch)
    path(rrna)

    output:
    path "*_SL_READ1.fq",         emit: withSL_R1_FASTQ
    path "*_SL_READ2.fq",         emit: withSL_R2_FASTQ
    path "*_SL_un_READ1.fq",      emit: noSL_R1_FASTQ
    path "*_SL_un_READ2.fq",      emit: noSL_R2_FASTQ
    path "*_logfile.txt",         emit: TagDust2LogFile
    path "versions.yml",          emit: versions

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    # Remove trailing \1s and \2s ...
    gzip -cdf ${reads[0]} | sed -e 1~4's,/1\$,,' | gzip > __clean__read1.fa.gz
    gzip -cdf ${reads[1]} | sed -e 1~4's,/2\$,,' | gzip > __clean__read2.fa.gz

    # Then run TagDust
    tagdust                      \\
        -t    $task.cpus         \\
        -ref  $rrna              \\
        -arch $arch              \\
        -o    ${prefix}_SL       \\
        __clean__read1.fa.gz     \\
        __clean__read2.fa.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tagdust: \$(echo \$(tagdust --version 2>&1) | sed 's/^Tagdust //' )
    END_VERSIONS
    """
}
