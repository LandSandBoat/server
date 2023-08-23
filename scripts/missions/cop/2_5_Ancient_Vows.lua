-----------------------------------
-- Ancient Vows
-- Promathia 2-5
-----------------------------------
-- !addmission 6 248
-- Dilapidated Gate : !pos -259 -30 276 25
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)

mission.reward =
{
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] = mission:event(128):replaceDefault(),
        },

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p2'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(6)
                    end
                end,
            },

            onEventFinish =
            {
                [6] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,
            },
        },

        [xi.zone.RIVERNE_SITE_A01] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 100
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 2)
                end,
            },
        },

        [xi.zone.MONARCH_LINN] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        mission:getVar(player, 'Status') == 2 and
                        player:getLocalVar('battlefieldWin') == 960
                    then
                        mission:complete(player)
                        player:setPos(694, -5.5, -619, 74, 107) -- South Gustaberg
                    end
                end,
            },
        },
    },
}

return mission
