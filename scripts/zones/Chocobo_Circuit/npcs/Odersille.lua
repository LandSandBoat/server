-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Odersille
-- Grandstand Exit
-- !pos -14.3511 -15 -131.869
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(331)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if csid == 331 and option == 1
    then
        player:setpos(-251.1373,-5.000,-489.9807) -- exits to saffa
    end
end

return entity
