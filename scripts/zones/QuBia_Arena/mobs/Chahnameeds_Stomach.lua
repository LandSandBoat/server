-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Chahnameed's Stomach
-- BCNM: An Awful Autopsy
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local mobId = mob:getID()
    local pos = mob:getPos()

    if
        mob:getHPP() <= 50 and
        mob:getLocalVar("spawnedIntestines") == 0 and
        not GetMobByID(mobId + 1):isSpawned()
    then
        GetMobByID(mobId + 1):setSpawn(pos.x, pos.y, pos.z)
        SpawnMob(mobId + 1):updateEnmity(target)
        mob:setLocalVar("spawnedIntestines", 1)
    end

    if
        mob:getHPP() <= 33 and
        mob:getLocalVar("spawnedLiver") == 0 and
        not GetMobByID(mobId + 2):isSpawned()
    then
        GetMobByID(mobId + 2):setSpawn(pos.x, pos.y, pos.z)
        SpawnMob(mobId + 2):updateEnmity(target)
        mob:setLocalVar("spawnedLiver", 1)
    end

    if
        mob:getHPP() <= 20 and
        mob:getLocalVar("spawnedChahnameed") == 0 and
        not GetMobByID(mobId + 3):isSpawned()
    then
        GetMobByID(mobId + 3):setSpawn(pos.x, pos.y, pos.z)
        SpawnMob(mobId + 3):updateEnmity(target)
        mob:setLocalVar("spawnedChahnameed", 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:resetLocalVars()
end

return entity
