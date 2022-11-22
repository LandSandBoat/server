-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Saffaullette
-- !pos -252.2906 -5.0000 -490.7443
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(265)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if 
        csid == 265 and 
        option == 1 and 
        player:hasKeyItem(xi.ki.CHOCOBO_CIRCUIT_GRANDSTAND_PASS) then 
            player:setpos(-116.2652, -14.500, -125.3634, 0)
    elseif csid == 265 and 
        option == 1 then
            player:delGil(50) and 
            player:setpos(-116.2652, -14.500, -125.3634, 0)
    end
end

return entity

--player:addgil
--CHOCOBO_CIRCUIT_GRANDSTAND_PASS          = 908
-- !addkeyitem 908 Tom_Neverwinter