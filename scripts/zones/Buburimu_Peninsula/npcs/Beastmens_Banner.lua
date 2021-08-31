-----------------------------------
-- Area: Buburimu_Peninsula
--  NPC: Beastmen_s_Banner
-- !pos -132.589 19.999 -314.261 118
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
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
