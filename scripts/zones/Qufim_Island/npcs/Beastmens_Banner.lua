-----------------------------------
-- Area: Qufim_Island
--  NPC: Beastmen_s_Banner
-- !pos 0.348 -20.126 73.479 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BEASTMEN_BANNER)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("OPTION: %u", option)
end

entity.onEventFinish = function(player, csid, option)
    -- printf("OPTION: %u", option)
end

return entity
