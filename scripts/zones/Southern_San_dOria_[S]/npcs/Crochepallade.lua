-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Crochepallade                 -- Name is Moogle for some reason
-- !pos -46 2 -8 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(329)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
