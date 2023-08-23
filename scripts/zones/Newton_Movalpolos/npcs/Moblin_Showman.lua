-----------------------------------
-- Area: Newton Movalpolos
--  NPC: Moblin Showman - Bugbear Matman
-- !pos 124.544 19.988 -60.670 12
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.AIR_TANK) and
        npcUtil.popFromQM(player, npc, ID.mob.BUGBEAR_MATMAN)
    then
        player:showText(npc, ID.text.SHOWMAN_ACCEPT)
        player:confirmTrade()
    else
        player:showText(npc, ID.text.SHOWMAN_DECLINE)
    end
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.SHOWMAN_TRIGGER)
end

return entity
