-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Roiloux, R.K.
-- Type: Campaign Arbiter
-- !pos 70.493 -0.602 -9.185 82
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(450)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
