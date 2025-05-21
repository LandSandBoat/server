local ID = zones[xi.zone.LA_THEINE_PLATEAU]

return {
    ['Augevinne']           = { text = ID.text.RESCUE_DRILL + 33 },
    ['Cermet_Headstone']    = { messageSpecial = ID.text.CANNOT_REMOVE_FRAG },
    ['Chocobo_Tracks']      = { messageSpecial = ID.text.CHOCOBO_TRACKS },
    ['Deaufrain']           = { text = ID.text.RESCUE_DRILL + 32 },
    ['Equesobillot']        = { text = ID.text.RESCUE_DRILL + 31 },
    ['Galaihaurat']         = { text = ID.text.RESCUE_DRILL },
    ['Laurisse']            = { text = ID.text.RESCUE_DRILL + 36 },
    ['Narvecaint']          = { text = ID.text.RESCUE_DRILL + 37 },
    ['Shattered_Telepoint'] = { messageSpecial = ID.text.TELEPOINT_HAS_BEEN_SHATTERED },
    ['Stone_Monument']      = { event = 900 },
    ['Tayula']              = { event = 105 },
    ['Vicorpasse']          = { text = ID.text.RESCUE_DRILL + 38 },
    ['Yaucevouchat']        = { text = ID.text.RESCUE_DRILL + 34 },
}
