-----------------------------------
-- Area: Xarcabard
--  NPC: Beastmen_s_Banner
-- !pos 153.000 -36.444 23.500 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
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
