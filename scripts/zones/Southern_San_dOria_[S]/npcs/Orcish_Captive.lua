-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Orcish Captive
-- !pos -92 -7 68 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(609)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
