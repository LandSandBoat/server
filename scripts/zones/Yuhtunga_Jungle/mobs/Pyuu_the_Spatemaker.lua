-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Pyuu the Spatemaker
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.SLEEPRES, 20)
    mob:setMod(xi.mod.BINDRES, 20)
    mob:setMod(xi.mod.GRAVITYRES, 20)
    mob:setMod(xi.mod.SILENCERES, 100)
end

entity.onMobSpawn = function(mob)
    -- Uses Jumping Thrust following a cast of Waterga III
    mob:addListener("MAGIC_STATE_EXIT", "PYUU_MAGIC_EXIT", function(mobArg, spell)
        if spell:getID() == 201 then
            mob:useMobAbility(770)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 364)
    xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end

return entity
