-----------------------------------
-- Area: Riverne - Site B01
-- Mob: Iruci
-- Notes: The Wyrmking Descends
-- TODO: Capture complete spell list. This one is usable placeholder based off other BLM enemies of similar level.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 2] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 3] = { xi.magic.spell.FIRE_IV,      target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 4] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 5] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 6] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 7] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 8] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 9] = { xi.magic.spell.FREEZE,       target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [10] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,              nil,                    0, 100 },
        [11] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,              nil,                    0, 100 },
        [12] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.STUN,         0, 100 },
        [13] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.DROWN,        0, 100 },
        [14] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.FROST,        0, 100 },
        [15] = { xi.magic.spell.RASP,         target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.RASP,         0, 100 },
        [16] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.BIO,          4, 100 },
        [17] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.POISON,       0, 100 },
        [18] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.BLINDNESS,    0, 100 },
        [19] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      1,  25 },
        [20] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      2,  25 },
        [21] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      1,  25 },
        [22] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      2,  25 },
        [23] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF,  xi.effect.ICE_SPIKES,   0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
