-----------------------------------
-- Area: LaLoff Amphitheater
-- Name: Ark Angels 4 (Elvaan)
-----------------------------------
local laLoffID = zones[xi.zone.LALOFF_AMPHITHEATER]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.LALOFF_AMPHITHEATER,
    battlefieldId         = xi.battlefield.id.ARK_ANGELS_4,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 3,
    entryNpc              = 'qm1_4',
    exitNpc               = 'qm2',
    missionArea           = xi.mission.log_id.ZILART,
    mission               = xi.mission.id.zilart.ARK_ANGELS,
    missionStatusArea     = xi.mission.log_id.ZILART,
    requiredMissionStatus = 1,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return not player:hasKeyItem(xi.ki.SHARD_OF_ARROGANCE)
end

function content:onBattlefieldLoss(player, battlefield)
    local exitPosition = battlefield:getID() - xi.battlefield.id.ARK_ANGELS_1
    player:startEvent(32002, 0, 0, 0, 0, 0, exitPosition, 180)
end

function content.onExitTrigger(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        local exitPosition = battlefield:getID() - xi.battlefield.id.ARK_ANGELS_1
        return content:event(32003, 0, 0, 0, 0, exitPosition, 180)
    end
end

content.groups =
{
    {
        mobIds =
        {
            { laLoffID.mob.ARK_ANGEL_EV     },
            { laLoffID.mob.ARK_ANGEL_EV + 1 },
            { laLoffID.mob.ARK_ANGEL_EV + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
