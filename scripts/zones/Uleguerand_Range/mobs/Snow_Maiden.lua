-----------------------------------
-- Area: Uleguerand Range
--   NM: Snow Maiden
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(43200, 46800)) -- 12 to 13 hourss
end

entity.onMobRoam = function(mob)
    -- Snow Maiden has been left alone for 12 to 13 hours
    if GetSystemTime() >= mob:getLocalVar('timeToGrow') then
        DisallowRespawn(ID.mob.SNOW_MAIDEN, true)
        DespawnMob(ID.mob.SNOW_MAIDEN)
        DisallowRespawn(ID.mob.FATHER_FROST, false)

        local pos = mob:getPos()
        SpawnMob(ID.mob.FATHER_FROST):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('timeToGrow', GetSystemTime() + math.randomInt(43200, 46800)) -- 12 to 13 hours
end

entity.onMobDespawn = function(mob)
    if GetSystemTime() < mob:getLocalVar('timeToGrow') then
        local snowMaidenPH = ID.mob.SNOW_MAIDEN - 1

        DisallowRespawn(ID.mob.SNOW_MAIDEN, true)
        DisallowRespawn(snowMaidenPH, false)
        GetMobByID(snowMaidenPH):setRespawnTime(GetMobRespawnTime(snowMaidenPH))
    end
end

return entity
