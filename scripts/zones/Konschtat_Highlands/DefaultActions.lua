local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]

return {
    ['qm1'                ] = { text           = ID.text.GIMME_EVERYTHING_YA_GOT      },
    ['qm2'                ] = { messageSpecial = ID.text.THOUGHT_YOU_SAW_SOMETHING    },
    ['qm3'                ] = { messageSpecial = ID.text.BLACKENED_SPOT_ON_GROUND     },
    ['Shattered_Telepoint'] = { messageSpecial = ID.text.TELEPOINT_HAS_BEEN_SHATTERED },
    ['Signpost'           ] = { messageSpecial = ID.text.SIGNPOST                     },
    ['Signpost2'          ] = { messageSpecial = ID.text.SIGNPOST2                    },
    ['Signpost3'          ] = { messageSpecial = ID.text.SIGNPOST3_DIALOG_1           },
    ['Stone_Monument'     ] = { event          = 900                                  },
}
