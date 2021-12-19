-----------------------------------
--  Area: Halvung
--  NPC: Operating Lever B
--  TODO: more than 5/6 people still need verification as no sites show this requirment?
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.BRACELET_OF_VERVE) == false then
        player:startEvent(100)
        return 1
    else
        GetNPCByID(npc:getID() - 3):openDoor(30)
        player:messageSpecial(ID.text.LIFT_LEVER)
        return 1
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
