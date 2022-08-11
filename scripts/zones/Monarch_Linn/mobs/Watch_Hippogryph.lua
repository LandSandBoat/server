-----------------------------------
-- Area: Monarch Linn
-- Mob: Watch Hippogryph
-- ENM: Beloved of the Atlantes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobFight = function(mob, target)
    if not GetMobByID(mob:getID()+1):isSpawned() then
        if mob:getHPP() < 75 and mob:getLocalVar("firstSpawn") == 0 then
            mob:setLocalVar("firstSpawn", 1)
            SpawnMob(mob:getID()+1):updateEnmity(target)
        elseif mob:getHPP() < 50 and mob:getLocalVar("secondSpawn") == 0 then
            mob:setLocalVar("secondSpawn", 1)
            SpawnMob(mob:getID()+1):updateEnmity(target)
        elseif mob:GetHPP() < 25 and mob:getLocalVar("thirdSpawn") == 0 then
            mob:setLocalVar("thirdSpawn", 1)
            SpawnMob(mob:getID()+1):updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
