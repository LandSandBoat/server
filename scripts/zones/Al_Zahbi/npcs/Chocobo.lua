-----------------------------------
-- Area: Al Zahbi
--  NPC: Chocobo
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npc:showText(npc, ID.text.CHOCOBO_HAPPY)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
