-----------------------------------
-- Area: Ranguemont Pass
--  NPC: Myffore
-- Type: NPC
-- !pos -179.951 4 -172.234 166
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 and option == 0 then
        local DoorID = npc:getID() + 1
        GetNPCByID(DoorID):openDoor(10)
    end
end

return entity
