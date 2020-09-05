-----------------------------------
-- Area: Arrapago Reef
--   NM: Medusa
-- !pos -458 -20 458
-- TODO: resists, attack/def boosts
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/titles")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        chance = 75, -- "Is possible that she will not use Eagle Eye Shot at all." (guessing 75 percent)
        specials =
        {
            {id = tpz.jsa.EES_LAMIA, hpp = math.random(5, 99)},
        },
    })
end

function onMobEngaged(mob, target)
    target:showText(mob, ID.text.MEDUSA_ENGAGE)
    for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

function onMobFight(mob, target)
    if (mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10) then
        if (not GetMobByID(ID.mob.MEDUSA + 1):isSpawned()) then
            GetMobByID(ID.mob.MEDUSA + 1):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.MEDUSA + 1):updateEnmity(target)
        elseif (not GetMobByID(ID.mob.MEDUSA + 2):isSpawned()) then
            GetMobByID(ID.mob.MEDUSA + 2):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.MEDUSA + 2):updateEnmity(target)
        elseif (not GetMobByID(ID.mob.MEDUSA + 3):isSpawned()) then
            GetMobByID(ID.mob.MEDUSA + 3):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.MEDUSA + 3):updateEnmity(target)
        elseif (not GetMobByID(ID.mob.MEDUSA + 4):isSpawned()) then
            GetMobByID(ID.mob.MEDUSA + 4):setSpawn(mob:getXPos()+math.random(1, 5), mob:getYPos(), mob:getZPos()+math.random(1, 5))
            SpawnMob(ID.mob.MEDUSA + 4):updateEnmity(target)
        end
    end
    for i = ID.mob.MEDUSA + 1, ID.mob.MEDUSA + 4 do
        local pet = GetMobByID(i)
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobDisengage(mob)
    for i = 1, 4 do DespawnMob(ID.mob.MEDUSA + i) end
end

function onMobDeath(mob, player, isKiller)
    player:showText(mob, ID.text.MEDUSA_DEATH)
    player:addTitle(tpz.title.GORGONSTONE_SUNDERER)
    for i = 1, 4 do DespawnMob(ID.mob.MEDUSA + i) end
end

function onMobDespawn(mob)
    for i = 1, 4 do DespawnMob(ID.mob.MEDUSA + i) end
end
