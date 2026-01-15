local ID = zones[xi.zone.CAEDARVA_MIRE]

return {
    ['_27b']                 = { event          = 305 },
    ['Jazaraats_Headstone']  = { messageSpecial = ID.text.JAZARAATS_HEADSTONE }, -- Overwritten In scripts/missions/toau/13_Lost_Kingdom.lua
    ['qm5']                  = { messageSpecial = ID.text.NOTHING_OUT_OF_ORDINARY },
    ['qm12']                 = { messageSpecial = ID.text.NOTHING_HAPPENS },
    ['Seaprinces_Tombstone'] = { messageSpecial = ID.text.SEAPRINCES_TOMBSTONE },
    ['Warhorse_Hoofprint']   = { messageSpecial = ID.text.WARHORSE_HOOFPRINT },
}
