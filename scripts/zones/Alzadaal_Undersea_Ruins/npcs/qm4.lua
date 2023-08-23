-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Wulgaru(ZNM T2))
-- !pos -22 -4 204 72
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.OPALUS_GEM) and
        npcUtil.popFromQM(player, npc, ID.mob.WULGARU)
    then
        -- Trade Opalus Gem
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.GLITTERING_FRAGMENTS)
end

return entity
