-----------------------------------
-- Area: Mhaura
--  NPC: Ekokoko
-- Gouvernor of Mhaura
-- Involved in Quest: Riding on the Clouds
-- !pos -78 -24 28 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if math.random() > 0.5 then
        player:startEvent(51)
    else
        player:startEvent(52)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
