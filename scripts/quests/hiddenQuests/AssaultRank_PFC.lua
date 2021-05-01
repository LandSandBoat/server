-----------------------------------
-- Assault PFC rank-up quest

-- Naja Salaheem !pos 26 -8 -45.5 50
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/items")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/hidden_quest')
-----------------------------------

local quest = HiddenQuest:new("AssaultRank_PFC")

quest.reward = {
    keyItem = xi.ki.PFC_WILDCAT_BADGE,
}

quest.sections = {
    -- Section: Begin quest
    {
        check = function(player, questVars, vars)
            return not player:hasKeyItem(xi.ki.PFC_WILDCAT_BADGE)
                and vars['AssaultPromotion'] >= 25
                and questVars.Prog == 0
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Naja_Salaheem'] = quest:progressEvent(5000, { text_table = 0 }),

            onEventFinish = {
                [5000] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Section: Hoofprint hunting
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 1
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Naja_Salaheem'] = {
                onTrigger = function(player, npc)
                    return quest:event(5001, { text_table = 0 })
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.IMP_WING) then
                        return quest:progressEvent(5002, { text_table = 0 })
                    end
                end,
            },

            onEventFinish = {
                [5002] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:setVar("AssaultPromotion", 0)
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
