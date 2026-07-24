-----------------------------------
-- Area: QuBia_Arena
--  Mob: Warlord Rojgnoj
-- Mission 9-2 San d'Oria
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGEN, 30)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)

    -- Return to normal facing after turning to buff his party.
    mob:addListener('MAGIC_STATE_EXIT', 'RESTORE_FACING', function(mobArg, spell)
        if not mobArg:isEngaged() then
            mobArg:setRotation(mobArg:getSpawnPos().rot)
        end
    end)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Rojgnoj's Hands are eligible targets for his buffs.
    local allies = {}
    local offset = ID.mob.WARLORD_ROJGNOJ + (battlefield:getArea() - 1) * 14

    for allyId = offset + 1, offset + 2 do
        local allyMob = GetMobByID(allyId)
        if allyMob and allyMob:isSpawned() then
            table.insert(allies, allyMob)
        end
    end

    local spellList =
    {
        [1] = { xi.magic.spell.PROTECT_IV, mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT, 0, 100 },
        [2] = { xi.magic.spell.SHELL_III,  mob,    true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,   0, 100 },
        [3] = { xi.magic.spell.FLASH,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.FLASH,   1, 100 },
        [4] = { xi.magic.spell.BANISH_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,               0,  50 },
    }

    return xi.combat.behavior.chooseAction(mob, target, allies, spellList)
end

return entity
