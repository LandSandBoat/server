-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Voluptuous Vilma
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

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    updateRegen(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobRoam = function(mob)
    updateRegen(mob)
end

entity.onMobFight = function(mob)
    updateRegen(mob)
end

entity.onAdditionalEffect = function(mob, target, damage)
    -- Vilma randomly effects its target with one of the following effects
    local effects =
    {
        [1] = xi.mob.ae.POISON,
        [2] = xi.mob.ae.PARALYZE,
        [3] = xi.mob.ae.BLIND,
        [4] = xi.mob.ae.SILENCE,
        [5] = xi.mob.ae.WEIGHT,
        [6] = xi.mob.ae.SLOW,
        [7] = xi.mob.ae.BIND,
    }
    local random = math.random(1, #effects)

    return xi.mob.onAddEffect(mob, target, damage, effects[random])
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, true)
    DisallowRespawn(ID.mob.ROSE_GARDEN_PH, false)
    GetMobByID(ID.mob.ROSE_GARDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.ROSE_GARDEN_PH))
end

return entity
