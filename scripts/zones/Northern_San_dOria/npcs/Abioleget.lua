-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Abioleget
-- Type: Quest Giver (Her Memories: The Faux Pas and The Vicasque's Sermon) / Merchant
-- !pos 128.771 0.000 118.538 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/titles")
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
