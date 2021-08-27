-----------------------------------
-- Area: Temple of Uggalepih (159)
--   NM: Yallery Brown
-- Note: Popped by qm9
-- Involved in Quest: Axe The Competition
-- !pos 220 -8.11 205.38 159
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
