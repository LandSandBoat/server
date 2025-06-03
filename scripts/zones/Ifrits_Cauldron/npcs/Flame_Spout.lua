-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: Flame Spout
-- !pos 193.967 -0.400 19.492 205
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.ICE_CLUSTER) then
        player:confirmTrade()
        GetNPCByID(npc:getID() + 5):openDoor(90)
    end
end

entity.onTrigger = function(player, npc)
    --[[ Commented out to preserve CSIDs for the quest, since the workaround was removed.
    local offset = npc:getID() - ID.npc.FLAME_SPOUT_OFFSET
    player:startEvent(11 + offset)
    --]]
end

return entity
