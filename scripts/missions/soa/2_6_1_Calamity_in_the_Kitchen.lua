-----------------------------------
-- Calamity in the Kitchen
-- Seekers of Adoulin M2-6-1
-----------------------------------
-- !addmission 12 27
-- Chalvava : !pos -318.000 -1.000 -318.000 258
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.CALAMITY_IN_THE_KITCHEN)

mission.reward =
{
    keyItem     = xi.ki.BOX_OF_ADOULINIAN_TOMATOES,
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.ARCIELAS_PROMISE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            ['Chalvava'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(344, 258)
                    else
                        return mission:progressEvent(345, 258)
                    end
                end,
            },

            onEventFinish =
            {
                [344] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    else
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [345] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:complete(player)
                    end
                end,
            },
        },
    },
}

return mission
