-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: ??? (_7mk) Door for Silvery Plate
-- !pos -923 -192 -20 274
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npc:openDoor(15)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
