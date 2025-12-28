-----------------------------------
-- Fire in the Sky
-- Level 40 ENM
-- !addkeyitem 674
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.FIRE_IN_THE_SKY,
    maxPlayers       = 18,
    levelCap         = 40,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.ki.MONARCH_BEARD, message = monarchLinnID.text.TORN_FROM_YOUR_HANDS },
    experimental     = true,
})

content.groups =
{
    {
        mobIds =
        {
            {
                monarchLinnID.mob.RAZON,
            },

            {
                monarchLinnID.mob.RAZON + 2,
            },

            {
                monarchLinnID.mob.RAZON + 4,
            },
        },
    },
}

content.loot =
{
    {
        -- TODO: Loot
    },
}

return content:register()
