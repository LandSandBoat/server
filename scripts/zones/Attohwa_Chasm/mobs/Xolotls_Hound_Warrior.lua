-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Hound Warrior
-- Note: Pet for Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 3] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    2, 100 },
        [ 4] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,       0, 100 },
        [ 5] = { xi.magic.spell.GRAVITY,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.WEIGHT,     0, 100 },
        [ 6] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FROST,      0, 100 },
        [ 7] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,      0, 100 },
        [ 8] = { xi.magic.spell.RASP,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,       0, 100 },
        [ 9] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,      0, 100 },
        [10] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        4, 100 },
        [11] = { xi.magic.spell.BIO_III,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        6, 100 },
        [12] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,     0, 100 },
        [13] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                  0, 100 },
        [14] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                  0, 100 },
        [15] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [16] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [17] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [18] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [19] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [20] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [21] = { xi.magic.spell.AERO_IV,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [22] = { xi.magic.spell.WATER_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [23] = { xi.magic.spell.BURST,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
        [24] = { xi.magic.spell.FLOOD,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local xolotl = GetMobByID(zones[xi.zone.ATTOHWA_CHASM].mob.XOLOTL)
        if xolotl then
            xolotl:setLocalVar('hound_spawn_time', GetSystemTime() + 60)
        end
    end
end

return entity
