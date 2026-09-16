-----------------------------------
-- Area: Apollyon SW
--  Mob: Fire Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PARALYZE)
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
        [1] = { xi.magic.spell.ENFIRE,       mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENFIRE,       0, 100 },
        [2] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLAZE_SPIKES, 0, 100 },
        [3] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BURN,         0, 100 },
        [4] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [5] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [6] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
