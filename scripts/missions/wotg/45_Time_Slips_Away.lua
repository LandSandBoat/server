-----------------------------------
-- Time Slips Away
-- Wings of the Goddess Mission 45
-----------------------------------
-- !addmission 5 44
-- Veridical Conflux : !pos -142.279 -6.749 585.239 89
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.TIME_SLIPS_AWAY)

mission.reward =
{
    keyItem     = xi.ki.BOTTLED_PUNCH_BUG,
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.WHEN_WILLS_COLLIDE },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.GRAUBERG_S] =
        {
            ['Veridical_Conflux'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.PUNCH_BUG) then
                        return mission:progressEvent(35, 64, 23, 1756, 0, 0, 0, 0, 0)
                    end
                end,

                onTrigger = mission:event(40, 89, 10, 1, 0, 0, 0, 0, 0),
            },

            onEventFinish =
            {
                [35] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return mission
