-----------------------------------
-- Area: Caedarva Mire
--  NPC: Seaprince's Tombstone
-- Involved in quest: Forging a New Myth
-- !pos  -433 7 -586 79
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SEAPRINCES_TOMBSTONE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
