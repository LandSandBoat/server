-----------------------------------
-- Return to the Depths
-- Quest 1 78
-- Uncapped on retail, but capped at 40 in 75 era.
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.MINE_SHAFT_2716,
    battlefieldId = xi.battlefield.id.RETURN_TO_THE_DEPTHS,
    maxPlayers    = 6,
    levelCap      = 99,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = '_0d0',
    exitNpcs      = { '_0d1', '_0d2', '_0d3' },

    questArea     = xi.questLog.BASTOK,
    quest         = xi.quest.id.bastok.RETURN_TO_THE_DEPTHS,
    requiredVar   = 'Quest[1][78]Prog',
    requiredValue = 9,
})

content.groups =
{
    {
        mobIds =
        {
            {
                mineshaftID.mob.TWILOTAK,
                mineshaftID.mob.TWILOTAK + 1,
                mineshaftID.mob.TWILOTAK + 2,
                mineshaftID.mob.TWILOTAK + 3,
                mineshaftID.mob.TWILOTAK + 4,
                mineshaftID.mob.TWILOTAK + 5,
                mineshaftID.mob.TWILOTAK + 6,
            },

            {
                mineshaftID.mob.TWILOTAK + 7,
                mineshaftID.mob.TWILOTAK + 8,
                mineshaftID.mob.TWILOTAK + 9,
                mineshaftID.mob.TWILOTAK + 10,
                mineshaftID.mob.TWILOTAK + 11,
                mineshaftID.mob.TWILOTAK + 12,
                mineshaftID.mob.TWILOTAK + 13,
            },

            {
                mineshaftID.mob.TWILOTAK + 14,
                mineshaftID.mob.TWILOTAK + 15,
                mineshaftID.mob.TWILOTAK + 16,
                mineshaftID.mob.TWILOTAK + 17,
                mineshaftID.mob.TWILOTAK + 18,
                mineshaftID.mob.TWILOTAK + 19,
                mineshaftID.mob.TWILOTAK + 20,
            },
        },

        superlink = true,

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
