-----------------------------------
-- Area: Apollyon SW
--  Mob: Ice Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
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
        [1] = { xi.magic.spell.ENBLIZZARD,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENBLIZZARD, 0, 100 },
        [2] = { xi.magic.spell.ICE_SPIKES,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ICE_SPIKES, 0, 100 },
        [3] = { xi.magic.spell.PARALYZE,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS,  0, 100 },
        [4] = { xi.magic.spell.FROST,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FROST,      0, 100 },
        [5] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [6] = { xi.magic.spell.BLIZZAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [7] = { xi.magic.spell.FREEZE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
