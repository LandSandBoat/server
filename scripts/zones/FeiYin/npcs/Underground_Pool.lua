-----------------------------------
-- Area: FeiYin
--  NPC: Underground Pool
-- Involved In Quest: Scattered into Shadow
-- Offset 0 (H-5) !pos 7 0 247 204
-- Offset 1 (F-5) !pos -168 0 247 204
-- Offset 2 (H-8) !pos 7 0 32 204
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
