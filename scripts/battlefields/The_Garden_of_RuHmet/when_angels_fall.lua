-----------------------------------
-- Area: The_Garden_of_RuHmet
-- Name: When Angels Fall
-----------------------------------
local ruHmetID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.THE_GARDEN_OF_RUHMET,
    battlefieldId = xi.battlefield.id.WHEN_ANGELS_FALL,
    canLoseExp    = false,
    isMission     = true,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 0,
    area          = 1,
    entryNpc      = '_0z0',
    missionArea   = xi.mission.log_id.COP,
    mission       = xi.mission.id.cop.WHEN_ANGELS_FALL,
    requiredVar   = 'PromathiaStatus',
    requiredValue = 4,

    grantXP = 1000,
})

function content:onEventFinishWin(player, csid, option, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.WHEN_ANGELS_FALL and
        player:getCharVar('PromathiaStatus') == 4
    then
        player:setCharVar('PromathiaStatus', 5)
    end

    player:setPos(420, 0, 445, 192)
end

content.groups =
{
    {
        mobIds =
        {
            ruHmetID.mob.IXZDEI_RDM,
            ruHmetID.mob.IXZDEI_RDM + 1,
            ruHmetID.mob.IXZDEI_RDM + 2,
            ruHmetID.mob.IXZDEI_RDM + 3,
        },

        superlink = true,
        allDeath  = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
