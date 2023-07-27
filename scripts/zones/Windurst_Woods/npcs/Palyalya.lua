-----------------------------------
-- Area: Windurst Woods
--  NPC: Palyalya
-- Type: Adv. Assistant
-- !pos 62.298 -3.499 -128.093 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10021)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
