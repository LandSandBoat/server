-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Mulaitrand
-- !pos -388.2694 -5.0000 -467.1629
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(264)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if csid == 264 and option == 100
    then
        player:setpos(-116.2652,-14.500,-125.3634,0)
    end
end

return entity

