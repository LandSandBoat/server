-----------------------------------
-- Path of Blood
-- Aht Uhrgan Mission 37
-----------------------------------
-- !addmission 4 36
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.PATH_OF_BLOOD)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.STIRRINGS_OF_WAR },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3131, 0, 1, 0, 0, 0, 0, 0)
                end,
            },

            onZoneIn = function(player, prevZone)
                if player:getMissionStatus(mission.areaId) == 1 then
                    return 3220
                end
            end,

            onEventUpdate =
            {
                [3131] = function(player, csid, option, npc)
                    player:updateEvent(2, 1, 0, 0, 0, 0, 0, 0, 0)
                end,
            },

            onEventFinish =
            {
                [3131] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                    player:setPos(97.936, 0, 0.109, 0, xi.zone.AHT_URHGAN_WHITEGATE) -- Force zone. Retail accurate.
                end,

                [3220] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:setLocalVar('Mission[4][37]mustZone', 1)
                        player:setCharVar('Mission[4][37]Timer', VanadielUniqueDay() + 1)
                    end
                end,
            },
        },
    },
}

return mission
