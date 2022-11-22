-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Couzanne
-- !pos -107.947 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(332)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if
        csid == 332 and
        option == 1
    then
        player:setpos(-387.2634, -5.000, -490.0573) -- exits to Biorie
    end
end

return entity
