-----------------------------------
-- Area: Western Adoulin (256)
--  NPC: Brenton
-- Type: SOA Mission NPC
-- !pos -86.036 3.349 18.121 256
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Western_Adoulin/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(576)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
