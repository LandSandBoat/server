-----------------------------------
-- Area: Tavnazian_Safehold
--  NPC: Hieroglyphics
-- Notes: Dynamis Tavnazia Enter
-- !pos 3.674 -7.278 -27.856 26
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    dynamis.entryNpcOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    dynamis.entryNpcOnEventFinish(player, csid, option)
end

return entity
