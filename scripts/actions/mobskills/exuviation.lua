-----------------------------------
-- Exuviation
-- Family: Wamoura
-- Type: Healing and Full Erase
-- Range: Self
-- Notes: Erases all negative effects on the mob and heals an amount for each removed.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local function getRandomHealingPercentage()
        return math.random(200, 400) / 100 -- Simplified random range calculation
    end

    local maxHP = mob:getMaxHP()
    local removables = {
        xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.ELEGY, xi.effect.REQUIEM, xi.effect.PARALYSIS, xi.effect.POISON,
        xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND, xi.effect.BIO, xi.effect.DIA, xi.effect.BURN,
        xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN, xi.effect.STR_DOWN, xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN, xi.effect.CHR_DOWN, xi.effect.ADDLE,
        xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN, xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN,
        xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN, xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN,
        xi.effect.MAX_MP_DOWN, xi.effect.MAX_HP_DOWN, xi.effect.SILENCE
    }

    local numEffectsRemoved = 0

    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
            numEffectsRemoved = numEffectsRemoved + 1
        end
    end

    local healingAmount = numEffectsRemoved * (maxHP * getRandomHealingPercentage() / 100)

    if healingAmount > maxHP then
        healingAmount = maxHP
    end

    if numEffectsRemoved > 0 then
        skill:setMsg(xi.msg.basic.SELF_HEAL)
        return healingAmount
    else
        skill:setMsg(xi.msg.basic.NO_EFFECT)
        return 0
    end
end

return mobskillObject
