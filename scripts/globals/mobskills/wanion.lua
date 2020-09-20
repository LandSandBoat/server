---------------------------------------------
-- Wanion
-- Transfers all ailments the Seether itself has to players in AoE range.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    -- list of effects to give in AoE
    local effects = {tpz.effect.POISON, tpz.effect.PARALYSIS, tpz.effect.BLINDNESS, tpz.effect.SILENCE,
        tpz.effect.WEIGHT, tpz.effect.SLOW, tpz.effect.ADDLE, tpz.effect.DIA, tpz.effect.BIO, tpz.effect.BURN,
        tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN, tpz.effect.STR_DOWN,
        tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN,
        tpz.effect.CHR_DOWN, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN, tpz.effect.EVASION_DOWN,
        tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN}

    for i, effect in ipairs(effects) do
        if mob:hasStatusEffect(effect) then
            local currentEffect = mob:getStatusEffect(effect)
            MobStatusEffectMove(mob, target, effect, currentEffect:getPower(), currentEffect:getTick(), currentEffect:getTimeRemaining() / 1000)
            mob:delStatusEffect(effect)
        end
    end
    skill:setMsg(tpz.msg.basic.NONE)
end
