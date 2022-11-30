-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Rampart
-----------------------------------
mixins = { require("scripts/mixins/families/rampart") }
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local instance  = mob:getInstance()
    local popTime   = mob:getLocalVar("lastPetPop")
    local mobPos    = mob:getPos()
    local firstPet  = GetMobByID((mob:getID() + 1), instance)
    local secondPet = GetMobByID((mob:getID() + 2), instance)
    local thirdPet  = GetMobByID((mob:getID() + 3), instance)

    if os.time() - popTime > 15 then
        if not firstPet:isSpawned() then
            firstPet:setSpawn(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            mob:useMobAbility(2034)
            mob:setLocalVar("lastPetPop", os.time())
            mob:timer(2500, function(m)
                SpawnMob((m:getID() + 1), instance)
            end)
        elseif not secondPet:isSpawned() then
            secondPet:setSpawn(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            mob:useMobAbility(2034)
            mob:setLocalVar("lastPetPop", os.time())
            mob:timer(2500, function(m)
                SpawnMob((m:getID() + 2), instance)
            end)
        elseif not thirdPet:isSpawned() then
            thirdPet:setSpawn(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            mob:useMobAbility(2034)
            mob:setLocalVar("lastPetPop", os.time())
            mob:timer(2500, function(m)
                SpawnMob((m:getID() + 3), instance)
            end)
        end
    end

    if firstPet:isSpawned() then
        firstPet:updateEnmity(target)
    end

    if secondPet: isSpawned() then
        secondPet:updateEnmity(target)
    end

    if thirdPet: isSpawned() then
        thirdPet:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
