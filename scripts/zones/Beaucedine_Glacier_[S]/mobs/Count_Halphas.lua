-----------------------------------
--  Count Halphas (WotG 19)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local nmId = mob:getID()

    for mobId = nmId + 1, nmId + 4 do
        SpawnMob(mobId)
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDespawn = function(mob)
    local nmId = mob:getID()

    for mobId = nmId + 1, nmId + 4 do
        if GetMobByID(mobId):isSpawned() then
            DespawnMob(mobId)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local nmId = mob:getID()

    for mobId = nmId + 1, nmId + 4 do
        if GetMobByID(mobId):isSpawned() then
            DespawnMob(mobId)
        end
    end
end

return entity
