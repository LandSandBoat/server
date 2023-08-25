-----------------------------------
-- Area: Monarch Linn
-- Mob: Watch Hippogryph
-- ENM: Beloved of the Atlantes
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobFight = function(mob, target)
    local guardHippo = GetMobByID(mob:getID()+1)

    if not guardHippo:isSpawned() then
        if mob:getHPP() < 75 and mob:getLocalVar("firstSpawn") == 0 then
            mob:setLocalVar("firstSpawn", 1)
            SpawnMob(guardHippo:getID()):updateEnmity(target)
        elseif mob:getHPP() < 50 and mob:getLocalVar("secondSpawn") == 0 then
            mob:setLocalVar("secondSpawn", 1)
            SpawnMob(guardHippo:getID()):updateEnmity(target)
        elseif mob:getHPP() < 25 and mob:getLocalVar("thirdSpawn") == 0 then
            mob:setLocalVar("thirdSpawn", 1)
            SpawnMob(guardHippo:getID()):updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local guardHippo = GetMobByID(mob:getID()+1)

    if guardHippo:isAlive() then
        guardHippo:setHP(0)
    end
end

return entity
