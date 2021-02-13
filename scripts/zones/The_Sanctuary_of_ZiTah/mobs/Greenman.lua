-----------------------------------
-- Area: The Sanctuary of Zi'Tah (121)
--   NM: Greenman
-- Note: Popped by qm1
-- Involved in Quest: The Weight Of Your Limits
-- !pos -325.406 -0.198 471.459 121
-----------------------------------
require("scripts/globals/wsquest")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.wsquest.handleWsnmDeath(tpz.wsquest.steel_cyclone, player)
end

return entity
