-----------------------------------
-- Area: Port Windurst
--  NPC: Wau Kaatapoh
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(195)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
