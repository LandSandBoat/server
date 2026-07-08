-----------------------------------
-- Warding Vampires
-----------------------------------
-- Log ID: 0, Quest ID: 79
-----------------------------------
-- Maloquedil : !pos 35 0.1 60 231
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES)

quest.reward =
{
    title = xi.title.VAMPIRE_HUNTER_D_MINUS,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Maloquedil'] =
            {
                onTrigger = function(player, npc)
                    if player:getFameLevel(xi.fameArea.SANDORIA) >= 3 then
                        return quest:progressEvent(24)
                    else
                        return quest:event(21)
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
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

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Maloquedil'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.BULB_OF_SHAMAN_GARLIC, 2 } }) then
                        return quest:progressEvent(23)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) == xi.questStatus.QUEST_ACCEPTED then
                        return quest:event(22)
                    else
                        return quest:event(24, { [7] = 1 })
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.WARDING_VAMPIRES) == xi.questStatus.QUEST_ACCEPTED then
                        quest:complete(player)
                    else
                        player:addFame(xi.fameArea.SANDORIA, 5)
                    end

                    npcUtil.giveCurrency(player, 'gil', 900)
                    player:confirmTrade()
                end,
            },
        },
    },
}

return quest
