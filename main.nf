#!/usr/bin/env nextflow
WorkflowMain.initialise(workflow, params, log)
include { SPLITSPLICELEADERPE } from './workflows/splitspliceleaderpe'
workflow NFCORE_SPLITSPLICELEADERPE {
    SPLITSPLICELEADERPE ()
}
workflow {
    NFCORE_SPLITSPLICELEADERPE ()
}
