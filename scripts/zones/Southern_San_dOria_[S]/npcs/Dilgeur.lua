-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Dilgeur                 -- Misnamed NPC, name is Crochepallade when it should be Dilgeur, swap pos with the NPC at -46 2 -8
-- !pos 22 2 3 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
