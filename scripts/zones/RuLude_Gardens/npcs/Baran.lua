-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Baran
-- Standard Info NPC
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(150)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
