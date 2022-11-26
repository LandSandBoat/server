-----------------------------------
-- Area: Mount Zhayolm
--  ZNM: Brass Borer
-- TODO: Halting movement during stance change.
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    mob:setLocalVar("defUp", math.random(25, 50))
    mob:setLocalVar("DEF", math.random(3, 5))
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobRoam = function(mob)
    local roamTime = mob:getLocalVar("formTime")

    if mob:getAnimationSub() == 0 and os.time() > roamTime then
        mob:setAnimationSub(1)
        mob:addMod(xi.mod.MDEF, 10)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    elseif mob:getAnimationSub() == 1 and os.time() > roamTime then
        mob:setAnimationSub(0)
        mob:delMod(xi.mod.MDEF, 10)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    end
end

entity.onMobFight = function(mob, target)
    local fightTime = mob:getLocalVar("formTime")

    if mob:getAnimationSub() == 0 and os.time() > fightTime then
        mob:setAnimationSub(1)
        mob:addMod(xi.mod.MDEF, 10)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    elseif mob:getAnimationSub() == 1 and os.time() > fightTime then
        mob:setAnimationSub(0)
        mob:delMod(xi.mod.MDEF, 10)
        mob:setLocalVar("formTime", os.time() + math.random(43, 47))
    end

    if
        mob:getHPP() < mob:getLocalVar("defUp") and
        mob:getLocalVar("usedMainSpec") <= mob:getLocalVar("DEF")
    then
        mob:useMobAbility(1815)
        mob:setLocalVar("usedMainSpec", mob:getLocalVar("usedMainSpec") + 1)
    elseif
        mob:getLocalVar("usedMainSpec") >= 5 and
        mob:getLocalVar("Cannonball") == 0
    then
        mob:useMobAbility(1818)
        mob:setLocalVar("Cannonball", 1)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENFIRE)
end

entity.onMobDeath = function(mob)
end

return entity
