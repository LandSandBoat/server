-----------------------------------
-- Rank 2 Mission
-- Waughroon Shrine mission battlefield
-- !pos -345 104 -260 144
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------

local content = Battlefield:new({
    zoneId        = xi.zone.WAUGHROON_SHRINE,
    battlefieldId = xi.battlefield.id.RANK_2_MISSION_2,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 25,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = 'BC_Entrance',
    exitNpc       = 'Burning_Circle',
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    local isCurrentMission    = player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2 or
        player:getCurrentMission(xi.mission.log_id.WINDURST) == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2
    local currentRequirements = isCurrentMission
    local nonRegistrantReqs   = player:hasCompletedMission(player:getNation(), 5) or currentRequirements

    return (not isRegistrant and nonRegistrantReqs) or currentRequirements
end

function content:checkSkipCutscene(player)
    return player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) or
        player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2) or
        (player:getMissionStatus(player:getNation()) > 9 and
        (
            player:getCurrentMission(xi.mission.log_id.WINDURST) == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2 or
            player:getCurrentMission(xi.mission.log_id.SANDORIA) == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2
        ))
end

content.groups =
{
    {
        mobIds =
        {
            { waughroonID.mob.DARK_DRAGON,     waughroonID.mob.DARK_DRAGON + 1 },
            { waughroonID.mob.DARK_DRAGON + 2, waughroonID.mob.DARK_DRAGON + 3 },
            { waughroonID.mob.DARK_DRAGON + 4, waughroonID.mob.DARK_DRAGON + 5 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
