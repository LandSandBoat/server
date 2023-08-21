-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Zareehkl the Jubilant(ZNM T2))
-- !pos 176 -4 182 54
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.MERROW_NO_11_MOLTING) and
        npcUtil.popFromQM(player, npc, ID.mob.ZAREEHKL_THE_JUBILANT, { message = ID.text.DRAWS_NEAR })
    then
        player:confirmTrade()
    end
end

return entity
