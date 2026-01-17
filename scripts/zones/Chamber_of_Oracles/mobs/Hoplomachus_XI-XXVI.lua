-----------------------------------
-- Area : Chamber of Oracles
-- Mob  : Hoplomachus XI-XXVI
-- BCNM : Legion XI Comitatensis
-- Job  : Paladin
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BANISH_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [2] = { xi.magic.spell.FLASH,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,   0, 100 },
        [3] = { xi.magic.spell.PROTECT_III, mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT, 0,  25 },
        [4] = { xi.magic.spell.SHELL_III,   mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,   0,  25 },
        [5] = { xi.magic.spell.CURE_IV,     mob,    true,  xi.action.type.HEALING_TARGET,    33,                0, 100 },
    }

    local groupTable =
    {
        GetMobByID(mob:getID() - 2), -- Secutor XI-XXXII
        GetMobByID(mob:getID() - 1), -- Retiarius XI-XIX
        GetMobByID(mob:getID() + 1), -- Centurio XI-I
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
