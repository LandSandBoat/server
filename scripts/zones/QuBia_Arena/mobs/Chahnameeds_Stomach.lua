-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Chahnameed's Stomach
-- BCNM: An Awful Autopsy
-----------------------------------

function onMobFight (mob, target)
    local mobId = mob:getID()
    if mob:getHPP() <= 50 and mob:getLocalVar("spawnedIntestines") == 0 and not GetMobByID(mobId + 1):isSpawned() then
        SpawnMob(mobId + 1):updateEnmity(target)
        mob:setLocalVar("spawnedIntestines", 1)
    end
    if mob:getHPP() <= 33 and mob:getLocalVar("spawnedLiver") == 0  and not GetMobByID(mobId + 2):isSpawned() then
        SpawnMob(mobId + 2):updateEnmity(target)
        mob:setLocalVar("spawnedLiver", 1)
    end
end

function onMobDeath(mob, player, isKiller)
end
