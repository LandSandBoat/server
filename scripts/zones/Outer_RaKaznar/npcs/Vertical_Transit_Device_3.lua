-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device (3)
-- !pos 532.889 99 -19.942 274
-----------------------------------
local ID = zones[xi.zone.OUTER_RAKAZNAR]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.SILVERY_PLATE) then
        player:startEvent(45, 300, 0, 100, 0, 3, 582330, 0)
    else
        player:messageSpecial(ID.text.THIS_BAFFLING_GADGET, 0) -- Verify Param for Lower floor
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- TODO: Verify that CS moves the player
end

return entity
