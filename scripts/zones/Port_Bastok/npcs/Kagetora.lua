-----------------------------------
-- Area: Port Bastok
--  NPC: Kagetora
-- Involved in Quest: Ayame and Kaede, 20 in Pirate Years
-- !pos -96 -2 29 236
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('twentyInPirateYearsCS') == 1 then
        player:startEvent(261)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 261 then
        player:setCharVar('twentyInPirateYearsCS', 2)
    end
end

return entity
