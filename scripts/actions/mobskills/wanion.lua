-----------------------------------
-- Wanion
-- Transfers all ailments the Seether itself has to players in AoE range.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- list of effects to give in AoE
    local effects = { xi.effect.POISON, xi.effect.PARALYSIS, xi.effect.BLINDNESS, xi.effect.SILENCE,
        xi.effect.WEIGHT, xi.effect.SLOW, xi.effect.ADDLE, xi.effect.DIA, xi.effect.BIO, xi.effect.BURN,
        xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN, xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN, xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN }

    for i, effect in ipairs(effects) do
        if mob:hasStatusEffect(effect) then
            local currentEffect = mob:getStatusEffect(effect)
            xi.mobskills.mobStatusEffectMove(mob, target, effect, currentEffect:getPower(), currentEffect:getTick(), currentEffect:getTimeRemaining() / 1000)
            mob:delStatusEffect(effect)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
end

return mobskillObject
