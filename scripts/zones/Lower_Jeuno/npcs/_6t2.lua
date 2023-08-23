-----------------------------------
-- Area: Lower Jeuno
-- Door: Merchant's House
-- Starts & Finishes Quest: Save My Son
-- Optional Involvement in Quest: Chocobo's Wounds, Path of the Beastmaster
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
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
