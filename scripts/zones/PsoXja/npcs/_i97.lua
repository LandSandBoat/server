-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local posZ = player:getZPos()
    if player:hasKeyItem(xi.ki.PSOXJA_PASS) and posZ >= 25 then
        player:startEvent(14)
    elseif posZ < 25 then
        player:startEvent(17)
    else
        player:messageSpecial(ID.text.DOOR_LOCKED)
    end
end

return entity
