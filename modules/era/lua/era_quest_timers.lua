-----------------------------------
-- Module to revert to era quest timers
-----------------------------------
require("modules/module_utils")
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/quest')
-----------------------------------
local m = Module:new("era_quest_timers")
local wajaomID = require("scripts/zones/Wajaom_Woodlands/IDs")

m:addOverride('xi.server.onServerStart', function()
    super()
--Start of COR AF2 Navigating the Unfriendly Seas
    xi.module.modifyInteractionEntry('scripts/quests/ahtUrhgan/COR_AF2_Navigating_the_Unfriendly_Seas', function(quest)
    quest.sections[2][xi.zone.WAJAOM_WOODLANDS]['Leypoint'].onTrade = function(player, npc, trade)
            if
                npcUtil.tradeHasExactly(trade, xi.items.HYDROGAUGE) and
                quest:getVar(player, 'Prog') == 1
            then
                player:confirmTrade()
                quest:setVar(player, 'Prog', 2)
                quest:setVar(player, 'leypointTimer', getMidnight())
                return quest:messageSpecial(wajaomID.text.PLACE_HYDROGAUGE, xi.items.HYDROGAUGE)
            end
        end
    end)
-- end of COR AF2 Navigating the Unfriendly Sea
end)

return m
