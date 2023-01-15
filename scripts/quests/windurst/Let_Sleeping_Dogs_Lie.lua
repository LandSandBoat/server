-----------------------------------
-- Let Sleeping Dogs Die
-----------------------------------
-- !addquest 2 46
-- Paku-Nakku !gotoid 17752127
-- Maabu-Sonbu !gotoid 17760275
-- ??? QM 1 !gotoid 17224342
-- Pechiru-Mashiru !gotoid 17752116

-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.LET_SLEEPING_DOGS_LIE)

quest.reward =
{
    item = xi.items.HYPNO_STAFF,
    fame = 75,
    fameArea = xi.quest.fame_area.WINDURST,
    title = xi.title.SPOILSPORT,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
            player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.REAP_WHAT_YOU_SOW) ~= QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Paku-Nakku'] = quest:progressEvent(481),

            onEventFinish =
            {
                [481] = function(player, csid, option, npc)
                    quest:begin(player)
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
            ['Mashuu-Ajuu'] = quest:event(483),
            ['Akkeke'] = quest:event(484),
            ['Kirara'] = quest:event(485),
            ['Rukuku'] = quest:event(487),
            ['Koko Lihzeh'] = quest:event(488),
            ['Chomoro-Kyotoro'] = quest:event(489),
            ['Paku-Nakku'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.BUNCH_OF_BLAZING_PEPPERS) and quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(494)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(499)
                    else
                        return quest:event(482)
                    end
                end,

            },
            ['Pechiru-Mashiru'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 2 then
                        return quest:progressEvent(495, 4155, 1102, 1, 50617851, 2729760, 0)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:event(496)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:progressEvent(497)
                    end
                end,
            },

            onEventFinish =
            {
                [494] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
                [495] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                end,
                [497] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
                [499] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 4)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Maabu-Sonbu'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(319, 653392653, 4155, 1102, 1020) -- 0, 0, 0, 0)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        return quest:event(321, 653393447, 1102, 0, 0, 67108863, 41513848, 4095, 4)
                    else
                        return quest:event(320, 653392653, 4155, 1102) -- 1020, 0, 0, 0, 0)
                    end
                end,
            },

            onEventFinish =
            {
                [319] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['qm1'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.SICKLE) then
                        local chance = math.random(1, 5)
                        if chance <= 2 then
                            npcUtil.giveItem(player, xi.items.BUNCH_OF_BLAZING_PEPPERS)
                            player:tradeComplete(false)
                            return player:startEvent(12, 1102, 0, 0, xi.items.BUNCH_OF_BLAZING_PEPPERS)-- successful no break
                        elseif chance == 3 then
                            npcUtil.giveItem(player, xi.items.BUNCH_OF_BLAZING_PEPPERS)
                            player:confirmTrade()
                            return player:startEvent(12, 1102, 1, 0, xi.items.BUNCH_OF_BLAZING_PEPPERS) -- successful but breaks
                        elseif chance == 4 then
                            player:confirmTrade()
                            return player:startEvent(12, 0, 1, 0) -- unsuccessful and breaks
                        elseif chance == 5 then
                            player:tradeComplete(false)
                            return player:startEvent(12, 0, 0, 0) -- unsuccessful and no break
                        end
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
            ['Chomoro-Kyotoro'] =
            {
                onTrigger = function(player, npc)
                    if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.HAT_IN_HAND) ~= QUEST_ACCEPTED then
                        quest:event(498)
                    end
                end,
            },
        }
    },
}

return quest
