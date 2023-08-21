-----------------------------------
-- A Mercenary Life
-- Aht Uhrgan Mission 8
-----------------------------------
-- !addmission 4 7
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.A_MERCENARY_LIFE)

mission.reward =
{
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.UNDERSEA_SCOUTING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Naja_Salaheem'] = mission:event(3029, 0, 1, 1, 0, 0, 0, 0, 0, 0)
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                not mission:getMustZone(player)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            -- NOTE: Check Naja after zoning

            onTriggerAreaEnter =
            {
                [3] = function(player, triggerArea)
                    return mission:progressEvent(3050, 3, 3, 3, 3, 3, 3, 3, 3, 0)
                end,
            },

            onEventUpdate =
            {
                [3050] = function(player, csid, option, npc)
                    local dialogStatus = mission:getLocalVar(player, 'Dialog')

                    if option == 1 then
                        if dialogStatus == 0 then
                            mission:setLocalVar(player, 'Dialog', 1)
                            player:updateEvent(1, 0, 0, 0, 0, 0, 0, 0)
                        else
                            player:updateEvent(3, 0, 0, 0, 0, 0, 0, 0)
                        end
                    elseif option == 2 then
                        if dialogStatus == 0 then
                            mission:setLocalVar(player, 'Dialog', 1)
                            player:updateEvent(2, 0, 0, 0, 0, 0, 0, 0)
                        else
                            player:updateEvent(3, 0, 0, 0, 0, 0, 0, 0)
                        end
                    end
                end,
            },

            onEventFinish =
            {
                [3050] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
