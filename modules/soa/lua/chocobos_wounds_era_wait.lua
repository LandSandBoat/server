-----------------------------------
-- modules/soa/lua/chocobos_wounds_era_wait.lua
-- Changes the Chocobos Wounds quest to be era accurate prior to the Feb. 19, 2015 update
-- https://forum.square-enix.com/ffxi/
-- Changes the wait time to VanadielUniqueDay
-- Proposal by Xaver-DaRed on Jan. 9th, 2026 PR#9031
-----------------------------------
require('modules/module_utils')
require('scripts/globals/interaction/interaction_global')
-----------------------------------
local m = Module:new('chocobos_wounds_era_wait')

m:addOverride('xi.server.onServerStart', function()
    super()
    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Chocobos_Wounds', function(quest)
        -- Override trade function timer with VanadielUniqueDay instead of GetSystemTime +45
        quest.sections[2][xi.zone.UPPER_JEUNO]['Chocobo'].onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, xi.item.BUNCH_OF_GYSAHL_GREENS) then
                return quest:progressEvent(76)
            elseif npcUtil.tradeHasExactly(trade, xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS) then
                local timer = tonumber(quest:getVar(player, 'Timer')) or 0
                -- Allow one attempt on first day (timer defaults 0) and once per new Vanadiel day
                if timer < VanadielUniqueDay() then
                    local prog = tonumber(quest:getVar(player, 'Prog')) or 1
                    local chocoboFeedTrades = { 57, 58, 59, 60, 63, 64 }
                    local csid = chocoboFeedTrades[prog] or chocoboFeedTrades[1] -- prevent nil index if Prog is somehow out of bounds
                    return quest:progressEvent(csid)
                else
                    return quest:progressEvent(73)
                end
            end
        end
        -- TODO: needs capture for retail event data to determine how the trades are completed.
        -- Retail doesn't print the gausebit grass obtained by player after each "too soon" trade.
        -- Suggests the event may be giving the item back or zoning player.

        -- onEventFinish handlers confirmTrade() and set Timer.
        -- Event 73 is "too soon" response, confirms trade and gives item back without setting a new timer or progress.
        -- Other events where the Chocobo is not ready confirm the trade, give the item back, and set a new timer and progress.
        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[73] = function(player, csid, option, npc)
            player:confirmTrade()
            npcUtil.giveItem(player, xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS)
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[57] = function(player, csid, option, npc)
            player:confirmTrade()
            npcUtil.giveItem(player, xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 2)
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[58] = function(player, csid, option, npc)
            player:confirmTrade()
            npcUtil.giveItem(player, xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 3)
        end
        -- 3rd and later feed attempts, Chocobo is ready events do not give the item back and sets a new timer for next attempt
        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[59] = function(player, csid, option, npc)
            player:confirmTrade()
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 4)
            player:startEvent(99)
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[60] = function(player, csid, option, npc)
            player:confirmTrade()
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 5)
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[63] = function(player, csid, option, npc)
            player:confirmTrade()
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 6)
        end
    end)
end)
-- The final event [64] does not need to set a new timer as the quest is already complete at that point
return m
