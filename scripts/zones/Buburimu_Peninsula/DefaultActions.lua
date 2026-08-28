local ID = zones[xi.zone.BUBURIMU_PENINSULA]

return {
    ['Five_of_Spades']   = { messageName = ID.text.FIVEOFSPADES_DIALOG },
    ['qm1']              = { messageSpecial = ID.text.SHIP_SANK_NEAR_HERE },
    ['Song_Runes']       = { messageSpecial = ID.text.SONG_RUNES_DEFAULT },
    ['Stone_Monument']   = { event = 900 },
}
