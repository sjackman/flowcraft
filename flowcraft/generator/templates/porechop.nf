process porechop_{{pid}} {
    {% include "post.txt" ignore missing %}

    publishDir "results/porechop_{{pid}}", pattern: "*.fastq.gz"
    publishDir "reports/porechop_{{pid}}", pattern: "*.log"

    tag { sample_id }

    input:
    set sample_id, file(fastq_pair) from {{input_channel}}

    output:
    set sample_id, "${sample_id}.fastq.gz" into {{ output_channel }}
    {% with task_name="porechop" %}
    {%- include "compiler_channels.txt" ignore missing -%}
    {% endwith %}

    script:
    "time porechop -t $task.cpus --format fastq.gz -i ${fastq_pair[0]} -o ${sample_id}.fastq.gz >${sample_id}.log"
}

{{ forks }}
