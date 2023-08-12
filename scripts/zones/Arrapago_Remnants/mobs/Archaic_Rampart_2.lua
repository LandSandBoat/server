-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Rampart
-----------------------------------
mixins = { require("scripts/mixins/families/rampart") }
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
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
        end
    end

    if firstPet:isSpawned() then
        firstPet:updateEnmity(target)
    end

    if secondPet:isSpawned() then
        secondPet:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if ID.mob[6].rampart1 == mob:getID() or ID.mob[6].rampart2 == mob:getID() then
        if instance:getStage() == 6 and instance:getProgress() >= 1 then
            if optParams.isKiller then
                instance:setProgress(instance:getProgress() + 1)
            end
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
