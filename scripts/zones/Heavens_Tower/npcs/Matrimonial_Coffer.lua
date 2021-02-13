-----------------------------------
-- Area: Heavens Tower
--  NPC: Matrimonial Coffer
-- Type: NPC
-- !pos -5.955 0.249 24.360 242
-----------------------------------
require("scripts/globals/matrimonialcoffer")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.matrimonialcoffer.startEvent(player)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.matrimonialcoffer.finishEvent(player, csid, option)
end

return entity
