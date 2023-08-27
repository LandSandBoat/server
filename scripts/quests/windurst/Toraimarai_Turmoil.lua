-----------------------------------
-- Toraimarai Turmoil
-----------------------------------
-- !addquest 2 16
-- Ohbiru-Dohbiru : !pos 23 -5 -193 238
-- Giddeus Spring : !pos -258 -2 -249 145
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TORAIMARAI_TURMOIL)

quest.reward =
{
    gil  = 4500,
    fame = 100,
    fameArea = xi.quest.fame_area.WINDURST,
    title = xi.title.CERTIFIED_RHINOSTERY_VENTURER
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLUE_RIBBON_BLUES) and
                player:getFameLevel(xi.quest.fame_area.WINDURST) >= 6 and
                not quest:getMustZone(player)
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] = quest:progressEvent(785, 4500, xi.keyItem.RHINOSTERY_CERTIFICATE, xi.items.STARMITE_SHELL),

            onEventFinish =
            {
                [785] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.RHINOSTERY_CERTIFICATE)
                    end
                end,
            },
        },
    },

    {
        --initial completion
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(786, 4500, xi.keyItem.RHINOSTERY_CERTIFICATE, xi.items.STARMITE_SHELL) -- Reminder text.
                end,
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.STARMITE_SHELL, 3 } }) then
                        return quest:progressEvent(791)
                    end
                end,
            },

            onEventFinish =
            {
                [791] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        --repeat completion
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Ohbiru-Dohbiru'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(795, 4500, 0, xi.items.STARMITE_SHELL) --dialog for repeat
                end,
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.STARMITE_SHELL, 3 } }) then
                        return quest:progressEvent(791)
                    end
                end,
            },

            onEventFinish =
            {
                [791] = function(player, csid, option, npc)
                    player:confirmTrade()
                    --From previous implementation, award 100 fame on first completion,
                    -- and 50 fame for any subsequent trade.
                    player:addFame(xi.quest.fame_area.WINDURST, 50)
                end,
            },
        },
    },
}

return quest
