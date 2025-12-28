-----------------------------------
-- Uninvited Guests
-- Monarch Linn quest battlefield
-- !addkeyitem 720
-- TODO: Get key item usage message.
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.MONARCH_LINN,
    battlefieldId    = xi.battlefield.id.UNINVITED_GUESTS,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 6,
    entryNpc         = 'SD_Entrance',
    exitNpcs         = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    requiredKeyItems = { xi.keyItem.MONARCH_LINN_PATROL_PERMIT },
    questArea        = xi.questLog.OTHER_AREAS,
    quest            = xi.quest.id.otherAreas.UNINVITED_GUESTS,
    requiredVar      = 'Quest[4][81]Prog',
    requiredValue    = 1,
    experimental     = true,
})

content.groups =
{
    {
        mobIds =
        {
            { monarchLinnID.mob.MAMMET_800      },
            { monarchLinnID.mob.MAMMET_800 + 10 },
            { monarchLinnID.mob.MAMMET_800 + 20 },
        },
    },

    {
        mobIds =
        {
            {
                monarchLinnID.mob.MAMMET_800 + 1,
                monarchLinnID.mob.MAMMET_800 + 2,
                monarchLinnID.mob.MAMMET_800 + 3,
                monarchLinnID.mob.MAMMET_800 + 4,
                monarchLinnID.mob.MAMMET_800 + 5,
                monarchLinnID.mob.MAMMET_800 + 6,
                monarchLinnID.mob.MAMMET_800 + 7,
                monarchLinnID.mob.MAMMET_800 + 8,
            },

            {
                monarchLinnID.mob.MAMMET_800 + 11,
                monarchLinnID.mob.MAMMET_800 + 12,
                monarchLinnID.mob.MAMMET_800 + 13,
                monarchLinnID.mob.MAMMET_800 + 14,
                monarchLinnID.mob.MAMMET_800 + 15,
                monarchLinnID.mob.MAMMET_800 + 16,
                monarchLinnID.mob.MAMMET_800 + 17,
                monarchLinnID.mob.MAMMET_800 + 18,
            },

            {
                monarchLinnID.mob.MAMMET_800 + 21,
                monarchLinnID.mob.MAMMET_800 + 22,
                monarchLinnID.mob.MAMMET_800 + 23,
                monarchLinnID.mob.MAMMET_800 + 24,
                monarchLinnID.mob.MAMMET_800 + 25,
                monarchLinnID.mob.MAMMET_800 + 26,
                monarchLinnID.mob.MAMMET_800 + 27,
                monarchLinnID.mob.MAMMET_800 + 28,
            },
        },

        spawned = false,
    },
}

return content:register()
