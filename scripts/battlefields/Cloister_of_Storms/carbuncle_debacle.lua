-----------------------------------
-- Area: Cloister of Storms
-- BCNM: Carbuncle Debacle
-----------------------------------
local cloisterOfStormsID = zones[xi.zone.CLOISTER_OF_STORMS]
-----------------------------------

local content = BattlefieldQuest:new({
    zoneId           = xi.zone.CLOISTER_OF_STORMS,
    battlefieldId    = xi.battlefield.id.CARBUNCLE_DEBACLE_CLOISTER_OF_STORMS,
    canLoseExp       = false,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(30),
    index            = 1,
    entryNpc         = 'LP_Entrance',
    exitNpc          = 'Lightning_Protocrystal',
    requiredItems    = { xi.item.LIGHTNING_PENDULUM },

    questArea     = xi.questLog.WINDURST,
    quest         = xi.quest.id.windurst.CARBUNCLE_DEBACLE,
    requiredVar   = 'CarbuncleDebacleProgress',
    requiredValue = 3,
})

function content:onEventFinishWin(player, csid, option, npc)
    if player:getCharVar('CarbuncleDebacleProgress') == 3 then
        player:setCharVar('CarbuncleDebacleProgress', 4)
    end
end

content.groups =
{
    {
        mobIds =
        {
            {
                cloisterOfStormsID.mob.LIGHTNING_GREMLIN,
                cloisterOfStormsID.mob.LIGHTNING_GREMLIN + 1,
            },

            {
                cloisterOfStormsID.mob.LIGHTNING_GREMLIN + 2,
                cloisterOfStormsID.mob.LIGHTNING_GREMLIN + 3,
            },

            {
                cloisterOfStormsID.mob.LIGHTNING_GREMLIN + 4,
                cloisterOfStormsID.mob.LIGHTNING_GREMLIN + 5,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
