-----------------------------------
-- Area: Kazham
--  NPC: Hunt Registry
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc, event)
    tpz.hunts.onTrigger(player, npc, event)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.hunts.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.hunts.onEventFinish(player, csid, option)
end

return entity
