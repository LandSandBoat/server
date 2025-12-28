-----------------------------------
-- Prevalence of Pirates
-- Aht Uhrgan Mission 30
-----------------------------------
-- !addmission 4 29
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PREVALENCE_OF_PIRATES)

mission.reward =
{
    keyItem     = xi.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.SHADES_OF_VENGEANCE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    return mission:event(3118, xi.besieged.getMercenaryRank(player), 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },
        },

        [xi.zone.ARRAPAGO_REEF] =
        {
            onZoneIn = function(player, prevZone)
                if player:getMissionStatus(mission.areaId) == 0 then -- Works from any survival guide.
                    return 13
                end
            end,

            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(14, 0, 4, 0, 0, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [13] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [14] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
