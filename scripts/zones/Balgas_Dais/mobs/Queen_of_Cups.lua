-----------------------------------
-- Area: Balgas Dais
--  Mob: Queen of Cups (WHM)
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BANISH_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 2] = { xi.magic.spell.BANISHGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 3] = { xi.magic.spell.HOLY,         target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 4] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       3, 100 },
        [ 5] = { xi.magic.spell.DIAGA_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       3, 100 },
        [ 6] = { xi.magic.spell.PARALYZE,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS, 0, 100 },
        [ 7] = { xi.magic.spell.SLOW,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,      3, 100 },
        [ 8] = { xi.magic.spell.SILENCE,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SILENCE,   0, 100 },
        [ 9] = { xi.magic.spell.BLINK,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLINK,     0, 100 },
        [10] = { xi.magic.spell.STONESKIN,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
        [11] = { xi.magic.spell.AQUAVEIL,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL,  0, 100 },
        [12] = { xi.magic.spell.HASTE,        mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.HASTE,     5, 100 },
        [13] = { xi.magic.spell.PROTECT_IV,   mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.PROTECT,   0,  25 },
        [14] = { xi.magic.spell.SHELL_IV,     mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.SHELL,     0,  25 },
        [15] = { xi.magic.spell.POISONA,      mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.POISON,    0, 100 },
        [16] = { xi.magic.spell.BLINDNA,      mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.BLINDNESS, 0, 100 },
        [17] = { xi.magic.spell.PARALYNA,     mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.PARALYSIS, 0, 100 },
        [18] = { xi.magic.spell.POISONA,      mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.POISON,    0, 100 },
        [19] = { xi.magic.spell.SILENA,       mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.SILENCE,   0, 100 },
        [20] = { xi.magic.spell.VIRUNA,       mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.DISEASE,   0, 100 },
        [21] = { xi.magic.spell.VIRUNA,       mob,    true,  xi.action.type.HEALING_EFFECT,       xi.effect.PLAGUE,    0, 100 },
        [22] = { xi.magic.spell.CURE_V,       mob,    true,  xi.action.type.HEALING_TARGET,       33,                  0, 100 },
    }

    if mob:hasStatusEffectByFlag(xi.effectFlag.ERASABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.ERASE, mob, true, xi.action.type.NONE, nil, 100 })
    end

    local groupTable =
    {
        GetMobByID(mob:getID() - 4), -- King of Cups
        GetMobByID(mob:getID() - 3), -- King of Batons
        GetMobByID(mob:getID() - 2), -- King of Swords
        GetMobByID(mob:getID() - 1), -- King of Coins
        GetMobByID(mob:getID() + 1), -- Queen of Batons
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
