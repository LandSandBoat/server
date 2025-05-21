local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]

return {
    ['qm1']                 = { messageSpecial = ID.text.FIND_NOTHING },
    ['qm2']                 = { messageSpecial = ID.text.BLACKENED_SPOT_ON_GROUND },
    ['Shattered_Telepoint'] = { messageSpecial = ID.text.TELEPOINT_HAS_BEEN_SHATTERED },
    ['Signpost']            = { messageSpecial = ID.text.SIGNPOST_DIALOG_1 },
    ['Signpost2']           = { messageSpecial = ID.text.SIGNPOST2 },
    ['Signpost3']           = { messageSpecial = ID.text.SIGNPOST3 },
    ['Stone_Monument']      = { event = 900 },
}
