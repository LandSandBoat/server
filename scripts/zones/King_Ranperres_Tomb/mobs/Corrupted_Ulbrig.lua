-----------------------------------
-- Area: King Ranperres Tomb
--   NM: Corrupted Ulbrig
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.ASPIR,       target, false, xi.action.type.DRAIN_MP,             nil,                  0, 100 },
        [ 3] = { xi.magic.spell.POISON_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     0, 100 },
        [ 4] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,       0, 100 },
        [ 5] = { xi.magic.spell.CHOKE,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,      0, 100 },
        [ 6] = { xi.magic.spell.FROST,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,      0, 100 },
        [ 7] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,      0, 100 },
        [ 8] = { xi.magic.spell.SLEEP,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1,  25 },
        [ 9] = { xi.magic.spell.SLEEPGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    1,  25 },
        [10] = { xi.magic.spell.SLEEP_II,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [11] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [12] = { xi.magic.spell.BLIZZAGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [13] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [14] = { xi.magic.spell.TORNADO,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [15] = { xi.magic.spell.BURST,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [16] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
