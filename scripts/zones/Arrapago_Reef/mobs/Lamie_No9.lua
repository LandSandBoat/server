-----------------------------------
-- Area: Arrapago Reef
--   NM: Lamie No.9
-- !pos -228 -4 342 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
-----------------------------------
local lamiasAvatar = 16998743

local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.STUNRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.EARTH_SDT, 200)
    mob:setMod(xi.mod.DARK_SDT, 200)
    mob:setMod(xi.mod.LIGHT_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 200)
    mob:setMod(xi.mod.WATER_SDT, 200)
    mob:setMod(xi.mod.THUNDER_SDT, 200)
    mob:setMod(xi.mod.WIND_SDT, 200)
    mob:addMod(xi.mod.MDEF, 80)
    mob:addMod(xi.mod.DEF, 80)
end

entity.onMobFight = function(mob, target)
    local pet        = GetMobByID(lamiasAvatar)
    local petRespawn = GetMobByID(lamiasAvatar):getLocalVar("respawn")

    if not pet:isDead() and pet:isSpawned() and pet:getCurrentAction() == xi.act.ROAMING then
        pet:updateEnmity(target)
    elseif not pet:isSpawned() and os.time() > petRespawn then
        pet:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
        SpawnMob(lamiasAvatar):updateEnmity(target)
    end

    if mob:getHPP() < 80 and mob:getLocalVar("astralFlow") == 0 then
        mob:setLocalVar("astralFlow", mob:getLocalVar("astralFlow") + 1)
        mob:useMobAbility(734)
        pet:useMobAbility(915)
    elseif mob:getHPP() < 60 and mob:getLocalVar("astralFlow") == 1 then
        mob:setLocalVar("astralFlow", mob:getLocalVar("astralFlow") + 1)
        mob:useMobAbility(734)
        pet:useMobAbility(915)
    elseif mob:getHPP() < 40 and mob:getLocalVar("astralFlow") == 2 then
        mob:setLocalVar("astralFlow", mob:getLocalVar("astralFlow") + 1)
        mob:useMobAbility(734)
        pet:useMobAbility(915)
    elseif mob:getHPP() < 20 and mob:getLocalVar("astralFlow") == 3 then
        mob:setLocalVar("astralFlow", mob:getLocalVar("astralFlow") + 1)
        mob:useMobAbility(734)
        pet:useMobAbility(915)
    end

    mob:addListener("WEAPONSKILL_USE", "LAMIIE_MOBSKILL_USE", function(mobArg, targetArg, skillid)
        if pet:isSpawned() and skillid ~= 734 then
            pet:setTP(3000)
            pet:disengage()
            pet:resetEnmity(targetArg)
            pet:updateEnmity(mob:getTarget())
        end
    end)
end

entity.onMobRoam = function(mob)
    local pet         = GetMobByID(lamiasAvatar)
    local petRespawn  = GetMobByID(lamiasAvatar):getLocalVar("respawn")
    local respawnTime = math.random(60, 90) + os.time()

    if not pet:isDead() and pet:isSpawned() and pet:getCurrentAction() == xi.act.ATTACK then
        mob:updateEnmity(pet:getTarget())
    elseif not pet:isSpawned() and os.time() > petRespawn then
        pet:setSpawn(mob:getXPos() + math.random(1, 5), mob:getYPos(), mob:getZPos() + math.random(1, 5))
        SpawnMob(lamiasAvatar)
        pet:setLocalVar("respawn", respawnTime)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    DespawnMob(lamiasAvatar)
    mob:removeListener("LAMIIE_MOBSKILL_USE")
    mob:setLocalVar("astralFlow", 0)
end

entity.onMobDespawn = function(mob)
    DespawnMob(lamiasAvatar)
end

return entity
