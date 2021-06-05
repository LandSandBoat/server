-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kubhe Ijyuhla
-- Standard Info NPC
-- !pos 23.257 0.000 21.532 50
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
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
