-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Houilloume
-- !zone 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(103) -- it says player:startEvent(103)
    -- the player:startEvent basically means start CutScene
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
