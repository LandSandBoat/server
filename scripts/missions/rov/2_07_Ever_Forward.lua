-----------------------------------
-- Ever Forward
-- Rhapsodies of Vana'diel Mission 2-7
-----------------------------------
-- !addmission 13 56
-----------------------------------
local whitegateID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ROV, xi.mission.id.rov.EVER_FORWARD)

mission.reward =
{
    item = xi.item.CIPHER_OF_NASHMEIRAS_ALT_EGO_II,
    nextMission = { xi.mission.log_id.ROV, xi.mission.id.rov.REUNITED },
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

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Imperial_Whitegate'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.ROYAL_PUPPETEER
                    then
                        -- NOTE: The first 4 parameters for this event change the available dialogue.  This remains all zeroes
                        -- until the player has progressed at least past TOAU21.  No changes are implemented at this time until
                        -- viable captures are obtained.

                        return mission:progressEvent(166, { text_table = 0 })
                    else
                        return mission:messageSpecial(whitegateID.text.UNABLE_TO_PROGRESS_ROV)
                    end
                end,
            },

            onEventFinish =
            {
                [166] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.APHMAUS_LIGHT)
                        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.REUNITED)
                    end
                end,
            },
        },
    },
}

mission.sections[2] = {}

mission.sections[2].check = function(player, currentMission, missionStatus, vars)
    return currentMission == mission.missionId and
        player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.ROYAL_PUPPETEER
end

local rovZoneInEvent =
{
    onZoneIn =
    {
        function(player, prevZone)
            return 30039
        end,
    },

    onEventFinish =
    {
        [30039] = function(player, csid, option, npc)
            player:completeMission(mission.areaId, mission.missionId)
            player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.APHMAUS_LIGHT)
        end,
    },
}

for _, zoneId in ipairs(nationZones) do
    mission.sections[2][zoneId] = rovZoneInEvent
end

return mission
