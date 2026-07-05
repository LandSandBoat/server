-----------------------------------
-- Area: Cloister of Tremors
--  Mob: Galgalim
-- Involved in Quest: The Puppet Master
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.STORETP, 200)  -- Galgalim has 4 hit to 1k tp
end

entity.onMobEngage = function(mob)
    mob:setMagicCastingEnabled(true) -- Galgalim will not idle buff and will only start casting spells after engaging
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.DEATH_RAY,
        xi.mobSkill.HEX_EYE,
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.AEROGA,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0,  50 },
        [ 2] = { xi.magic.spell.FIRAGA,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0,  50 },
        [ 3] = { xi.magic.spell.BLIZZAGA,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0,  50 },
        [ 4] = { xi.magic.spell.THUNDAGA,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0,  50 },
        [ 5] = { xi.magic.spell.STONEGA_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 6] = { xi.magic.spell.WATERGA_II,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [ 7] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                    0,  50 },
        [ 8] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                    0,  50 },
        [ 9] = { xi.magic.spell.BIND,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIND,         0,  50 },
        [10] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,    0,  50 },
        [11] = { xi.magic.spell.DROWN,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,        0,  50 },
        [12] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BURN,         0,  50 },
        [13] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,        0,  50 },
        [14] = { xi.magic.spell.SLEEP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1,  50 },
        [15] = { xi.magic.spell.SLEEP_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_II,     2,  50 },
        [16] = { xi.magic.spell.STUN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.STUN,         0,  50 },
        [17] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0,  50 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
