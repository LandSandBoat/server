-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Adjutant
-- !pos -197 -1 39 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- player:startEvent(304) - This event is related to Campaign Ops Crystal Fist or Iron Anvil.
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
