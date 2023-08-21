-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  NPC: ??? (Spawn Ob(ZNM T1))
-- !pos 542 0 -129 72
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.FLASK_OF_COG_LUBRICANT) and
        npcUtil.popFromQM(player, npc, ID.mob.OB)
    then
        -- Trade Cog Lubricant
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SLIMY_TOUCH)
end

return entity
