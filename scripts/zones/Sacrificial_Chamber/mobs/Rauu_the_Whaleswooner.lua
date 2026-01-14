-----------------------------------
-- Area: Sacrificial Chamber
--  Mob: Rauu the Whaleswooner
-- BCNM: Amphibian Assault
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.LIGHT_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BANISH_II,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                 0, 100 }, -- No condition.
        [ 2] = { xi.magic.spell.CURE_V,      mob,    true,  xi.action.type.HEALING_TARGET,     33,                  0, 100 }, -- HP <= 33%
        [ 3] = { xi.magic.spell.CURAGA_II,   mob,    true,  xi.action.type.HEALING_FORCE_SELF, 33,                  0, 100 }, -- HP <= 33%
        [ 4] = { xi.magic.spell.BLINDNA,     mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.BLINDNESS, 0, 100 }, -- Effect present on self (or on ally if "true")
        [ 5] = { xi.magic.spell.PARALYNA,    mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.PARALYSIS, 0, 100 }, -- Effect present on self (or on ally if "true")
        [ 6] = { xi.magic.spell.POISONA,     mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.POISON,    0, 100 }, -- Effect present on self (or on ally if "true")
        [ 7] = { xi.magic.spell.SILENA,      mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.SILENCE,   0, 100 }, -- Effect present on self (or on ally if "true")
        [ 8] = { xi.magic.spell.VIRUNA,      mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.DISEASE,   0, 100 }, -- Effect present on self (or on ally if "true")
        [ 9] = { xi.magic.spell.VIRUNA,      mob,    true,  xi.action.type.HEALING_EFFECT,     xi.effect.PLAGUE,    0, 100 }, -- Effect present on self (or on ally if "true")
        [10] = { xi.magic.spell.AQUAVEIL,    mob,    false, xi.action.type.ENHANCING_TARGET,   xi.effect.AQUAVEIL,  0, 100 }, -- Effect not present on self (or on ally if "true")
        [11] = { xi.magic.spell.HASTE,       mob,    true,  xi.action.type.ENHANCING_TARGET,   xi.effect.HASTE,     5, 100 }, -- Effect not present on self (or on ally if "true")
        [12] = { xi.magic.spell.PROTECT_III, mob,    true,  xi.action.type.ENHANCING_TARGET,   xi.effect.PROTECT,   0, 100 }, -- Effect not present on self (or on ally if "true")
        [13] = { xi.magic.spell.SHELL_III,   mob,    true,  xi.action.type.ENHANCING_TARGET,   xi.effect.SHELL,     0, 100 }, -- Effect not present on self (or on ally if "true")
        [14] = { xi.magic.spell.DIA_II,      target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.DIA,       3, 100 }, -- Effect not present on target.
        [15] = { xi.magic.spell.PARALYZE,    target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.PARALYSIS, 0, 100 }, -- Effect not present on target.
        [16] = { xi.magic.spell.SILENCE,     target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SILENCE,   0, 100 }, -- Effect not present on target.
    }

    local groupTable =
    {
        GetMobByID(mob:getID() - 1), -- Qull the Fallstopper
        GetMobByID(mob:getID() + 1), -- Hyohh the Conchblower
        GetMobByID(mob:getID() + 2), -- Pevv the Riverleaper
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
