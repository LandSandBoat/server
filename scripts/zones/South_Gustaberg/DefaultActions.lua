local ID = zones[xi.zone.SOUTH_GUSTABERG]

return {
    ['Fish_Eyes']      = { event = 903 },
    ['qm2']            = { messageSpecial = ID.text.FIRE_GOOD }, -- Note: even when the fire is out on retail it emits this message.
    ['Stone_Monument'] = { event = 900 },
}
