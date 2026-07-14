-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device
-- !pos -460 -141 26.661 274
-----------------------------------
local ID = zones[xi.zone.OUTER_RAKAZNAR]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SILVERY_PLATE) then
        player:startEvent(45, 0, 300, 0, 100, 0, 3, 0, 0)
    else
        player:messageSpecial(ID.text.THIS_BAFFLING_GADGET, 1)
    end
end

return entity
