-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Mailleronce
-- !pos 151 -2 114 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(109)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
