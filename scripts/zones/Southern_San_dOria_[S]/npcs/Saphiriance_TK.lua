-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Saphiriance T.K
-- !pos 113 1 -40 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(450)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
