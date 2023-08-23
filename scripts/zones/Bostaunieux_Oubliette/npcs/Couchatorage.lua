-----------------------------------
-- Area: Bostaunieux Oubliette
--  NPC: Couchatorage
-- !pos -20.502 -19 17.765 167
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(9)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
