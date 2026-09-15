-----------------------------------
-- Area: Apollyon SW
--  Mob: Light Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
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
        [1] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN, 0, 100 },
        [2] = { xi.magic.spell.FLASH,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,     0, 100 },
        [3] = { xi.magic.spell.DIAGA_II,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,       3, 100 },
        [4] = { xi.magic.spell.BANISH_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [5] = { xi.magic.spell.BANISHGA_II, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
