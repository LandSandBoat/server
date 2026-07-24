-----------------------------------
-- Area: QuBia_Arena
--  Mob: Rojgnoj's Right Hand
-- Mission 9-2 San d'Oria
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD_II, target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 3] = { xi.magic.spell.AERO_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 4] = { xi.magic.spell.STONE_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 5] = { xi.magic.spell.WATER_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 6] = { xi.magic.spell.THUNDER,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 7] = { xi.magic.spell.DRAIN,       target, false, xi.action.type.DRAIN_HP,          nil,                0, 100 },
        [ 8] = { xi.magic.spell.ABSORB_TP,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 9] = { xi.magic.spell.ABSORB_MND,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.MND_DOWN, 0, 100 },
        [10] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      4, 100 },
        [11] = { xi.magic.spell.POISON,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,   1, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
