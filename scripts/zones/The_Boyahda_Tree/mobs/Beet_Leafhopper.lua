-----------------------------------
-- Area: The Boyahda Tree (153)
--   NM: Beet Leafhopper
-- Note: Popped by qm1
-- Involved in Quest: Shoot First, Ask Questions Later
-- !pos -18 -19.2 -176.4 153
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
