process TAGDUST_SPLITSLPE {
    tag "$meta.id"
    label 'process_high'
    
    container = 'cagescan/tagdust2:2020071401'

    input:
    tuple val(meta), path(reads)
    path(arch)
    path(rrna)

    output:
    path "*_SL.fq",         emit: withSL_FASTQ
    path "*_SL_un.fq",      emit: noSL_FASTQ
    path "*_logfile.txt",   emit: TagDust2LogFile

    output:
    path "versions.yml"           , emit: versions

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    tagdust                      \\
        -t    $task.cpus         \\
        -ref  $rrna              \\
        -arch $arch              \\
        -o    ${prefix}_SL       \\
        ${reads[0]}              \\
        ${reads[1]}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        tagdust: \$(echo \$(tagdust --version 2>&1) | sed 's/^Tagdust //' ))
    END_VERSIONS
    """
}
