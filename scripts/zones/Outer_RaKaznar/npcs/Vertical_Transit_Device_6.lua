-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device
-- !pos 580 99 26.606 274
-----------------------------------
local ID = zones[xi.zone.OUTER_RAKAZNAR]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SILVERY_PLATE) then
        player:startEvent(48, 1, 300, 1, 100, 0, 6, 0, 0)
    else
        player:messageSpecial(ID.text.THIS_BAFFLING_GADGET, 0)
    end
end

return entity
