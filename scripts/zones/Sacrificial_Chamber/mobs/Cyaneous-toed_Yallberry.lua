-----------------------------------
-- Area : Sacrificial Chamber
-- Mob  : Cyaneous-toed Yallberry
-- BCNM : Jungle Boogymen
-- Job  : Ninja
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.DOTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 2] = { xi.magic.spell.HYOTON_NI,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 3] = { xi.magic.spell.HUTON_NI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 4] = { xi.magic.spell.KATON_NI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 5] = { xi.magic.spell.RAITON_NI,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 6] = { xi.magic.spell.SUITON_NI,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [ 7] = { xi.magic.spell.DOKUMORI_NI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,     0, 100 },
        [ 8] = { xi.magic.spell.KURAYAMI_NI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS,  0, 100 },
        [ 9] = { xi.magic.spell.HOJO_NI,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW,       4, 100 },
        [10] = { xi.magic.spell.JUBAKU_NI,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS,  0, 100 },
        [11] = { xi.magic.spell.UTSUSEMI_NI, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.COPY_IMAGE, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
