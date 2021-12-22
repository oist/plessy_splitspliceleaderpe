#!/usr/bin/env nextflow
/*
========================================================================================
    draft/splitspliceleaderpe
========================================================================================
    Github : https://github.com/oist/plessy_splitspliceleaderpe
    Website: https://example.com/splitspliceleaderpe
    Slack  : https://example.com/channels/splitspliceleaderpe
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
// WORKFLOW: Run main draft/splitspliceleaderpe analysis pipeline
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
