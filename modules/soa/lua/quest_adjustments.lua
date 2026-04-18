-----------------------------------
-- Module: Quest Adjustments (Seekers of Adoulin Era)
-- Desc: Reverts quest adjustments that were done in the SoA expansion
-----------------------------------
require('modules/module_utils')
require('scripts/globals/interaction/interaction_global')
-----------------------------------
local m = Module:new('chocobos_wounds_era_wait')
-----------------------------------
-- Reverts "Chocobo's Wounds" Feeding Timers To 1 Game Day
-- Source: https://forum.square-enix.com/ffxi/threads/46068-Feb-19-2015-%28JST%29-Version-Update
-----------------------------------
m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Chocobos_Wounds', function(quest)
        -- Override trade function timer with VanadielUniqueDay instead of GetSystemTime +45
        quest.sections[2][xi.zone.UPPER_JEUNO]['Chocobo'].onTrade = function(player, npc, trade)
            if trade:getItemQty(xi.item.BUNCH_OF_GYSAHL_GREENS) > 0 then
                return quest:event(76)
            end

            if trade:getItemQty(xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS) == 0 then
                return quest:noAction()
            end

            if quest:getVar(player, 'Timer') >= VanadielUniqueDay() then
                return quest:event(73)
            end

            local eventTable =
            {
                [1] = 57,
                [2] = 58,
                [3] = 99,
                [4] = 59,
                [5] = 60,
                [6] = 64,
            }

            local questProgress = quest:getVar(player, 'Prog')
            if questProgress <= 2 then
                return quest:progressEvent(eventTable[questProgress])
            end

            if npcUtil.tradeHasExactly(trade, xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS) then
                return quest:progressEvent(eventTable[questProgress])
            end
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[57] = function(player, csid, option, npc)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 2)
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[58] = function(player, csid, option, npc)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 3)
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[59] = function(player, csid, option, npc)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 5)
            player:confirmTrade()
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[60] = function(player, csid, option, npc)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 6)
            player:confirmTrade()
        end

        quest.sections[2][xi.zone.UPPER_JEUNO].onEventFinish[99] = function(player, csid, option, npc)
            quest:setVar(player, 'Timer', VanadielUniqueDay())
            quest:setVar(player, 'Prog', 4)
            player:confirmTrade()
        end
    end)
end)

-- The final event [64] does not need to set a new timer as the quest is already complete at that point
return m
