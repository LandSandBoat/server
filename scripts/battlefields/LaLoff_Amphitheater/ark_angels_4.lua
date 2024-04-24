-----------------------------------
-- Area: LaLoff Amphitheater
-- Name: Ark Angels 4 (Elvaan)
-----------------------------------
local laLoffID = zones[xi.zone.LALOFF_AMPHITHEATER]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.LALOFF_AMPHITHEATER,
    battlefieldId         = xi.battlefield.id.ARK_ANGELS_4,
    isMission             = true,
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
    local exitPosition = tonumber(string.sub(entryNpc, -1)) - 1
    player:startEvent(32002, 0, 0, 0, 0, 0, exitPosition, 180)
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
