-----------------------------------
-- Arts and Crafts
-- Hadahda !pos -112 -7 -66 50
-- Qutiba !pos 92 -7.5 -130 50
-- Matifa !pos -10 -1 -9 50
-- Balakaf !pos 25 -7 126 50
-- Ekhu Pesshyadha !pos -13 1 103 50
-- Zabahf !pos -90 -1 10 50
-- Mathlouq !pos -93 -7 129 50
-- Mhasbaf !pos 54 -7 11 50
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.ARTS_AND_CRAFTS)

quest.reward = {
    item = xi.items.IMPERIAL_SILVER_PIECE,
}

quest.sections = {
    -- Section: Begin quest
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Hadahda'] = quest:progressEvent(508),

            onEventFinish = {
                [508] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    -- Section: Questing
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Hadahda'] = {
                onTrigger = function(player, npc)
                    if quest:isVarBitsSet(player, 'Prog', 1, 2, 3, 4, 5, 6, 7) then
                        return quest:progressEvent(517)
                    else
                        return quest:event(509)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if quest:getVar(player, 'Stage') == 1
                       and npcUtil.tradeHasExactly(trade, xi.items.BOWL_OF_SUTLAC) then
                        return quest:progressEvent(573)
                    end
                end,
            },

            ['Mhasbaf'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 1) then
                        return quest:progressEvent(510)
                    end
                end,
            },

            ['Mathlouq'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 2) then
                        return quest:progressEvent(511)
                    end
                end,
            },

            ['Zabahf'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 3) then
                        return quest:progressEvent(512)
                    end
                end,
            },

            ['Ekhu_Pesshyadha'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 4) then
                        return quest:progressEvent(513)
                    end
                end,
            },

            ['Qutiba'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 5) then
                        return quest:progressEvent(514)
                    end
                end,
            },

            ['Balakaf'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 6) then
                        return quest:progressEvent(515)
                    end
                end,
            },

            ['Matifa'] = {
                onTrigger = function(player, npc)
                    if not quest:isVarBitsSet(player, 'Prog', 7) then
                        return quest:progressEvent(516)
                    end
                end,
            },

            onEventFinish = {
                [510] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 1)
                end,

                [511] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 2)
                end,

                [512] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 3)
                end,

                [513] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 4)
                end,

                [514] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 5)
                end,

                [515] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 6)
                end,

                [516] = function(player, csid, option, npc)
                    quest:setVarBit(player, 'Prog', 7)
                end,

                [517] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.BOWL_OF_SUTLAC) then
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Stage', 1)
                    end
                end,

                [573] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
