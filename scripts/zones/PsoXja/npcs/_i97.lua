-----------------------------------
-- Area: Pso'Xja
--  NPC: Stone Gate
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

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

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
