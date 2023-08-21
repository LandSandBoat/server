-----------------------------------
-- Knight of Gold
-- Aht Uhrgan Mission 4
-----------------------------------
-- !addmission 4 3
-- Cacaroon : !pos -72.026 0.000 -82.337 50
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.KNIGHT_OF_GOLD)

mission.reward =
{
    keyItem     = xi.ki.RAILLEFALS_LETTER,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.CONFESSIONS_OF_ROYALTY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Cacaroon'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 1 and
                        (npcUtil.tradeHasExactly(trade, { { 'gil', 1000 } }) or
                        npcUtil.tradeHasExactly(trade, xi.item.IMPERIAL_BRONZE_PIECE))
                    then
                        return mission:progressEvent(3022, { text_table = 0 })
                    end
                end,

                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(3035, { text_table = 0 })
                    elseif missionStatus == 1 then
                        return mission:progressEvent(3036, { text_table = 0 })
                    elseif missionStatus == 2 then
                        return mission:event(3023, { text_table = 0 }):replaceDefault()
                    end
                end,
            },

            ['Nadeey'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:event(3025, { text_table = 0 })
                    end
                end,
            },

            ['Naja_Salaheem'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(3021, { text_table = 0 })
                    end
                end,
            },

            onTriggerAreaEnter =
            {
                [4] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return mission:progressEvent(3024, { text_table = 0 })
                    end
                end,

                [5] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(3026, { text_table = 0 })
                    end
                end,
            },

            onEventFinish =
            {
                [3022] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [3024] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,

                [3026] = function(player, csid, option, npc)
                    mission:complete(player)
                end,

                [3035] = function(player, csid, option, npc)
                    if option == 1 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },
    },
}

return mission
