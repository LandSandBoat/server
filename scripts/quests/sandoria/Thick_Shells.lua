-----------------------------------
-- Thick Shells
-----------------------------------
-- LogID: 0 QuestID: 117
-----------------------------------

local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS)
local ID = zones[xi.zone.PORT_SAN_DORIA]

quest.reward =
{
    gil   = 750,
    title = xi.title.BUG_CATCHER,
    fame  = 30,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 2
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Vounebariont'] = quest:progressEvent(516),

            onEventFinish =
            {
                [516] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status ~= xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Vounebariont'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS) == xi.questStatus.QUEST_ACCEPTED then
                        npc:showText(npc, ID.text.SHELL_REMINDER, xi.item.BEETLE_SHELL)
                        return quest:noAction()
                    else
                        npc:showText(npc, ID.text.BRING_MORE_SHELLS, xi.item.BEETLE_SHELL)
                        return quest:noAction()
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { xi.item.BEETLE_SHELL, 5 } }) then
                        return quest:progressEvent(514)
                    else
                        npc:showText(npc, ID.text.NOT_SHELLS)
                        return quest:noAction()
                    end
                end,

            },

            onEventFinish =
            {
                [514] = function(player, csid, option, npc)
                    if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THICK_SHELLS) == xi.questStatus.QUEST_ACCEPTED then
                        quest:complete(player)
                    else
                        player:addFame(xi.fameArea.SANDORIA, 5)
                        npcUtil.giveCurrency(player, 'gil', 750)
                    end

                    player:confirmTrade()
                end,

            },
        },
    },
}

return quest
