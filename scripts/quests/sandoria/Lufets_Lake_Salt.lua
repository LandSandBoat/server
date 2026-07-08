-----------------------------------
-- Lufets Lake Salt
-----------------------------------
-- Log ID: 0, Quest ID: 81
-----------------------------------
-- Nogelle : !pos -70 -5.5 -33 232
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.LUFETS_LAKE_SALT)

quest.reward =
{
    gil   = 600,
    title = xi.title.BEAN_CUISINE_SALTER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
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
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Nogelle'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.CHUNK_OF_LUFET_SALT, 3 } }) then
                        return quest:progressEvent(11)
                    end
                end,

                onTrigger = quest:event(10),
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
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Nogelle'] = quest:event(522):replaceDefault(),
        },
    },
}

return quest
