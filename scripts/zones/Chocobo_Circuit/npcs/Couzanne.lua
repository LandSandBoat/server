-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Couzanne
-- Grandstand Exit
-- !pos -110.9048 -14.5000 -131.5597
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
    if csid == 332 and option == 1
    then
        player:setpos(-387.2634,-5.000,-490.0573) -- exits to Biorie
    end
end

return entity
