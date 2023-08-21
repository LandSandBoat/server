-----------------------------------
-- Fate's Call
-- Rhapsodies of Vana'diel Mission 1-12
-----------------------------------
-- !addmission 13 28
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND },
}

-- TODO: We use this table in the first mission as well, move this.
local rovEntryZones =
{
    xi.zone.BASTOK_MARKETS,
    xi.zone.BASTOK_MINES,
    xi.zone.NORTHERN_SAN_DORIA,
    xi.zone.PORT_BASTOK,
    xi.zone.PORT_SAN_DORIA,
    xi.zone.PORT_WINDURST,
    xi.zone.SOUTHERN_SAN_DORIA,
    xi.zone.WINDURST_WALLS,
    xi.zone.WINDURST_WATERS,
    xi.zone.WINDURST_WOODS,
}

mission.sections    = {}
mission.sections[1] = {}

mission.sections[1].check = function(player, currentMission, missionStatus, vars)
    local pNation = player:getNation()

    return currentMission == mission.missionId and
        (
            player:getRank(pNation) > 5 or
            (player:getCurrentMission(pNation) == xi.mission.id.nation.SHADOW_LORD and player:getMissionStatus(pNation) >= 4)
        )
end

local rovZoneInEvent =
{
    onZoneIn =
    {
        function(player, prevZone)
            return 30036
        end,
    },

    onEventFinish =
    {
        [30036] = function(player, csid, option, npc)
            mission:complete(player)
        end,
    },
}

for _, zoneId in ipairs(rovEntryZones) do
    mission.sections[1][zoneId] = rovZoneInEvent
end

return mission
