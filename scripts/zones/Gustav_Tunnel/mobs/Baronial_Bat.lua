-----------------------------------
-- Area: Gustav Tunnel (212)
--  Mob: Baronial Bat
-- Note: Popped by qm1
-- !pos 56 -1 16 212
-- Involved in Quest: Cloak and Dagger
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
