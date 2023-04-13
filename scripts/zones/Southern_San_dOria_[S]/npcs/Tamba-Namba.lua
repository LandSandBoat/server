-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Tamba-Namba
-- !pos 104 4 21 80
-- Traveling Bard
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
--    player:startEvent(305)
    player:PrintToPlayer("Title changer NPC's have been disabled to prevent exploiting of weekly hunts")
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
