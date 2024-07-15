-----------------------------------
-- Area: Monarch Linn
-- Name: The Savage
-----------------------------------
local monarchLinnID = zones[xi.zone.MONARCH_LINN]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.MONARCH_LINN,
    battlefieldId = xi.battlefield.id.SAVAGE,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 50,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = 'SD_Entrance',
    exitNpcs      = { 'SD_BCNM_Exit_1', 'SD_BCNM_Exit_2', 'SD_BCNM_Exit_3' },
    missionArea   = xi.mission.log_id.COP,
    mission       = xi.mission.id.cop.THE_SAVAGE,
    requiredVar   = 'Mission[6][418]Status',
    requiredValue = 1,

    grantXP = 1500,
    title   = xi.title.MIST_MELTER,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    -- NOTE: In cases for testing or something may have happened to the player's
    -- prevZone value, ensure we entered the "correct" way by confirming that
    -- they did not enter from Site A01.

    return player:getPreviousZone() ~= xi.zone.RIVERNE_SITE_A01
end

content.groups =
{
    {
        mobIds =
        {
            { monarchLinnID.mob.OURYU     },
            { monarchLinnID.mob.OURYU + 1 },
            { monarchLinnID.mob.OURYU + 2 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
