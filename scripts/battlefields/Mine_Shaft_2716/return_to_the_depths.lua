-----------------------------------
-- Return to the Depths
-- Mine Shaft #2716 quest battlefield
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId        = xi.zone.MINE_SHAFT_2716,
    battlefieldId = xi.battlefield.id.RETURN_TO_THE_DEPTHS,
    canLoseExp    = false,
    maxPlayers    = 6,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = '_0d0',
    exitNpcs      = { '_0d1', '_0d2', '_0d3' },

    questArea     = xi.questLog.BASTOK,
    quest         = xi.quest.id.bastok.RETURN_TO_THE_DEPTHS,

    requiredVar   = 'Quest[1][78]prog',
    requiredValue = 9,
})

function content:onEventFinishWin(player, csid, option, npc)
    npcUtil.giveCurrency(player, 'gil', 10000)
end

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
                mineshaftID.mob.TWILOTAK + 13,
            },

            {
                mineshaftID.mob.TWILOTAK + 14,
                mineshaftID.mob.TWILOTAK + 15,
                mineshaftID.mob.TWILOTAK + 16,
                mineshaftID.mob.TWILOTAK + 17,
                mineshaftID.mob.TWILOTAK + 18,
                mineshaftID.mob.TWILOTAK + 19,
            },
        },

        death = function(battlefield, mob)
            local mobId = mob:getID()
            if mobId == mineshaftID.mob.TWILOTAK then -- Twilotak is the only required kill to clear
                battlefield:setStatus(xi.battlefield.status.WON)
            end
        end
    },
}

return content:register()
