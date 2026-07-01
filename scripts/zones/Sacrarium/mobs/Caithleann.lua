-----------------------------------
-- Area: Sacrarium
--   NM: Caithleann
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
        [ 1] = { xi.magic.spell.UTSUSEMI_NI,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.COPY_IMAGE, 0, 100 },
        [ 2] = { xi.magic.spell.UTSUSEMI_ICHI, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.COPY_IMAGE, 0, 100 },
        [ 3] = { xi.magic.spell.STONESKIN,     mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN,  0, 100 },
        [ 4] = { xi.magic.spell.BLINK,         mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,      0, 100 },
        [ 5] = { xi.magic.spell.PROTECT_III,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT,    0, 100 },
        [ 6] = { xi.magic.spell.AQUAVEIL,      mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.AQUAVEIL,   0, 100 },
        [ 7] = { xi.magic.spell.DIA_II,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,        3, 100 },
        [ 8] = { xi.magic.spell.DIAGA_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,        3, 100 },
        [ 9] = { xi.magic.spell.BLIND,         target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS,  1, 100 },
        [10] = { xi.magic.spell.KURAYAMI_ICHI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS,  1, 100 },
        [11] = { xi.magic.spell.JUBAKU_ICHI,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS,  1, 100 },
        [12] = { xi.magic.spell.DISPEL,        target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [13] = { xi.magic.spell.BLIZZARD_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [14] = { xi.magic.spell.STONE_II,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [15] = { xi.magic.spell.WATER_II,      target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [16] = { xi.magic.spell.AERO_II,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
