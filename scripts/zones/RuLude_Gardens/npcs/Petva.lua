-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Petva
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(151)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
