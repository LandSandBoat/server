-----------------------------------
-- Area: Bhaflau Remnants
-- NPC: Slot
-- trade card to pop NM
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.salvage.handleSlot(player, npc, trade, xi.item.ARRAPAGO_CARD, ID.mob.DEMENTED_JALAWAA)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SLOT_TRIGGER)
end

return entity
