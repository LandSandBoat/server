-----------------------------------
-- Area: Monarch Linn
-- Mob: Watch Hippogryph
-- ENM: Beloved of the Atlantes
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 20, duration = math.random(4, 6) })
end

entity.onMobFight = function(mob, target)
    local guard = GetMobByID(mob:getID() + 1)
    local mobHPP = mob:getHPP()

    if guard and not guard:isSpawned() then
        if mobHPP < 75 and mob:getLocalVar('GuardSpawned') == 0 then
            mob:setLocalVar('GuardSpawned', 1)
            SpawnMob(guard:getID()):updateEnmity(target)
        elseif mobHPP < 50 and mob:getLocalVar('GuardSpawned') == 1 then
            mob:setLocalVar('GuardSpawned', 2)
            SpawnMob(guard:getID()):updateEnmity(target)
        elseif mobHPP < 25 and mob:getLocalVar('GuardSpawned') == 2 then
            mob:setLocalVar('GuardSpawned', 3)
            SpawnMob(guard:getID()):updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local guard = GetMobByID(mob:getID() + 1)
        if guard and guard:isSpawned() then
            guard:setHP(0)
        end
    end
end

return entity
