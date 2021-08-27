-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Beastmen_s_Banner
-- !pos -172.764 25.119 93.640 109
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
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
