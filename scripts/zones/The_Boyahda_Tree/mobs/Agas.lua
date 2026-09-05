-----------------------------------
-- Area: The Boyahda Tree
-- NM: Agas
-- Involved in Quest: Searching for the Right Words
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 25)
    mob:setMod(xi.mod.REGAIN, 150)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 28)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
        [ 2] = { xi.magic.spell.SLEEPGA,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      1, 100 },
        [ 3] = { xi.magic.spell.BLIND,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BLINDNESS,    0, 100 },
        [ 4] = { xi.magic.spell.CHOKE,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.CHOKE,        0, 100 },
        [ 5] = { xi.magic.spell.BIO_II,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,          4, 100 },
        [ 6] = { xi.magic.spell.POISONGA_II,  target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,       0, 100 },
        [ 7] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,             nil,                    0, 100 },
        [ 8] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,             nil,                    0, 100 },
        [ 9] = { xi.magic.spell.WATER_IV,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [10] = { xi.magic.spell.THUNDER_IV,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [11] = { xi.magic.spell.AERO_IV,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [12] = { xi.magic.spell.BLIZZARD_IV,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [13] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [14] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [15] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.BLINDEYE_1,
        xi.mobSkill.EYES_ON_ME_1,
        xi.mobSkill.HYPNOSIS_1,
        xi.mobSkill.MIND_BREAK_1,
        xi.mobSkill.BINDING_WAVE_1,
        xi.mobSkill.AIRY_SHIELD_1,
        xi.mobSkill.MAGIC_BARRIER_1,
    }

    if mob:getHPP() < 25 then
        table.insert(skillList, xi.mobSkill.LEVEL_5_PETRIFY_1)
    end

    return skillList[math.randomInt(1, #skillList)]
end

return entity
