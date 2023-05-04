-----------------------------------
-- Area: Qufim Island
--  NPC: Nightflowers
-- Involved in Quest: Save My Son (Beastmaster Flag #1)
-- !pos -264.775 -3.718 28.767 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
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
