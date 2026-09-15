-----------------------------------
-- Area: Apollyon SW
--  Mob: Water Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.AQUAVEIL,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.AQUAVEIL, 0, 100 },
        [2] = { xi.magic.spell.ENWATER,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENWATER,  0, 100 },
        [3] = { xi.magic.spell.POISON_II,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,   0, 100 },
        [4] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DROWN,    0, 100 },
        [5] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [6] = { xi.magic.spell.WATERGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [7] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
