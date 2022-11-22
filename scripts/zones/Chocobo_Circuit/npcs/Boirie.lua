-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Boirie
-- !pos -387.4615 -5.0000 -490.9008 70
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(266, 0, 3)
end

entity.onEventUpdate = function(player, csid, option)
    local freePass = player:hasKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
    if freePass or player:getGil() >= 50 then
        player:updateEvent(0)
        if freePass then
            player:delKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
        else
            player:delGil(50)
        end
    end
end

entity.onEventFinsih = function(player, csid, option)
end

return entity
