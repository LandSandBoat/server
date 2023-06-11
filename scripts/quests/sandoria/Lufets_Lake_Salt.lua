-----------------------------------
-- Lufet's Lake Salt
-----------------------------------
-- Log ID: 0, Quest ID: 81
-- Nogelle: !gotoid 17727502
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LUFET_S_LAKE_SALT)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 600,
    title = xi.title.BEAN_CUISINE_SALTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Nogelle'] = quest:progressEvent(12),

            onEventFinish =
            {
                [12] = function(player, csid, option, npc)
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

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Nogelle'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { { xi.items.CHUNK_OF_LUFET_SALT, 3 } }) then
                        return quest:progressEvent(11)
                    end
                end,

                onTrigger = function(player, npc)
                    return quest:event(10)
                end,

            },

            onEventFinish =
            {
                [11] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Nogelle'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(522):replaceDefault()
                end,
            },
        },
    },
}

return quest
