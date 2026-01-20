-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Maldaramet B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 5)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [ 2] = { xi.magic.spell.WATER_III,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [ 3] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [ 4] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [ 5] = { xi.magic.spell.THUNDAGA_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [ 6] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,          nil,                 0, 100 },
        [ 7] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,          nil,                 0, 100 },
        [ 8] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 0, 100 },
        [ 9] = { xi.magic.spell.POISON_II,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,    0, 100 },
        [10] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       4, 100 },
        [11] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   0, 100 },
        [12] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,      0, 100 },
    }

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPEL, target, false, xi.action.type.NONE, nil, 100 })
    end

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVASION_DOWN)
end

return entity
