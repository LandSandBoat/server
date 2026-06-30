-----------------------------------
-- Area: Sacrarium
--   NM: Indich
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.VALOR_MINUET_III,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MINUET,  0, 100 },
        [ 2] = { xi.magic.spell.ADVANCING_MARCH,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MARCH,   0, 100 },
        [ 3] = { xi.magic.spell.ARMYS_PAEON_IV,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.PAEON,   0, 100 },
        [ 4] = { xi.magic.spell.DEXTROUS_ETUDE,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ETUDE,   0, 100 },
        [ 5] = { xi.magic.spell.FOE_REQUIEM_V,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.REQUIEM, 5, 100 },
        [ 6] = { xi.magic.spell.BATTLEFIELD_ELEGY, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.ELEGY,   1, 100 },
        [ 7] = { xi.magic.spell.HORDE_LULLABY,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I, 1, 100 },
        [ 8] = { xi.magic.spell.FOE_LULLABY,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I, 1, 100 },
        [ 9] = { xi.magic.spell.FLASH,             target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.FLASH,   1, 100 },
        [10] = { xi.magic.spell.MAGIC_FINALE,      target, false, xi.action.type.NONE,                 nil,               0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
