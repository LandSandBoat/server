-----------------------------------
-- Area : Waughroon Shrine
-- Mob  : Ea'Tho Cruelheart
-- BCNM : Grimshell Shocktroopers
-- Job  : DRK
--TODO : Capture complete spell list
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.AERO_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100 },
        [ 2] = { xi.magic.spell.WATER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,              0, 100 },
        [ 3] = { xi.magic.spell.ABSORB_TP,  target, false, xi.action.type.NONE,              nil,              0, 100 },
        [ 4] = { xi.magic.spell.ABSORB_STR, target, false, xi.action.type.NONE,              nil,              0, 100 },
        [ 5] = { xi.magic.spell.ABSORB_VIT, target, false, xi.action.type.NONE,              nil,              0, 100 },
        [ 6] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,          nil,              0, 100 },
        [ 7] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DRAIN_MP,          nil,              0, 100 },
        [ 8] = { xi.magic.spell.STUN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,   0, 100 },
        [ 9] = { xi.magic.spell.POISON,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON, 0, 100 },
        [10] = { xi.magic.spell.BIO_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,    4, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
