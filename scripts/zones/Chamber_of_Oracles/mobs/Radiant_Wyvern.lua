-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Radiant Wyvern
-- KSNM: Eye of the Storm
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 17)
end

function onMobEngaged(mob, target)
    mob:useMobAbility(815)
    mob:setMod(tpz.mod.REGAIN, 100)
end

entity.onMobFight = function(mob, target)
end

function onMobDeath(mob, player, isKiller)
end

return entity
