-----------------------------------
-- Area: Batallia Downs (S)
--  NPC: Shanene
-- !pos 161.183 0.468 91.111 84
-----------------------------------
require('scripts/globals/npc_util')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(37)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
