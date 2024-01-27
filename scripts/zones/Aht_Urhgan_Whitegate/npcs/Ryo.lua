-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ryo
-- Type: ZNM assistant
-- !pos -127.086 0.999 22.693 50
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.znm.ryo.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.znm.ryo.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.znm.ryo.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.znm.ryo.onEventFinish(player, csid, option, npc)
end

return entity
