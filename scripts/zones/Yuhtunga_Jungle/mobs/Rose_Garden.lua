-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Rose Garden
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

local function updateRegen(mob)
    local hour = VanadielHour()
    if hour >= 6 and hour < 18 then
        mob:setMod(xi.mod.REGEN, 25)
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobSpawn = function(mob)
    updateRegen(mob)

    mob:setLocalVar('timeToGrow', GetSystemTime() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)

    -- Rose Garden has been left alone for 10.25 hours
    if GetSystemTime() >= mob:getLocalVar('timeToGrow') then
        DisallowRespawn(ID.mob.ROSE_GARDEN, true)
        DespawnMob(ID.mob.ROSE_GARDEN)
        DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, false)

        local pos = mob:getPos()
        SpawnMob(ID.mob.VOLUPTUOUS_VILMA):setPos(pos.x, pos.y, pos.z, pos.rot)
    end
end

entity.onMobFight = function(mob)
    updateRegen(mob)
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('timeToGrow', GetSystemTime() + math.random(36000, 37800)) -- 10:00:00 to 10:30:00
end

entity.onMobDespawn = function(mob)
    if GetSystemTime() < mob:getLocalVar('timeToGrow') then
        local roseGardenPH = ID.mob.ROSE_GARDEN - 1

        DisallowRespawn(ID.mob.ROSE_GARDEN, true)
        DisallowRespawn(roseGardenPH, false)
        GetMobByID(roseGardenPH):setRespawnTime(GetMobRespawnTime(roseGardenPH))
    end
end

return entity
