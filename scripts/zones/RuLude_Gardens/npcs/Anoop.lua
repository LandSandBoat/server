-----------------------------------
-- Area: Ru'Lud Gardens
--  NPC: Anoop
-- Standard Info NPC
-----------------------------------
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(154)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
