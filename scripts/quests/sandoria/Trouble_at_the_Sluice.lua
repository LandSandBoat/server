-----------------------------------
-- Trouble at the Sluice
-----------------------------------
-- !addquest 0 68
-- Belgidiveau: !pos -98 0 69 231
-- Novalmauge : !pos 70 -24 21 167
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TROUBLE_AT_THE_SLUICE)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.items.HEAVY_AXE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 3 and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_RUMOR)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Belgidiveau'] = quest:progressEvent(57),

            onEventFinish =
            {
                [57] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Belgidiveau'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.NEUTRALIZER) then
                        return quest:event(55)
                    elseif player:hasKeyItem(xi.ki.NEUTRALIZER) then
                        return quest:progressEvent(56)
                    end
                end,

            },

            onEventFinish =
            {
                [56] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.NEUTRALIZER)
                    end
                end,
            },
        },

        [xi.zone.BOSTAUNIEUX_OUBLIETTE] =
        {
            ['Novalmauge'] =
            {

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.tradeHasExactly(trade, xi.items.DAHLIA)
                    then
                        return quest:progressEvent(17)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(15)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(16)
                    else
                        return quest:event(10)
                    end
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [17] = function(player, csid, option, npc)
                    player:tradeComplete()
                    npcUtil.giveKeyItem(player, xi.ki.NEUTRALIZER)
                end,
            },
        },
    },
}

return quest
