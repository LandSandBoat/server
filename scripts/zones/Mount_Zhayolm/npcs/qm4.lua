-----------------------------------
-- Area: Mount Zhayolm
--  NPC: ??? (Spawn Khromasoul Bhurborlor(ZNM T3))
-- !pos 88 -22 70 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.VINEGAR_PIE) and
        npcUtil.popFromQM(player, npc, ID.mob.KHROMASOUL_BHURBORLOR, { hide = 0 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.ACIDIC_ODOR)
end

return entity
