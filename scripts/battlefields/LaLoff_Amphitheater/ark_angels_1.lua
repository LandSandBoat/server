-----------------------------------
-- Area: LaLoff Amphitheater
-- Name: Ark Angels 1 (Hume)
-----------------------------------
local laLoffID = zones[xi.zone.LALOFF_AMPHITHEATER]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.LALOFF_AMPHITHEATER,
    battlefieldId         = xi.battlefield.id.ARK_ANGELS_1,
    isMission             = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = 'qm1_1',
    exitNpc               = 'qm2',
    missionArea           = xi.mission.log_id.ZILART,
    mission               = xi.mission.id.zilart.ARK_ANGELS,
    missionStatusArea     = xi.mission.log_id.ZILART,
    requiredMissionStatus = 1,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return not player:hasKeyItem(xi.ki.SHARD_OF_APATHY)
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
            { laLoffID.mob.ARK_ANGEL_HM     },
            { laLoffID.mob.ARK_ANGEL_HM + 1 },
            { laLoffID.mob.ARK_ANGEL_HM + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
