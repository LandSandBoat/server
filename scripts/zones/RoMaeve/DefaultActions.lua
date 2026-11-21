local ID = zones[xi.zone.ROMAEVE]

return {
    ['Ensorcelled_Door'] = { text = ID.text.DOOR_IS_LOCKED },
    ['qm1']              = { messageSpecial = ID.text.NOTHING_OUT_OF_ORDINARY },
    ['qm2']              = { messageSpecial = ID.text.PILE_OF_RUBBLE },
    ['QuHau_Spring']     = { messageSpecial = ID.text.MYSTERIOUS_ANCIENT_MONUMENT },
}
