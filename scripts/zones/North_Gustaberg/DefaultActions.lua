local ID = zones[xi.zone.NORTH_GUSTABERG]

return {
    ['Field_Parchment'] = { event = 2001 },
    ['Hunting_Bear']    = { event = 20 },
    ['Stone_Monument']  = { event = 900 },
    ['Waterfall_Base']  = { messageSpecial = ID.text.REACH_WATER_FROM_HERE },
}
