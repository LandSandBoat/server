---------------------------------------------
-- Like Shining Leggings
---------------------------------------------
-- Log ID: 5 (Outlands), Quest ID: 139
-- Heizo : !pos -1 -5 25 252
---------------------------------------------
require('scripts/globals/zone')
require('scripts/globals/quests')
require("scripts/globals/titles")
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
---------------------------------------------
local ID = require("scripts/zones/Norg/IDs")
---------------------------------------------
local quest = Quest:new(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.LIKE_SHINING_LEGGINGS)
local tradeTrackingVar = "Prog"
local requiredLeggings = 10
local successfulTradeNum = 0

quest.reward =
{
    fameArea = xi.quest.fame_area.NORG,
    fame     = 100,
    title    = xi.title.LOOKS_GOOD_IN_LEGGINGS,
    item     = xi.items.SCROLL_OF_DOKUMORI_ICHI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return (status == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.NORG) >= 3)
        end,

        [xi.zone.NORG] =
        {
            ['Heizo'] = quest:progressEvent(127),

            onEventFinish =
            {
                [127] = function(player, csid, option, npc)
                    quest:begin(player) -- Start Like Shining Leggings
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
            ['Heizo'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(128, quest:getVar(player, tradeTrackingVar))-- Update the player on the number of Rusty Leggings they have turned in
                end,

                onTrade = function(player, npc, trade)
                    local curNumTradedIn = quest:getVar(player, tradeTrackingVar)
                    local numTradingInNow = trade:getItemQty(xi.items.RUSTY_LEGGINGS)
                    local remainderNeeded = utils.clamp(requiredLeggings - curNumTradedIn, 0, requiredLeggings)

                    local clampedTrade = math.min(numTradingInNow, remainderNeeded) -- Only take the amount needed to complete the quest and nothing more

                    if npcUtil.tradeHas(trade, { { xi.items.RUSTY_LEGGINGS, clampedTrade } }) then
                        local totalWithTrade = curNumTradedIn + clampedTrade
                        successfulTradeNum = totalWithTrade

                        if totalWithTrade >= 10 then
                            return quest:progressEvent(129) -- Complete the quest
                        elseif totalWithTrade <= 9 then
                            return quest:event(128, totalWithTrade)
                        end
                    else
                        successfulTradeNum = 0
                        return quest:event(128, curNumTradedIn)
                    end
                end,
            },

            onEventFinish =
            {
                [128] = function(player, csid, option, npc)
                    if successfulTradeNum > 0 then
                        quest:setVar(player, tradeTrackingVar, successfulTradeNum)-- Keep track of traded so far
                        player:confirmTrade()
                    else
                        player:tradeComplete(false) -- There were extra items in the trade
                    end
                end,

                [129] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, tradeTrackingVar, requiredLeggings)
                        player:confirmTrade()
                    end
                end,
            },
        },
    },
}

return quest
