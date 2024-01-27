-----------------------------------
-- The Savage
-- Promathia 4-2
-----------------------------------
-- !addmission 6 418
-- Dilapidated Gate : !pos -259 -30 276 25
-- Justinius        : !pos 76 -34 68 26
-----------------------------------

local mission = Mission:new(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)

mission.reward =
{
    title       = xi.title.NAGMOLADAS_UNDERLING,
    nextMission = { xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.MISAREAUX_COAST] =
        {
            ['_0p2'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(8)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    if option == 1 then
                        mission:setVar(player, 'Status', 1)
                        player:setPos(729.749, -20.325, 407.153, 90, 29)
                    end
                end,
            },
        },

        [xi.zone.MONARCH_LINN] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getLocalVar('battlefieldWin') == 961 and
                        mission:getVar(player, 'Status') == 1
                    then
                        mission:setVar(player, 'Status', 2)
                    end
                end,
            },
        },

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Justinius'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 2 then
                        return mission:progressEvent(110)
                    else
                        return mission:event(130):importantEvent()
                    end
                end,
            },

            onEventFinish =
            {
                [110] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
