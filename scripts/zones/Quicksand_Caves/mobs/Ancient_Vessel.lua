-----------------------------------
-- Area: Quicksand Caves
--  Mob: Ancient Vessel
-- Mithra and the Crystal (Zilart 12) Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addMod(xi.mod.SILENCE_RES_RANK, 11)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 300)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 20,
        effectId = xi.effect.STUN,
        duration = 8,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1, 100 },
        [ 3] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      2, 100 },
        [ 4] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,         0, 100 },
        [ 5] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,    0, 100 },
        [ 6] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,          4, 100 },
        [ 7] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,       0, 100 },
        [ 8] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BURN,         0, 100 },
        [ 9] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,        0, 100 },
        [10] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,        0, 100 },
        [11] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,        0, 100 },
        [12] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                    0, 100 },
        [13] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                    0, 100 },
        [14] = { xi.magic.spell.STONE_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [15] = { xi.magic.spell.WATER_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [16] = { xi.magic.spell.AERO_IV,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [17] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [18] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [19] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [20] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
