-----------------------------------
-- Today's Horoscope
-- Horlais Peak KSNM, Lachesis Orb
-- !additem 1178
-----------------------------------
local horlaisID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.HORLAIS_PEAK,
    battlefieldId    = xi.battlefield.id.TODAYS_HOROSCOPE,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 16,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.LACHESIS_ORB, wearMessage = horlaisID.text.A_CRACK_HAS_FORMED, wornMessage = horlaisID.text.ORB_IS_CRACKED },

    experimental     = true,
})

content:addEssentialMobs({ 'Aries' })

content.loot =
{
    {
        -- TODO: Loot
    },
}

return content:register()
