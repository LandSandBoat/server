-----------------------------------
-- Area: Phomiuna Aqueducts
--  NPC: qm_torches_hint (???)
-- Notes: gives player hint about elemental correlation between the torches and how to open the path to the ornate gates
-- !pos 83.219 -25.047 8.010 27
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(56)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
