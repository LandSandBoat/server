-----------------------------------
-- Area : Balga's Dais
-- Mob  : Zuu Xowu the Darksmoke
-- BCNM : Divine Punishers
-- Job  : BLM
-- TODO : Capture complete spell list
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.THUNDER_II,   target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 2] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 3] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 4] = { xi.magic.spell.BLIZZAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 5] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 6] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 7] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 8] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [ 9] = { xi.magic.spell.FLOOD,        target, false, xi.action.type.DAMAGE_TARGET,         nil,                    0, 100 },
        [10] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,              nil,                    0, 100 },
        [11] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,              nil,                    0, 100 },
        [12] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.STUN,         0, 100 },
        [13] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.FROST,        0, 100 },
        [14] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.DROWN,        0, 100 },
        [15] = { xi.magic.spell.RASP,         target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.RASP,         0, 100 },
        [16] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.POISON,       0, 100 },
        [17] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.BIO,          4, 100 },
        [18] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.BLINDNESS,    0, 100 },
        [19] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      0,  25 },
        [20] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      0,  25 },
        [21] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      0,  25 },
        [22] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,     xi.effect.SLEEP_I,      0,  25 },
        [23] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF,  xi.effect.BLAZE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
