-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Tsugumi
-- Standard Info NPC
-----------------------------------
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(163)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
