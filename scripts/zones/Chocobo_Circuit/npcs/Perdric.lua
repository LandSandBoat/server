-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Perdric
-- Grandstand Exit
-- !pos -83.8079 -14.5000 -131.5600
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if csid == 330 and option == 1
    then
        player:setpos(-387.1529,-5.000,-469.9266) -- exits to mulitrand
    end
end

return entity
