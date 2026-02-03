-----------------------------------
-- Area: Den of Rancor
--  Mob: Hakutaku
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 35)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 11)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 50)
    mob:setMod(xi.mod.STORETP, 80)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 30)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.DEATH_RAY,
        xi.mobSkill.HEX_EYE,
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.FIRE_IV,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [2] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [3] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [4] = { xi.magic.spell.BURN,         target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [5] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
        [6] = { xi.magic.spell.ENFIRE,       mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ENFIRE,       0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
