-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Doppelganger Dio
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  310.000, y =  0.000, z =  710.000 },
    { x =  508.000, y =  0.000, z =  709.000 },
    { x =  530.000, y =  0.000, z =  775.000 }
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 50,
        effectId = xi.effect.EVASION_DOWN,
        power    = 10,
        duration = 60,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

return entity
