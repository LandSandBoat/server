local ID = zones[xi.zone.CAEDARVA_MIRE]

return {
    ['Jazaraats_Headstone'] = { messageSpecial = ID.text.JAZARAATS_HEADSTONE }, -- Overwritten In scripts/missions/toau/13_Lost_Kingdom.lua
    ['qm12']                = { messageSpecial = ID.text.NOTHING_HAPPENS },
}
