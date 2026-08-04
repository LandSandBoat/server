-----------------------------------
-- Area: Ifrit's Cauldron
--  NPC: Flame Spout
-- !pos 193.967 -0.400 19.492 205
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeMatches(trade, { { xi.item.ICE_CLUSTER, 1 } }) then
        player:tradeComplete()
        player:messageSpecial(ID.text.FIRE_HAS_BEEN_PUT_OUT, 0, xi.item.ICE_CLUSTER)
        GetNPCByID(npc:getID() + 5):openDoor(10)
    end
end

entity.onTrigger = function(player, npc)
    --[[ Commented out to preserve CSIDs for the quest, since the workaround was removed.
    local offset = npc:getID() - ID.npc.FLAME_SPOUT_OFFSET
    player:startEvent(11 + offset)
    --]]
end

return entity
