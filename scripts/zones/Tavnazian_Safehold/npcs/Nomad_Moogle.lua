-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nomad Moogle
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.NOMAD_MOOGLE_DIALOG)
    player:sendMenu(1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
