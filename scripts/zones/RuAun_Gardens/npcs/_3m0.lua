-----------------------------------
-- Area: Ru'Aun Gardens
--  NPC: _3m0
-- !pos 0.1 -45 -113 130
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local DoorID = npc:getID()

    GetNPCByID(DoorID):openDoor(7)
    GetNPCByID(DoorID + 1):openDoor(7)
    GetNPCByID(DoorID + 2):openDoor(7)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
