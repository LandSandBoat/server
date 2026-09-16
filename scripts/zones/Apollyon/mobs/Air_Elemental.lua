-----------------------------------
-- Area: Apollyon SW
--  Mob: Air Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BLINK,      mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,   0, 100 },
        [2] = { xi.magic.spell.ENAERO,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENAERO,  0, 100 },
        [3] = { xi.magic.spell.SILENCE,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SILENCE, 0, 100 },
        [4] = { xi.magic.spell.CHOKE,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHOKE,   0, 100 },
        [5] = { xi.magic.spell.AERO_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [6] = { xi.magic.spell.AEROGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [7] = { xi.magic.spell.TORNADO,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
