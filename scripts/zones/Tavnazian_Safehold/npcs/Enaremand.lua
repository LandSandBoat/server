-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Enaremand
-- Type: Standard NPC
-- !pos 95.962 -42.003 51.613 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(537)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
