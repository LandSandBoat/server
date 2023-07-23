-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Chocobo
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- player:startEvent(601)
    -- player:startEvent(820) --crazy hang
    -- player:startEvent(821) --crazy hang
    -- player:startEvent(600)
    -- player:startEvent(599)
    -- player:startEvent(862) -- cool choco debug menu
    -- player:startEvent(819)
    player:startEvent(818)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
