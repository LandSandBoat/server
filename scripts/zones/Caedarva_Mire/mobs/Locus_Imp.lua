-----------------------------------
-- Area: Caedarva Mire
--  Mob: Locus Imp
--  TODO:
--   - Horn break rate
--   - Stats (except Level/HP)
--   - Resistances
--   - Drops
-----------------------------------
mixins = { require('scripts/mixins/families/imp'), require('scripts/mixins/families/imp_aggro') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 500) -- Remove this mod when mob has been correctly captured
end

entity.onMobSpellChoose = function(mob, target, spell)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 3] = { xi.magic.spell.AERO_III,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 4] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 5] = { xi.magic.spell.WATER_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 6] = { xi.magic.spell.FIRAGA_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 7] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 8] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                     0, 100 },
        [ 9] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                     0, 100 },
        [10] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,          0, 100 },
        [11] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,     0, 100 },
        [12] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,          0, 100 },
        [13] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BURN,          0, 100 },
        [14] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,         0, 100 },
        [15] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,         0, 100 },
        [16] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,         0, 100 },
        [17] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,           4, 100 },
        [18] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,        0, 100 },
        [19] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,       0,  50 },
        [20] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,       0,  50 },
        [21] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,       0,  50 },
        [22] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,       0,  50 },
        [23] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES,  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
