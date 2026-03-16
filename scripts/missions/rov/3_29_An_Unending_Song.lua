-----------------------------------
-- An Unending Song
-- Rhapsodies of Vana'diel Mission 3-29
-----------------------------------
-- !addmission 13 212
-- Zone into any starting nation with a Mog House entrance
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.AN_UNENDING_SONG)

mission.reward =
{
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.A_DEEP_SLEEP },
}

local nationZones =
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

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,
    },
}

---@type ZoneSection
local rovZoneInEvent =
{
    onZoneIn = function(player, prevZone)
        -- TODO: Verify event ID from packet captures
        mission:complete(player)
    end,
}

for _, zoneId in ipairs(nationZones) do
    mission.sections[1][zoneId] = rovZoneInEvent
end

return mission
