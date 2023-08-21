-----------------------------------
-- A Hawk in Repose
-- Wings of the Goddess Mission 29
-----------------------------------
-- !addmission 5 28
-- Weathered Gravestone : !pos 149.728 -5.109 -395.121 105
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.A_HAWK_IN_REPOSE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_BATTLE_OF_XARCABARD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BATALLIA_DOWNS] =
        {
            ['Weathered_Gravestone'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.item.LILAC) and
                        mission:getVar(player, 'Status') == 1
                    then
                        return mission:progressEvent(503, 0, 23, 1753, 0, 0, 0, 1, 3871)
                    end
                end,

                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Status') == 0 then
                        return mission:progressEvent(502, 105, 2, 300000, 0, 0, 0, 1, 22262)
                    end
                end,
            },

            onEventFinish =
            {
                [502] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                end,

                [503] = function(player, csid, option, npc)
                    player:confirmTrade()
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
