-----------------------------------
-- Shady Business
-----------------------------------
-- Log ID: 1, Quest ID: 8
-- Talib : !pos -101.133 4.649 28.803 236
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)

quest.reward =
{
    fame     = 80,
    fameArea = xi.quest.fame_area.NORG,
    gil      = 350,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status >= QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
        end,

        [xi.zone.PORT_BASTOK] =
        {
            ['Talib'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(90)
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.CHUNK_OF_ZINC_ORE, 4 } }) then
                        return quest:progressEvent(91)
                    end
                end,

            },

            onEventFinish =
            {
                [90] = function(player, csid, option, npc)
                    -- We can complete the quest without accepting it, but quest will NOT get re-accepted after completed.
                    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS) == QUEST_AVAILABLE then
                        quest:begin(player)
                    end
                end,

                [91] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,

            },
        },
    },
}

return quest
