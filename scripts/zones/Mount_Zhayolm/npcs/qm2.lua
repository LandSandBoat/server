-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Claret(ZNM T1))
-- !pos 497 -9 52 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.BEAKER_OF_PECTIN) and
        npcUtil.popFromQM(player, npc, ID.mob.CLARET)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SICKLY_SWEET)
end

return entity
