local ID = zones[xi.zone.CAEDARVA_MIRE]

return {
    ['_27b']                 = { event   = 305 },
    ['Jazaraats_Headstone']  = { special = ID.text.JAZARAATS_HEADSTONE }, -- Overwritten In scripts/missions/toau/13_Lost_Kingdom.lua
    ['qm5']                  = { special = ID.text.NOTHING_OUT_OF_ORDINARY },
    ['qm12']                 = { special = ID.text.NOTHING_HAPPENS },
    ['Seaprinces_Tombstone'] = { special = ID.text.SEAPRINCES_TOMBSTONE },
    ['Warhorse_Hoofprint']   = { special = ID.text.WARHORSE_HOOFPRINT },
}
