-----------------------------------
-- Area: Mamook
--  Mob: Gulool Ja Ja
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
local ID = require("scripts/zones/Mamook/IDs")
mixins = { require("scripts/mixins/job_special") }

-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMobMod(xi.mobMod.DRAW_IN, 2)
end

entity.onMobEngaged = function(mob, target)
    for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
        SpawnMob(i):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    if mob:getBattleTime() % 60 < 2 and mob:getBattleTime() > 10 then
        if not GetMobByID(ID.mob.GULOOL_JA_JA + 1):isSpawned() then
            GetMobByID(ID.mob.GULOOL_JA_JA + 1):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GULOOL_JA_JA + 1):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GULOOL_JA_JA + 2):isSpawned() then
            GetMobByID(ID.mob.GULOOL_JA_JA + 2):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GULOOL_JA_JA + 2):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GULOOL_JA_JA + 3):isSpawned() then
            GetMobByID(ID.mob.GULOOL_JA_JA + 3):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GULOOL_JA_JA + 3):updateEnmity(target)
        elseif not GetMobByID(ID.mob.GULOOL_JA_JA + 4):isSpawned() then
            GetMobByID(ID.mob.GULOOL_JA_JA + 4):setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
            SpawnMob(ID.mob.GULOOL_JA_JA + 4):updateEnmity(target)
        end
    end

    for i = ID.mob.GULOOL_JA_JA + 1, ID.mob.GULOOL_JA_JA + 4 do
        local pet = GetMobByID(i)
        if pet:getCurrentAction() == xi.act.ROAMING then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDisengage = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GULOOL_JA_JA + i) end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SHINING_SCALE_RIFLER)
    for i = 1, 4 do DespawnMob(ID.mob.GULOOL_JA_JA + i) end
end

entity.onMobDespawn = function(mob)
    for i = 1, 4 do DespawnMob(ID.mob.GULOOL_JA_JA + i) end
end

return entity
