-----------------------------------
-- Area: Hazhalm Testing Grounds
--   Mob: Djigga (Einherjar; Hildesvini Add)
-- Notes: Spawned by Hildesvini. Immune to Light/Dark Sleep, Bind and Gravity.
-- Attacks absorb buffs silently from players.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)

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

    return xi.combat.action.executeAdditionalDispel(mob, target, pTable)
end

return entity
