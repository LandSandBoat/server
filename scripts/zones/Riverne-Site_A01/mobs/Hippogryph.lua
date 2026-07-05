-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Hippogryph
-- Note: PH for Heliodromos
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

local function disturbMob(mob)
    local offset = mob:getID() - ID.mob.HELIODROMOS_OFFSET - 3
    if offset >= 0 and offset <= 2 then
        local zone = mob:getZone()
        if zone then
            zone:setLocalVar('Heliodromos_ToD', GetSystemTime() + math.randomInt(43200, 54000)) -- 12 to 15 hours
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    disturbMob(mob)
end

entity.onMobRoam = function(mob)
    local zone = mob:getZone()
    if not zone then
        return
    end

    if GetSystemTime() < zone:getLocalVar('Heliodromos_ToD') then
        return
    end

    for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
        if GetMobByID(i):isSpawned() then
            return
        end
    end

    -- Despawn placeholders
    for i = ID.mob.HELIODROMOS_OFFSET - 3, ID.mob.HELIODROMOS_OFFSET - 1 do
        DisallowRespawn(i, true)
        DespawnMob(i)
    end

    -- Spawn heliodromos
    for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
        SpawnMob(i)
    end
end

entity.onMobEngage = function(mob, target)
    disturbMob(mob)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { power = 50 })
end

return entity
