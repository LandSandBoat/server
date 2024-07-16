-----------------------------------
-- Teak Me to the Stars
-----------------------------------
-- Log ID: 1, Quest ID: 79
-- Raibaht : !gotoid 17748012
-----------------------------------

local quest = Quest:new(xi.questLog.BASTOK, xi.quest.id.bastok.TEAK_ME_TO_THE_STARS)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.BASTOK,
    gil      = 2100,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.BASTOK) >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            onTrigger = function(player, npc)
                local option = 0
                if player:hasCompletedMission(xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING) then
                    option = 2 -- additional dialogue regarding Crystal propulsion unit and hooded scientists as mentioned in cop wyrmking mission
                end

                return quest:progressEvent(864, 0, xi.item.GARHADA_TEAK_LUMBER, 0, 0, 0, 0, option)
            end,

            onEventFinish =
            {
                [864] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.METALWORKS] =
        {
            ['Raibaht'] =
            {
                onTrigger = function(player, npc)
                    -- Cycle between event 871 and default 501
                    return quest:event(871, 0, xi.item.GARHADA_TEAK_LUMBER):setPriority(10)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.item.GARHADA_TEAK_LUMBER) then
                        return quest:event(865)
                    end
                end,
            },

            onEventFinish =
            {
                [865] = function(player, csid, option, npc)
                    player:confirmTrade()
                    xi.quest.setMustZone(player, xi.questLog.BASTOK, xi.quest.id.bastok.HYPER_ACTIVE)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
