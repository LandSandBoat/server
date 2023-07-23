-----------------------------------
-- Area: Heavens Tower
--  NPC: Mhabi Molkot
-- Type: Conflict Director
-- !pos -3.767 -0.501 23.920 242
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(410)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
