-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Grande
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGAIN, 300)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.HOLY,         target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 2] = { xi.magic.spell.BANISH_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 3] = { xi.magic.spell.BANISHGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [ 4] = { xi.magic.spell.DIA_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       3, 100 },
        [ 5] = { xi.magic.spell.DIAGA_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DIA,       3, 100 },
        [ 6] = { xi.magic.spell.FLASH,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FLASH,     0, 100 },
        [ 7] = { xi.magic.spell.PROTECT_IV,   mob,    false, xi.action.type.ENHANCING_TARGET,     xi.effect.PROTECT,   4, 100 },
        [ 8] = { xi.magic.spell.SHELL_IV,     mob,    false, xi.action.type.ENHANCING_TARGET,     xi.effect.SHELL,     4, 100 },
        [ 9] = { xi.magic.spell.HASTE,        mob,    false, xi.action.type.ENHANCING_TARGET,     xi.effect.HASTE,     0, 100 },
        [10] = { xi.magic.spell.REGEN,        mob,    false, xi.action.type.ENHANCING_TARGET,     xi.effect.REGEN,     1, 100 },
        [11] = { xi.magic.spell.BLINK,        mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLINK,     0, 100 },
        [12] = { xi.magic.spell.STONESKIN,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
        [13] = { xi.magic.spell.AQUAVEIL,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL,  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 25,
        magicalElement = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(mob, target, pTable)
end

entity.onMobDespawn = function(mob)
    GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
