-----------------------------------
-- Area: Heavens Tower
--  NPC: Matrimonial Coffer
-- Type: NPC
-- !pos -5.955 0.249 24.360 242
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.matrimonialcoffer.startEvent(player)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.matrimonialcoffer.finishEvent(player, csid, option, npc)
end

return entity
