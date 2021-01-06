-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Duu Nazo the Spryfooted
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMod(tpz.mod.REGEN, 100)
end

function onMobDeath(mob, player, isKiller)
end

return entity
