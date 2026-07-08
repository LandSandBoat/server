-----------------------------------
-- Area: Caedarva Mire
--   NM: Zikko
-- !pos -608.5 11.3 -186.5 79
-----------------------------------
mixins =
{
    require('scripts/mixins/families/imp'),
    require('scripts/mixins/job_special'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLocalVar('cooldown', GetSystemTime())
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 25) -- Auto attacks are weak. To do: This modifier was done to recreate the retail capture damage, but actual auto attack damage reduction method needs to be researched.
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 10)
end

entity.onAdditionalEffect = function(mob, target, damage) -- To do: Capture the power and duration range
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.WEIGHT,
        power    = 75,
        duration = 30,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,         0, 100 },
        [ 3] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 4] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 5] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1,  25 },
        [ 6] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1,  25 },
        [ 7] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      2, 100 },
        [ 8] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      2, 100 },
        [ 9] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,    0, 100 },
        [10] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,       0, 100 },
        [11] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,        0, 100 },
        [12] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,        0, 100 },
        [13] = { xi.magic.spell.FIRAGA_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [14] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [15] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [16] = { xi.magic.spell.WATER_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [17] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [18] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },

    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 469)
end

entity.onMobDespawn = function(mob)
    local respawn = math.randomInt(60, 75) * 60 -- 60 to 75 minutes
    mob:setLocalVar('cooldown', GetSystemTime() + respawn)
end

return entity
