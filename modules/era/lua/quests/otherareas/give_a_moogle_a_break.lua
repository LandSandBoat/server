-----------------------------------
-- Give a Moogle a Break
-- Restores the conquest tally wait before the Moogle offers the quest.
-- Restores the JST midnight wait before the Moogle hands over the reward.
-- The July 8, 2014 version update shortened both waits to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/43135-Jul-8-2014-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_give_a_moogle_a_break', xi.pre(xi.expansion.SOA))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Give_a_Moogle_a_Break', function(quest)
        -- Copy of the base check. The quest is offered at the next conquest tally.
        quest.sections[1].check = function(player, status, vars)
            local bedPlacedTime = quest:getVar(player, 'bedPlacedTime')

            return status == xi.questStatus.QUEST_AVAILABLE and
                xi.moghouse.inMogHouseInHomeNation(player) and
                player:getFameLevel(player:getNation()) >= 3 and
                quest:getLocalVar(player, 'mustZone') == 0 and
                quest:getLocalVar(player, 'questSeen') == 0 and
                bedPlacedTime ~= 0 and
                bedPlacedTime < NextConquestTally() - utils.days(7) -- Module change
        end

        -- Every Mog House zone shares one section table. A wrapper would run the base handler once per zone.
        for _, zoneId in ipairs(xi.moghouse.moghouseZones) do
            local section = quest.sections[2][zoneId]

            -- Copy of the base handler. The reward is handed over at JST midnight.
            section.onEventFinish[30007] = function(player, csid, option, npc)
                player:tradeComplete()
                quest:setVar(player, 'Prog', 1)
                quest:setVar(player, 'Timer', JstMidnight()) -- Module change
            end
        end
    end)
end)
