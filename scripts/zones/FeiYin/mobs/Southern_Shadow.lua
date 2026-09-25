-----------------------------------
-- Area: Fei'Yin
--   NM: Southern Shadow
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SOUTHERN_SHADOW - 3] = ID.mob.SOUTHERN_SHADOW, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 50,
        effectId = xi.effect.EVASION_DOWN,
        power    = 25,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

return entity
