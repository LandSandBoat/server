-----------------------------------
-- Area: Port Jeuno
--  NPC: Joachim
-- !pos -52.844 0.000 -9.978 246
-- CS/Event ID's:
-- 324 = on zoning in
-- 325 = 1st chat, get 1st stone,
-- completes "A Journey Begins"
-- 326 = Limited Menu
-- 327 = CS after "The Truth Beckons" completed.
-- 328 = Full Menu
-- 331 = CS after "Dawn of Death" completed.
-- 332 = ???
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.traverserNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.traverserNPCOnUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.traverserNPCOnEventFinish(player, csid, option, npc)
end

return entity
