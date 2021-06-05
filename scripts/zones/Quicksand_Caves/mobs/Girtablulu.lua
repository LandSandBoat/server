-----------------------------------
-- Area: Quicksand Caves
--  Mob: Girtablulu
-- Note: Popped by qm3
-- Involved in Quest: Old Wounds
-- !pos -141.6 -2 450.48 208
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
