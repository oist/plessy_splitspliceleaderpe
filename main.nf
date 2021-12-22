#!/usr/bin/env nextflow
/*
========================================================================================
    nf-core/splitspliceleaderpe
========================================================================================
    Github : https://github.com/nf-core/splitspliceleaderpe
    Website: https://nf-co.re/splitspliceleaderpe
    Slack  : https://nfcore.slack.com/channels/splitspliceleaderpe
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

/*
========================================================================================
    GENOME PARAMETER VALUES
========================================================================================
*/

params.fasta = WorkflowMain.getGenomeAttribute(params, 'fasta')

/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    NAMED WORKFLOW FOR PIPELINE
========================================================================================
*/

include { SPLITSPLICELEADERPE } from './workflows/splitspliceleaderpe'

//
// WORKFLOW: Run main nf-core/splitspliceleaderpe analysis pipeline
//
workflow NFCORE_SPLITSPLICELEADERPE {
    SPLITSPLICELEADERPE ()
}

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
// See: https://github.com/nf-core/rnaseq/issues/619
//
workflow {
    NFCORE_SPLITSPLICELEADERPE ()
}

/*
========================================================================================
    THE END
========================================================================================
*/
