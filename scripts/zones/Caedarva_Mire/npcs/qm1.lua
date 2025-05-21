-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Verdelet(ZNM T2))
-- !pos 417 -19 -69 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.MINT_DROP) and
        npcUtil.popFromQM(player, npc, ID.mob.VERDELET)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SICKLY_SWEET)
end

return entity
