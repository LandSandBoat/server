-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Suu Xicu the Cantabile
-- TODO:
--  Summoning of pets should be tied to Soul Voice usage.
--  Gains a hidden regen from Army's Paeon V. Even if it is dispelled, it will gain several HP%.
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobRoam(mob, target)
    local mobId = mob:getID()
    local hpp = mob:getHPP()

    if hpp > 50 and mob:getLocalVar("petsOne") == 1 then
        mob:setLocalVar("petsOne", 0)

        for i = mobId + 5, mobId + 6 do
            local pet = GetMobByID(i)
            if pet:isSpawned() then
                DespawnMob(i)
            end
        end
    end

    if hpp > 25 and mob:getLocalVar("petsTwo") == 1 then
        mob:setLocalVar("petsTwo", 0)

        for i = mobId + 7, mobId + 8 do
            local pet = GetMobByID(i)
            if pet:isSpawned() then
                DespawnMob(i)
            end
        end
    end
end

function onMobFight(mob, target)
    local mobId = mob:getID()
    local hpp = mob:getHPP()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    if hpp < 50 and mob:getLocalVar("petsOne") == 0 then
        mob:setLocalVar("petsOne", 1)

        for i = mobId + 5, mobId + 6 do
            local pet = GetMobByID(i)
            if not pet:isSpawned() then
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2), r)
                pet:spawn()
            end
        end
    end

    if hpp < 25 and mob:getLocalVar("petsTwo") == 0 then
        mob:setLocalVar("petsTwo", 1)

        for i = mobId + 7, mobId + 8 do
            local pet = GetMobByID(i)
            if not pet:isSpawned() then
                pet:setSpawn(x + math.random(-2, 2), y, z + math.random(-2, 2), r)
                pet:spawn()
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local mobId = mob:getID()

    for i = mobId + 5, mobId + 8 do
        local pet = GetMobByID(i)
        if pet:isSpawned() then
            DespawnMob(i)
        end
    end

    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end
