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
    local freePass = player:hasKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
    player:startEvent(266, freePass and 1 or 0, 5) --Couzanne
end

entity.onEventUpdate = function(player, csid, option)
    local freePass = player:hasKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
    if freePass or player:delGil(50) then
        player:updateEvent(0)
        if freePass then
            player:delKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
        end
    end
end

entity.onEventFinsih = function(player, csid, option)
end

return entity
