-----------------------------------
-- Out of the Depths
-----------------------------------
-- Area: Metalworks
--  NPC: Ayame
--  !pos 133 -18 33
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require('scripts/zones/Bastok_Markets/IDs')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.OUT_OF_THE_DEPTHS)

quest.reward =
{
    fame = 80,
    fameArea = xi.quest.fame_area.BASTOK,
    title = xi.title.TRASH_COLLECTOR,
    gil = 1200,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:getFameLevel(xi.quest.fame_area.BASTOK) >= 3
        end,

        [xi.zone.METALWORKS] =
        {
            ['Ayame'] = quest:progressEvent(859),

            onEventFinish =
            {
                [859] = function(player, csid, option, npc)
                    if option == 3 then
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

        [xi.zone.PORT_BASTOK] =
        {
            ['Ravorara'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 1 then
                        if player:hasKeyItem(xi.ki.DUSTY_TOME) then
                            return quest:progressEvent(309, 0, 1, 0, 597)
                        elseif player:hasKeyItem(xi.ki.POINTED_JUG) then
                            return quest:progressEvent(309, 0, 2, 0, 598)
                        elseif player:hasKeyItem(xi.ki.CRACKED_CLUB) then
                            return quest:progressEvent(309, 0, 3, 0, 599)
                        elseif player:hasKeyItem(xi.ki.PEELING_HAIRPIN) then
                            return quest:progressEvent(309, 0, 4, 0, 600)
                        elseif player:hasKeyItem(xi.ki.OLD_NAMETAG) then
                            return quest:progressEvent(309, 0, 5, 0, 601)
                        else
                            return quest:progressEvent(308)
                        end
                    else
                        return quest:progressEvent(307)
                    end
                end,
            },

            onEventFinish =
            {
                [307] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [309] = function(player, csid, option, npc)
                    if option == 1 then
                        npcUtil.giveCurrency(player, 'gil', 100)
                        player:delKeyItem(xi.ki.DUSTY_TOME)
                        quest:setVar(player, 'Prog', quest:getVar(player, 'Prog') + 1)
                    elseif option == 2 then
                        npcUtil.giveCurrency(player, 'gil', 200)
                        player:delKeyItem(xi.ki.POINTED_JUG)
                        quest:setVar(player, 'Prog', quest:getVar(player, 'Prog') + 1)
                    elseif option == 3 then
                        npcUtil.giveCurrency(player, 'gil', 300)
                        player:delKeyItem(xi.ki.CRACKED_CLUB)
                        quest:setVar(player, 'Prog', quest:getVar(player, 'Prog') + 1)
                    elseif option == 4 then
                        npcUtil.giveCurrency(player, 'gil', 400)
                        player:delKeyItem(xi.ki.PEELING_HAIRPIN)
                        quest:setVar(player, 'Prog', quest:getVar(player, 'Prog') + 1)
                    elseif option == 5 then
                        player:delKeyItem(xi.ki.OLD_NAMETAG)
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Brakobrik'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(2)
                    elseif quest:getVar(player, 'Prog') >= 7 then
                        player:showText(npc, ID.text.BRAKOBRIK_1)
                    else
                        player:showText(npc, ID.text.BRAKOBRIK_2, 0, 1669)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Prog') >= 2 and quest:getVar(player, 'Prog') < 7 then
                        if trade:hasItemQty(1669, 1) and trade:getItemCount() == 1 then
                            if player:hasKeyItem(xi.ki.DUSTY_TOME) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 1)
                            end
                        elseif trade:hasItemQty(1669, 2) and trade:getItemCount() == 2 then
                            if player:hasKeyItem(xi.ki.POINTED_JUG) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 2)
                            end
                        elseif trade:hasItemQty(1669, 3) and trade:getItemCount() == 3 then
                            if player:hasKeyItem(xi.ki.CRACKED_CLUB) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 3)
                            end
                        elseif trade:hasItemQty(1669, 4) and trade:getItemCount() == 4 then
                            if player:hasKeyItem(xi.ki.PEELING_HAIRPIN) then
                                return quest:progressEvent(4, 0, 0, 0)
                            else
                                return quest:progressEvent(4, 0, 0, 4)
                            end
                        end
                    end
                end,

            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 2)
                    end
                end,

                [4] = function(player, csid, option, npc)
                    print(option)
                    if option == 1 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.DUSTY_TOME)
                    elseif option == 2 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.POINTED_JUG)
                    elseif option == 3 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.CRACKED_CLUB)
                    elseif option == 4 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.PEELING_HAIRPIN)
                    elseif option == 0 and quest:getVar(player, 'Prog') >= 6 then
                        player:tradeComplete()
                        npcUtil.giveKeyItem(player, xi.ki.OLD_NAMETAG)
                        player:showText(npc, ID.text.BRAKOBRIK_3)
                        quest:setVar(npc, 'Prog', 7)
                    elseif option == 0 then
                        player:tradeComplete()
                        player:showText(npc, ID.text.BRAKOBRIK_4)
                    end
                end,
            },
        },
        [xi.zone.BASTOK_MINES] =
        {
            ['Pavvke'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') >= 8 then
                        return quest:progressEvent(238)
                    end
                end,
            },

            onEventFinish =
            {
                [238] = function(player, csid, option, npc)
                    player:addFame(xi.quest.fame_area.BASTOK, 80)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
