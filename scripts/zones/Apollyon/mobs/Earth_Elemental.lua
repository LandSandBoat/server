-----------------------------------
-- Area: Apollyon SW
--  Mob: Earth Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
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
        [2] = { xi.magic.spell.ENSTONE,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENSTONE,   0, 100 },
        [3] = { xi.magic.spell.SLOW,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW,      3, 100 },
        [4] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.RASP,      0, 100 },
        [5] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [6] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [7] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
