-----------------------------------
-- Area: Outer Horutoto Ruins (194)
--   NM: Doppelganger Dio
-----------------------------------
---@type TMobEntity
local entity = {}

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
