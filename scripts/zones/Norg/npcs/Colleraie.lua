-----------------------------------
-- Area: Norg
--  NPC: Colleraie
-- Type: Event Scene Replayer
-- !pos -24.684 0.097 -39.409 252
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(175)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
