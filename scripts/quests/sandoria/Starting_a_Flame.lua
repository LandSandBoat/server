-----------------------------------
-- Starting a Flame
-----------------------------------
-- Log ID: 0, Quest ID: 77
-----------------------------------
-- Legata : !pos 82 0 116 230
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME)

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Legata'] = quest:progressEvent(37),

            onEventFinish =
            {
                [37] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Legata'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.FLINT_STONE, 4 } }) then
                        return quest:progressEvent(36)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME) == xi.questStatus.QUEST_ACCEPTED then
                        return quest:event(35)
                    else
                        return quest:event(37, { [7] = 1 })
                    end
                end,
            },

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.STARTING_A_FLAME) == xi.questStatus.QUEST_ACCEPTED then
                        quest:complete(player)
                    else
                        player:addFame(xi.fameArea.SANDORIA, 5)
                    end

                    npcUtil.giveCurrency(player, 'gil', 100)
                    player:confirmTrade()
                end,
            },
        },
    },
}

return quest
