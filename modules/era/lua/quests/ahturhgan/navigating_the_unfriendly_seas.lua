-----------------------------------
-- Navigating the Unfriendly Seas (COR AF2)
-- Restores the JST midnight wait before the Leypoint finishes with the hydrogauge.
-- The June 7, 2016 version update shortened the wait to one minute.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_navigating_the_unfriendly_seas', xi.pre(xi.expansion.ROV))

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/COR_AF2_Navigating_the_Unfriendly_Seas', function(quest)
        local wajaom    = quest.sections[2][xi.zone.WAJAOM_WOODLANDS]
        local baseTrade = wajaom['Leypoint'].onTrade

        -- The Leypoint finishes measuring at JST midnight.
        wajaom['Leypoint'].onTrade = function(player, npc, trade)
            local action = baseTrade(player, npc, trade)
            if action then
                quest:setVar(player, 'Wait', JstMidnight()) -- Module change
            end

            return action
        end
    end)
end)
