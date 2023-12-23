---------------------------------------------
-- Like Shining Leggings
---------------------------------------------
-- Log ID: 5 (Outlands), Quest ID: 138
-- Heiji : !pos -1 -5 25 252
---------------------------------------------
require('scripts/globals/zone')
require('scripts/globals/quests')
require("scripts/globals/titles")
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
---------------------------------------------
local ID = require("scripts/zones/Norg/IDs")
---------------------------------------------
local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.LIKE_A_SHINING_SUBLIGAR)
local tradeTrackingVar = "Prog"
local requiredSubligars = 10
local successfulTradeNum = 0

quest.reward =
{
    fameArea = xi.quest.fame_area.NORG,
    fame     = 100,
    title    = xi.title.LOOKS_SUBLIME_IN_A_SUBLIGAR,
    item     = xi.items.SCROLL_OF_KURAYAMI_ICHI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return (status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.NORG) >= 3)
        end,

        [xi.zone.NORG] =
        {
            ['Heiji'] = quest:progressEvent(123),

            onEventFinish =
            {
                [123] = function(player, csid, option, npc)
                    quest:begin(player) -- Start Like a Shining Subligar
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Heiji'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(124, quest:getVar(player, tradeTrackingVar))-- Update the player on the number of Rusty Subligars they have turned in
                end,

                onTrade = function(player, npc, trade)
                    local curNumTradedIn = quest:getVar(player, tradeTrackingVar)
                    local numTradingInNow = trade:getItemQty(xi.items.RUSTY_SUBLIGAR)
                    local remainderNeeded = utils.clamp(requiredSubligars - curNumTradedIn, 0, requiredSubligars)

                    local clampedTrade = math.min(numTradingInNow, remainderNeeded) -- Only take the amount needed to complete the quest and nothing more

                    if npcUtil.tradeHas(trade, { { xi.items.RUSTY_SUBLIGAR, clampedTrade } }) then
                        local totalWithTrade = curNumTradedIn + clampedTrade
                        successfulTradeNum = totalWithTrade

                        if totalWithTrade >= 10 then
                            return quest:progressEvent(125) -- Complete the quest
                        elseif totalWithTrade <= 9 then
                            return quest:event(124, totalWithTrade)
                        end
                    else
                        successfulTradeNum = 0
                        return quest:event(124, curNumTradedIn)
                    end
                end,
            },

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    if successfulTradeNum > 0 then
                        quest:setVar(player, tradeTrackingVar, successfulTradeNum)-- Keep track of traded so far
                        player:confirmTrade()
                    else
                        player:tradeComplete(false) -- There were extra items in the trade
                    end
                end,

                [125] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, tradeTrackingVar, requiredSubligars)
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
