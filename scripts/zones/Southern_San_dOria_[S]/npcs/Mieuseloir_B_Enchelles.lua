-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Miuseloir B Enchelles
-- !pos 120 0 104 80
------------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(154)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
