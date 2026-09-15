-----------------------------------
-- Area: Apollyon SW
--  Mob: Thunder Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.ENTHUNDER,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENTHUNDER,    0, 100 },
        [2] = { xi.magic.spell.SHOCK_SPIKES, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.SHOCK_SPIKES, 0, 100 },
        [3] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,         0, 100 },
        [4] = { xi.magic.spell.SHOCK,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SHOCK,        0, 100 },
        [5] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [6] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [7] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
