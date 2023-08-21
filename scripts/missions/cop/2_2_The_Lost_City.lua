-----------------------------------
-- The Lost City
-- Promathia 2-2
-----------------------------------
-- !addmission 6 218
-- Despachiaire   : !pos 108 -40 -83 26
-- Sewer Entrance : !pos 28 -12 44 26
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['_0q1'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:progressEvent(103)
                    end
                end,
            },

            ['Arquil'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(291):replaceDefault()
                    end
                end,
            },

            ['Despachiaire'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(102)
                    else
                        return mission:event(106, 1):replaceDefault()
                    end
                end,
            },

            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(360):replaceDefault()
                    end
                end,
            },

            ['Liphatte'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 1 then
                        return mission:event(301):replaceDefault()
                    end
                end,
            },

            onEventFinish =
            {
                [102] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [103] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId) and
                not player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Arquil']       = mission:event(291):replaceDefault(),
            ['Despachiaire'] = mission:event(106):replaceDefault(),
        },
    },
}

return mission
