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
    local effectTable
    {
        [1] = xi.effect.BLINDNESS,
        [2] = xi.effect.BIND,
        [3] = xi.effect.PARALYZE,
        [4] = xi.effect.POISON,
        [5] = xi.effect.SILENCE,
        [6] = xi.effect.SLOW,
        [7] = xi.effect.WEIGHT,
    }

    local pTable =
    {
        chance   = 25,
        effectId = effects[math.random(1, #effects)],
        power    = 20,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDespawn = function(mob)
    DisallowRespawn(ID.mob.VOLUPTUOUS_VILMA, true)
    DisallowRespawn(ID.mob.ROSE_GARDEN_PH, false)
    GetMobByID(ID.mob.ROSE_GARDEN_PH):setRespawnTime(GetMobRespawnTime(ID.mob.ROSE_GARDEN_PH))
end

return entity
