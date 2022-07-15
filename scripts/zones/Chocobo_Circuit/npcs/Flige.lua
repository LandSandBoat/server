-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Flige
-- Grandstand Exit
-- !pos -35.4830 -15.0000 -132.1756
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(329)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if csid == 329 and option == 1
    then
        player:setpos(-252.5519,-5.000,-470.0900) -- exits to foulnepard
    end
end

return entity
