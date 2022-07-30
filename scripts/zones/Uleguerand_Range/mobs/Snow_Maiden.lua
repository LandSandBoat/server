-----------------------------------
-- Area: Uleguerand Range
--  Mob: Snow Maiden
-- Note: PH for Father Frost
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 15)
    mob:setLocalVar("timeToGrow", os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar("timeToGrow", os.time() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
end

entity.onMobRoam = function(mob)
    -- Snow Maiden morphs into Father Frost if left alone
    if os.time() >= mob:getLocalVar("timeToGrow") then
        DisallowRespawn(ID.mob.SNOW_MAIDEN, true)
        DespawnMob(ID.mob.SNOW_MAIDEN)
        DisallowRespawn(ID.mob.FATHER_FROST, false)
        local pos = mob:getPos()
        SpawnMob(ID.mob.FATHER_FROST):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    if os.time() < mob:getLocalVar("timeToGrow") then
        DisallowRespawn(ID.mob.SNOW_MAIDEN, true)
        DisallowRespawn(ID.mob.MAIDEN_PH, false)
        GetMobByID(ID.mob.MAIDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.MAIDEN_PH))
    end
end

return entity
