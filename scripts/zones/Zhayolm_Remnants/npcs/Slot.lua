-----------------------------------
-- Area: Zhayolm Remnants
-- NPC: Slot
-- trade card to pop NM
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.salvage.handleSlot(player, npc, trade, xi.item.SILVER_SEA_CARD, ID.mob.JAKKO)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SLOT_TRIGGER)
end

return entity
