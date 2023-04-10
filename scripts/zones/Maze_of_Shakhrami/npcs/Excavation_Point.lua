-----------------------------------
-- Area: Maze of Shakhrami
--  NPC: Excavation Point
-- Used in Quest: The Holy Crest
-- !pos 234 0.1 -110 198
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/helm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("TheHolyCrest_Event") == 3 and
        not player:hasItem(xi.items.WYVERN_EGG) and
        npcUtil.tradeHas(trade, xi.items.PICKAXE)
    then
        if npcUtil.giveItem(player, xi.items.WYVERN_EGG) then
            player:confirmTrade()
        end
    else
        xi.helm.onTrade(player, npc, trade, xi.helm.type.EXCAVATION, 60)
    end
end

entity.onTrigger = function(player, npc)
    xi.helm.onTrigger(player, xi.helm.type.EXCAVATION)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
