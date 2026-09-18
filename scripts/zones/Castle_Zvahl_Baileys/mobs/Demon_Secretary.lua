-----------------------------------
-- Area: Castle Zvahl Baileys (161)
-- Demon Secretary
-- Quest: Better The Demon You Know
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)

    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addStatusEffect(xi.effect.STUN, { duration = 5, origin = mob, flag = xi.effectFlag.NO_LOSS_MESSAGE, silent = true }) -- Holds the mobs until the NM has "arrived"
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_II,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 3] = { xi.magic.spell.THUNDER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 4] = { xi.magic.spell.WATER_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 5] = { xi.magic.spell.FIRAGA,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 6] = { xi.magic.spell.AEROGA_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 7] = { xi.magic.spell.STONEGA_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 8] = { xi.magic.spell.THUNDAGA,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                    0, 100 },
        [ 9] = { xi.magic.spell.POISON_II,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,       2, 100 },
        [10] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,          4, 100 },
        [11] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BURN,         1, 100 },
        [12] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FROST,        1, 100 },
        [13] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHOKE,        1, 100 },
        [14] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DROWN,        1, 100 },
        [15] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,          nil,                    0, 100 },
        [16] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,          nil,                    0, 100 },
        [17] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLAZE_SPIKES, 1, 100 },
        [18] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,         1, 100 },
        [19] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,      1, 100 },
        [20] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS,    1, 100 },
        [21] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,         1, 100 },
        [22] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,      2, 100 },
        [23] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,      1, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
