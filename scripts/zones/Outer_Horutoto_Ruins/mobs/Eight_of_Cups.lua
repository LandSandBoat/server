-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Cups
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 10,
        effectId = xi.effect.MUTE,
        element  = xi.element.WIND,
        duration = 3600,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.amk.helpers.cardianOrbDrop(mob, player, xi.ki.ORB_OF_CUPS)
    xi.regime.checkRegime(player, mob, 667, 1, xi.regime.type.GROUNDS)
end

return entity
