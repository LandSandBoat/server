-----------------------------------
-- Area: QuBia_Arena
--  Mob: Rojgnoj's Left Hand
-- Mission 9-2 San d'Oria
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_III,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [ 2] = { xi.magic.spell.THUNDER_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [ 3] = { xi.magic.spell.AEROGA_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [ 4] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [ 5] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,     4, 100 },
        [ 6] = { xi.magic.spell.POISONGA_II, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,  1, 100 },
        [ 7] = { xi.magic.spell.STUN,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,    1, 100 },
        [ 8] = { xi.magic.spell.SLEEP,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I, 1, 100 },
        [ 9] = { xi.magic.spell.SLEEPGA,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I, 1, 100 },
        [10] = { xi.magic.spell.SLEEPGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I, 2, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
