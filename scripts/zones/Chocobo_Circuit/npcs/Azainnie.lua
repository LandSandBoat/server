-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Azainnie
-- !pos -60.623 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(328)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if csid == 328 and option == 1 then
        player:setPos(-330.2306, -5.000, -413.3920) -- exits to illsoire
    end
end

return entity
