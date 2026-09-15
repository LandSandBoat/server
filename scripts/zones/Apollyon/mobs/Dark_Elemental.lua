-----------------------------------
-- Area: Apollyon SW
--  Mob: Dark Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BIO_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      4, 100 },
        [ 2] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,          nil,                0, 100 },
        [ 3] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DRAIN_MP,          nil,                0, 100 },
        [ 4] = { xi.magic.spell.STUN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,     0, 100 },
        [ 5] = { xi.magic.spell.DISPEL,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 6] = { xi.magic.spell.SLEEPGA,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,  1, 100 },
        [ 7] = { xi.magic.spell.ABSORB_STR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STR_DOWN, 0, 100 },
        [ 8] = { xi.magic.spell.ABSORB_DEX, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DEX_DOWN, 0, 100 },
        [ 9] = { xi.magic.spell.ABSORB_VIT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.VIT_DOWN, 0, 100 },
        [10] = { xi.magic.spell.ABSORB_AGI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.AGI_DOWN, 0, 100 },
        [11] = { xi.magic.spell.ABSORB_INT, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.INT_DOWN, 0, 100 },
        [12] = { xi.magic.spell.ABSORB_MND, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.MND_DOWN, 0, 100 },
        [13] = { xi.magic.spell.ABSORB_CHR, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHR_DOWN, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
