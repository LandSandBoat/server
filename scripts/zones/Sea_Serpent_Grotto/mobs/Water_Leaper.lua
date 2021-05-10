-----------------------------------
-- Area: Sea Serpent Grotto
--  Mob: Water Leaper
-- Note: Popped by qm1
-- !pos 112.5 0.8 -126.2 176
-- Involved in Quest: Methods Create Madness
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
