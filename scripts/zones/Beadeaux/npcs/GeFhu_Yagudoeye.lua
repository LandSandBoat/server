-----------------------------------
-- Area: Beadeaux
--  NPC: Ge'Fhu Yagudoeye
-- Type: Quest NPC
-- !pos -91.354 -4.251 -127.831 147
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(124)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
