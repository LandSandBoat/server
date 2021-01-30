-----------------------------------
-- Area: Windurst Woods: Moghouse
--  NPC: Symphonic Curator
-----------------------------------
require("scripts/globals/symphonic_curator")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.symphonic_curator.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.symphonic_curator.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.symphonic_curator.onEventFinish(player, csid, option)
end

return entity
