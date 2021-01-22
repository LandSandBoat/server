-----------------------------------
-- Area: Meriphataud_Mountains
--  NPC: Beastmen_s_Banner
-- !pos 592.850 -16.765 -518.802 119
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
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
