-----------------------------------
-- Area: Ship Bound for Selbina (Pirates)
--   NM: Blackbeard
-- To do: This NM does not use an SP ability like JP wiki claims but it does have a dust cloud animation that triggers as soon as it is pushed below 50% HP.
-- It is unclear what this does, if anything, after multiple retail captures.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)
    mob:setMod(xi.mod.ICE_RES_RANK, 10)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 55)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setRespawnTime(0) -- one-and-done per ride; the 1s spawn timer must not respawn him
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.STUN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,       0, 100 },
        [ 3] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 4] = { xi.magic.spell.SLEEP_II,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 5] = { xi.magic.spell.SLEEPGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 6] = { xi.magic.spell.BURST,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 7] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 8] = { xi.magic.spell.WATERGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [ 9] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [10] = { xi.magic.spell.THUNDAGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [11] = { xi.magic.spell.THUNDER_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [12] = { xi.magic.spell.FREEZE,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
