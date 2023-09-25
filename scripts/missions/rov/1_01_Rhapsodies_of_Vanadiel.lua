-----------------------------------
-- Rhapsodies of Vana'diel
-- Rhapsodies of Vana'diel Mission 1-1
-----------------------------------
-- NOTE: xi.mission.id.rov.RHAPSODIES_OF_VANADIEL is set by default
-- !addmission 13 0
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE },
}

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
    return currentMission == mission.missionId and
        xi.settings.main.ENABLE_ROV == 1 and
        player:getMainLvl() >= 3 and
        not player:isInMogHouse()
end

local rovZoneInEvent =
{
    onZoneIn =
    {
        function(player, prevZone)
            return 30035
        end,
    },

    onEventFinish =
    {
        [30035] = function(player, csid, option, npc)
            mission:complete(player)
        end,
    },
}

for _, zoneId in ipairs(rovEntryZones) do
    mission.sections[1][zoneId] = rovZoneInEvent
end

return mission
