-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Sengann
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/fomor_hate") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.ZANSHIN, 15)
    mob:setMod(xi.mod.REGAIN, 200)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.CURSE)
end

entity.onMobRoam = function(mob)
    if VanadielHour() >= 4 and VanadielHour() < 20 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDisengage = function(mob)
    if VanadielHour() >= 4 and VanadielHour() < 20 then -- Despawn if its day
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 441)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar("cooldown", os.time() + 3000)
end

return entity
