-----------------------------------
-- The Elvaan Goldsmith
-----------------------------------
-- Log ID: 1, Quest ID: 13
-- Michea : !pos -298 -16 -157 235
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELVAAN_GOLDSMITH)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    gil      = 180,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] = quest:progressEvent(215),

            onEventFinish =
            {
                [215] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- These functions check the status of ~= QUEST_AVAILABLE to support repeating
    -- the quest.  Does not have to be flagged again to complete an additional time.
    {
        check = function(player, status, vars)
            return status ~= QUEST_AVAILABLE or
            player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_RETURN_OF_THE_ADVENTURER) == QUEST_COMPLETED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Michea'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { { xi.items.COPPER_INGOT, 1 } }) and
                        not player:needToZone()
                    then
                        return quest:progressEvent(216)
                    end
                end,
            },

            onEventFinish =
            {
                [216] = function(player, csid, option, npc)
                    player:confirmTrade()
                    if not player:hasCompletedQuest(quest.areaId, quest.questId) then
                        quest:complete(player)
                        player:needToZone(true)
                    else
                        player:addFame(xi.quest.fame_area.BASTOK, 5)
                        npcUtil.giveCurrency(player, "gil", xi.settings.main.GIL_RATE * 180)
                        player:needToZone(true)
                    end
                end,
            },
        },
    },
}

return quest
