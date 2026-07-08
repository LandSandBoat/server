-----------------------------------
-- Chocobo's Wounds
-- Reverts feeding timers to one Vana'diel day.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/46068-Feb-19-2015-%28JST%29-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_quest_chocobos_wounds'

if xi.module.isContentEnabled('SOA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

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

return m
