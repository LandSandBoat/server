-----------------------------------
-- Season's Greetings
-- Balga's Dais KSNM, Clotho Orb
-- !additem 1175
-----------------------------------
local balgasID = zones[xi.zone.BALGAS_DAIS]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.BALGAS_DAIS,
    battlefieldId    = xi.battlefield.id.SEASONS_GREETINGS,
    maxPlayers       = 6,
    timeLimit        = utils.minutes(30),
    index            = 15,
    entryNpc         = 'BC_Entrance',
    exitNpc          = 'Burning_Circle',
    requiredItems    = { xi.item.CLOTHO_ORB, wearMessage = balgasID.text.A_CRACK_HAS_FORMED, wornMessage = balgasID.text.ORB_IS_CRACKED },

    experimental     = true,
})

content.groups =
{
    {
        mobIds =
        {
            {
                balgasID.mob.GILAGOGE_TLUGVI,
                balgasID.mob.GILAGOGE_TLUGVI + 1,
                balgasID.mob.GILAGOGE_TLUGVI + 2,
                balgasID.mob.GILAGOGE_TLUGVI + 3,
            },

            {
                balgasID.mob.GILAGOGE_TLUGVI + 5,
                balgasID.mob.GILAGOGE_TLUGVI + 6,
                balgasID.mob.GILAGOGE_TLUGVI + 7,
                balgasID.mob.GILAGOGE_TLUGVI + 8,
            },

            {
                balgasID.mob.GILAGOGE_TLUGVI + 10,
                balgasID.mob.GILAGOGE_TLUGVI + 11,
                balgasID.mob.GILAGOGE_TLUGVI + 12,
                balgasID.mob.GILAGOGE_TLUGVI + 13,
            },
        },
        superlink = false,
        allDeath  = utils.bind(content.handleAllMonstersDefeated, content),
    },
}

content.loot =
{
    {
        -- TODO: Loot
    },
}

return content:register()
