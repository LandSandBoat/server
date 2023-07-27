-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Morangeart
-- Type: ENM Quest Activator
-- !pos -74.308 -24.782 -28.475 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- True default is 523, TODO: Find out what 520 is for
    -- player:startEvent(520)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
