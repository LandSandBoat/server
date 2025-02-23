-----------------------------------
-- Area: Bhaflau Remnants
-- NPC: Armoury Crate (Bhaflau)
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getID() == ID.npc.ARMOURY_CRATE[11] then
        xi.salvage.onTriggerCrate(player, npc)
    else
        xi.salvage.tempBoxTrigger(player, npc)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.salvage.tempBoxFinish(player, csid, option, npc)
end

return entity
