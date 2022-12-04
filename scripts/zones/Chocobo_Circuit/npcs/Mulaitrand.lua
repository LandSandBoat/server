-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Mulaitrand
-- !pos -388.2694 -5.0000 -467.1629 70
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local freePass = player:hasKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
    player:startEvent(264, freePass and 1 or 0, 3) --Perdric
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
