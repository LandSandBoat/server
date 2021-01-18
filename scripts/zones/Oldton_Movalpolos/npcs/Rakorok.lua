-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Rakorok
-----------------------------------
local ID = require("scripts/zones/Oldton_Movalpolos/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npc:showText(npc, ID.text.RAKOROK_DIALOGUE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
