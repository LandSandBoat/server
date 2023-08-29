-----------------------------------
-- Area: Halvung
--  Mob: Gurfurlur the Menacing
-- !pos -59.000 -23.000 3.000 62
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.HALVUNG]
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        if not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 1):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 1):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 1):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 2):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 2):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 2):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 3):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 3):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 3):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 4):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 4):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 4):updateEnmity(target)
        end
    end

    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        local pet = GetMobByID(i)

        if pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDisengage = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TROLL_SUBJUGATOR)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

entity.onMobDespawn = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

return entity
