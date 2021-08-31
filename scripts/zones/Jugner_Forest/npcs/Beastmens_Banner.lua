-----------------------------------
-- Area: Jugner_Forest
--  NPC: Beastmen_s_Banner
-- !pos 448.240 0.210 -157.228 104
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
