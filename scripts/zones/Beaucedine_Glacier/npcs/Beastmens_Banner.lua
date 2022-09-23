-----------------------------------
-- Area: Beaucedine_Glacier
--  NPC: Beastmen_s_Banner
-- !pos 20.169 -80.078 180.063 111
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
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
