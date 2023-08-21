-----------------------------------
-- Area: Newton_Movalpolos
--  NPC: ??? for Goblin Collector
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.PREMIUM_BAG) and
        npcUtil.popFromQM(player, npc, ID.mob.GOBLIN_COLLECTOR)
    then
        player:confirmTrade()
    end
end

return entity
