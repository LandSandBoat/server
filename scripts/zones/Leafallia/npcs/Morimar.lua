-----------------------------------
-- Area: Leafallia (281)
--  NPC: Morimar
-- !pos -44.972,-0.974,23.990
-----------------------------------
require("settings/main")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/ability")
require("scripts/globals/msg")
local ID = require("scripts/zones/Leafallia/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:setAllegiance(6)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
