-----------------------------------
-- Area: Kuftal Tunnel (174)
--   NM: Kettenkaefer
-- Note: Popped by qm3
-- !pos 204.052 10.25 96.414 174
-- Involved in Quest: The Potential Within
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
