-----------------------------------
-- Revert the timer for the quest: "Your Crystal Ball" to JP midnight.
-- The date this timer changed is approx October 2015: https://ffxiclopedia.fandom.com/wiki/Your_Crystal_Ball?oldid=1542116
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('Your_Crystal_Ball')

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/jeuno/Your_Crystal_Ball', function(quest)
        local mazeID = zones[xi.zone.MAZE_OF_SHAKHRAMI]

        quest.sections[2][xi.zone.MAZE_OF_SHAKHRAMI]['Rockwell'].onTrigger = function(player, npc)
            if quest:getVar(player, 'Prog') == 1 then
                if quest:getVar(player, 'Wait') <= GetSystemTime() then -- Timer adjustment check made here
                    return quest:progressEvent(52)
                else
                    return quest:messageSpecial(mazeID.text.WAIT_A_BIT_LONGER, 0, xi.item.DIVINATION_SPHERE)
                end
            end
        end

        quest.sections[2][xi.zone.MAZE_OF_SHAKHRAMI]['Rockwell'].onTrade = function(player, npc, trade)
            if npcUtil.tradeHasExactly(trade, xi.item.AHRIMAN_LENS) then
                local progress = quest:getVar(player, 'Prog')
                if progress == 0 then
                    player:confirmTrade()
                    quest:setVar(player, 'Prog', 1)
                    quest:setVar(player, 'Wait', JstMidnight()) -- Timer adjustment made here
                    return quest:messageSpecial(mazeID.text.SUBMERGED_ITEM, xi.item.AHRIMAN_LENS)
                elseif progress == 1 then
                    return quest:messageSpecial(mazeID.text.MORE_THAN_ONE, xi.item.AHRIMAN_LENS)
                end
            end
        end
    end)
end)

return m
