-----------------------------------
-- Area: Pso'Xja
--  NPC: _i9y (Crystal Receptor)
-- !pos -389.980 -3.198 -203.595 9
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        player:startEvent(58)
    else
        player:messageSpecial(ID.text.DEVICE_IN_OPERATION)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 58 then
        local crystalOperator = npc:getID()

        npc:openDoor(118) -- this sets the trigger animation to glowing. The time is retail confirmed.
        GetNPCByID(crystalOperator + 1):closeDoor(118) -- tiles will reset at the same time.
    end
end

return entity
