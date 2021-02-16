-----------------------------------
-- Area: Ru'Lude Gardens
-- NPC: Delivery Crate
-- NPC used in magian trials
-- !pos -11.844 3.099 120.421 243
-----------------------------------
require("scripts/globals/magiantrials")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.magian.deliveryCrateOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.magian.deliveryCrateOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.magian.deliveryCrateOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.magian.deliveryCrateOnEventFinish(player, csid, option)
end

return entity
