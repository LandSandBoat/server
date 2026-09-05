-----------------------------------
-- Area: Horlais Peak
--  Mob: Darokbok of Clan Reaper
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)

    -- Return to normal facing after turning to buff his party.
    mob:addListener('MAGIC_STATE_EXIT', 'RESTORE_FACING', function(mobArg, spell)
        if not mobArg:isEngaged() then
            mobArg:setRotation(mobArg:getSpawnPos().rot)
        end
    end)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BANISH_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,               0, 100 },
        [2] = { xi.magic.spell.FLASH,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,   0, 100 },
        [3] = { xi.magic.spell.PROTECT_III, mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT, 0,  25 },
        [4] = { xi.magic.spell.SHELL_III,   mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,   0,  25 },
        [5] = { xi.magic.spell.CURE_IV,     mob,    true,  xi.action.type.HEALING_TARGET,    90,                0, 100 },
    }

    local groupTable =
    {
        GetMobByID(mob:getID() + 1), -- Jagidbod of Clan Reaper
        GetMobByID(mob:getID() + 2), -- Derakbak of Clan Wolf
        GetMobByID(mob:getID() + 3), -- Reaper Clan Warmachine
        GetMobByID(mob:getID() + 4), -- Wolf Clan Warmachine
        GetMobByID(mob:getID() + 5), -- Orc's Wyvern
    }

    return xi.combat.behavior.chooseAction(mob, target, groupTable, spellList)
end

return entity
