-----------------------------------
-- Area: Halvung
--  Mob: Gurfurlur the Menacing
-- !pos -59.000 -23.000 3.000 62
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onMobEngaged(mob, target)
    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

function onMobFight(mob, target)
    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        if not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 1):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 1):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 1):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 2):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 2):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 2):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 3):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 3):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 3):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 4):isSpawned() then
            GetMobByID(ID.mob.GURFURLUR_THE_MENACING + 4):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.GURFURLUR_THE_MENACING + 4):updateEnmity(target)
        end
    end

    for i = ID.mob.GURFURLUR_THE_MENACING + 1, ID.mob.GURFURLUR_THE_MENACING + 4 do
        local pet = GetMobByID(i)

        if pet:getCurrentAction() == tpz.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

function onMobDisengage(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.TROLL_SUBJUGATOR)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end

function onMobDespawn(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GURFURLUR_THE_MENACING + i) end
end
