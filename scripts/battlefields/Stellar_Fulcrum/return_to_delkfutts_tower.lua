-----------------------------------
-- Area: Stellar Fulcrum
-- Name: ZM8 Return to Delkfutt's Tower
-- !pos -520 -4 17 179
-----------------------------------
local stellarFulcrumID = zones[xi.zone.STELLAR_FULCRUM]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.STELLAR_FULCRUM,
    battlefieldId         = xi.battlefield.id.RETURN_TO_DELKFUTTS_TOWER,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = '_4z0',
    exitNpcs              = { '_4z1', '_4z2', '_4z3' },
    missionArea           = xi.mission.log_id.ZILART,
    mission               = xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER,
    missionStatusArea     = xi.mission.log_id.ZILART,
    requiredMissionStatus = 2,
    title                 = xi.title.DESTROYER_OF_ANTIQUITY,
})

content.groups =
{
    {
        mobIds =
        {
            { stellarFulcrumID.mob.KAMLANAUT     },
            { stellarFulcrumID.mob.KAMLANAUT + 1 },
            { stellarFulcrumID.mob.KAMLANAUT + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
