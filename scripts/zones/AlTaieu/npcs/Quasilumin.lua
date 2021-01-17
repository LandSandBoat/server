-----------------------------------
-- Area: Al'Taieu
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos -27.443 -1 -636.850 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.QUASILUMIN_01)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
