-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Coins (RDM)
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
end

entity.onMobEngage = function(mob, target)
    -- When King of Coins is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 3) -- King of Cups
    DespawnMob(mobId - 2) -- King of Batons
    DespawnMob(mobId - 1) -- King of Swords
    SpawnMob(mobId + 1)   -- Queen of Cups
    SpawnMob(mobId + 2)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance  = 25,
        element = xi.element.DARK,
    }

    return xi.combat.action.executeAdditionalDispel(mob, target, pTable)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_III,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 3] = { xi.magic.spell.AERO_III,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 4] = { xi.magic.spell.WATER_III,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 5] = { xi.magic.spell.THUNDER_III,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 6] = { xi.magic.spell.STONE_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 7] = { xi.magic.spell.BIO_III,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,       6, 100 },
        [ 8] = { xi.magic.spell.POISON_II,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,    0, 100 },
        [ 9] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       3, 100 },
        [10] = { xi.magic.spell.DIAGA_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       3, 100 },
        [11] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,      0, 100 },
        [12] = { xi.magic.spell.GRAVITY,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.WEIGHT,    0, 100 },
        [13] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,   0,  50 },
        [14] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_II,  0,  50 },
        [15] = { xi.magic.spell.SLOW,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,      3, 100 },
        [16] = { xi.magic.spell.PARALYZE,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PARALYSIS, 0, 100 },
        [17] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS, 0, 100 },
        [18] = { xi.magic.spell.BLINK,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLINK,     0, 100 },
        [19] = { xi.magic.spell.STONESKIN,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
        [20] = { xi.magic.spell.AQUAVEIL,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL,  0, 100 },
        [21] = { xi.magic.spell.ENWATER,      mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ENWATER,   0, 100 },
        [22] = { xi.magic.spell.PROTECT_IV,   mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.PROTECT,   0,  25 },
        [23] = { xi.magic.spell.SHELL_IV,     mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.SHELL,     0,  25 },
        [24] = { xi.magic.spell.HASTE,        mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.HASTE,     5, 100 },
        [25] = { xi.magic.spell.REGEN,        mob,    true,  xi.action.type.ENHANCING_TARGET,     xi.effect.REGEN,     0, 100 },
        [26] = { xi.magic.spell.CURE_IV,      mob,    true,  xi.action.type.HEALING_TARGET,       33,                  0, 100 },
    }

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, #spellList + 1, { xi.magic.spell.DISPEL, target, false, xi.action.type.NONE, nil, 100 })
    end

    local groupTable =
    {
        GetMobByID(mob:getID() + 1), -- Queen of Cups
        GetMobByID(mob:getID() + 2), -- Queen of Batons
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
