-----------------------------------
-- In a Pickle
-----------------------------------
-- !addquest 2 5
-- Hariga-Origa : !pos -70.244,-3.800,-4.439
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.IN_A_PICKLE)

quest.reward =
{
    gil = 200,
    fame = 8,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] = quest:progressEvent(654, 0, xi.items.RARAB_TAIL),

            onEventFinish =
            {
                [654] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SMOOTH_STONE) then
                        local rand = math.random(1, 4)
                        if rand <= 2 then
                            return quest:progressEvent(659)
                        elseif rand == 3 then
                            player:confirmTrade()
                            return quest:progressEvent(657) -- IN A PICKLE: Too Light
                        elseif rand == 4 then
                            player:confirmTrade()
                            return quest:progressEvent(658) -- IN A PICKLE: Too Small
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:progressEvent(655, 0, xi.items.RARAB_TAIL) -- IN A PICKLE + RARAB TAIL: Quest Objective Reminder
                end,
            },

            onEventFinish =
            {
                [659] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                        player:needToZone(true)
                        npcUtil.giveItem(player, xi.items.BONE_HAIRPIN)
                        player:addFame(xi.quest.fame_area.WINDURST, 75)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Chamama'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SMOOTH_STONE) then
                        local rand = math.random(1, 4)
                        if rand <= 2 then
                            return quest:progressEvent(662, 200)
                        elseif rand == 3 then
                            player:confirmTrade()
                            return quest:progressEvent(657) -- IN A PICKLE: Too Light
                        elseif rand == 4 then
                            player:confirmTrade()
                            return quest:progressEvent(658) -- IN A PICKLE: Too Small
                        end
                    end
                end,

                onTrigger = function(player, npc)
                    local needToZone = player:needToZone()
                    if needToZone then
                        return quest:progressEvent(660) -- IN A PICKLE: After Quest
                    elseif not needToZone and quest:getVar(player, 'repeat') ~= 1 then
                        return quest:progressEvent(661) -- IN A PICKLE: Repeatable Quest Begin
                    end
                end,
            },

            onEventFinish =
            {
                [661] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'repeat', 1)
                    end
                end,

                [662] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:needToZone(true)
                    quest:setVar(player, 'repeat', 0)
                    player:addFame(xi.quest.fame_area.WINDURST, 8)
                end,
            },
        },
    },
}

return quest
