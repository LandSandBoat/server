-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Nuhn(ZNM T3))
-- !pos -451 -7 389 54
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.WHOLE_ROSE_SCAMPI) and
        npcUtil.popFromQM(player, npc, ID.mob.NUHN, { message = ID.text.DRAWS_NEAR })
    then
        player:confirmTrade()
    end
end

return entity
