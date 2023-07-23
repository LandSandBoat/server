-----------------------------------
-- Area: RaKaznar Turris
--  NPC: _7p1 (Vertical Transit Device)
-- !pos 74 -33 20 277
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(15)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
