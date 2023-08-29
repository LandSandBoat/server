-----------------------------------
-- Area: FeiYin
--  NPC: Dry Fountain
-- Involved In Quest: Peace for the Spirit
-- !pos -17 -16 71 204
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/FeiYin/IDs")
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
