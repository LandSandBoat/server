-----------------------------------
-- Area: Chamber of Oracles
--  Mob: Centurio V-III
-- Zilart 6 Fight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Return to normal facing after turning to buff his party.
    mob:addListener('MAGIC_STATE_EXIT', 'RESTORE_FACING', function(mobArg, spell)
        if not mobArg:isEngaged() then
            mobArg:setRotation(mobArg:getSpawnPos().rot)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 22)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.CURE_IV,    mob,    true,  xi.action.type.HEALING_TARGET,    50,                0, 100 },
        [2] = { xi.magic.spell.PROTECT_IV, mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT, 0, 100 },
        [3] = { xi.magic.spell.SHELL_III,  mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,   0, 100 },
        [4] = { xi.magic.spell.FLASH,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,   1, 100 },
        [5] = { xi.magic.spell.BANISH_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,               0,  50 },
    }

    local groupTable =
    {
        GetMobByID(mob:getID() + 1),
        GetMobByID(mob:getID() + 2),
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
