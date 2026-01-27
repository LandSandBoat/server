-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Djigga (Einherjar)
-- Notes: Attacks absorb buffs silently from players.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance       = 25,
        absorbEffect = true,
        animation    = xi.subEffect.STATUS_DRAIN,
        message      = xi.msg.basic.NONE,
    }

    return xi.combat.action.executeAddEffectDispel(mob, target, pTable)
end

return entity
