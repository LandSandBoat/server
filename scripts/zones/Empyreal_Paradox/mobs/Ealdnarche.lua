-----------------------------------
-- Area: Emperial Paradox
--  Mob: Eald'narche
-- Apocalypse Nigh Final Fight
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.BIND_RES_RANK, 11)
    mob:setMod(xi.mod.BLIND_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 11)
    mob:setMod(xi.mod.POISON_RES_RANK, 11)
    mob:setMod(xi.mod.SLOW_RES_RANK, 11)
    mob:setMobMod(xi.mobMod.TELEPORT_CD, 30)
    mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
    mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
    mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.EVA, 330)
    mob:setMod(xi.mod.MATT, 150)
    mob:setMod(xi.mod.MDEF, 50)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local spellList =
    {
        xi.mobSkill.OMEGA_JAVELIN_1,
        xi.mobSkill.STELLAR_BURST_1,
        xi.mobSkill.VORTEX_1,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobSpellChoose = function(mob, target)
    local spellList =
    {
        [1] = { xi.magic.spell.THUNDAGA_III, target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
        [2] = { xi.magic.spell.BLIZZAGA_III, target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
        [3] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
        [4] = { xi.magic.spell.AEROGA_III,   target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
        [5] = { xi.magic.spell.WATERGA_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
        [6] = { xi.magic.spell.STONEGA_III,  target, false, xi.action.type.DAMAGE_TARGET,      nil,                0, 100 },
        [7] = { xi.magic.spell.SLEEPGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLEEP_II, 0, 100 },
        [8] = { xi.magic.spell.BINDGA,       target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.BIND,     0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
