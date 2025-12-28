-----------------------------------
-- Vampiric Root
-- Steals HP from a single target and absorbs positive status effects.
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-- Notes: (Unverified) If used against undead, it will simply do damage and not drain HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- will only use vampiric root if there are buffs to steal
    return target:countEffectWithFlag(xi.effectFlag.DISPELABLE) > 0 and 0 or 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, damage))

    -- Absorb ALL positive status effects
    -- Note: Some sources claim this includes food and reraise which has been proven to be false
    local result = mob:stealStatusEffect(target)
    while result ~= 0 do
        result = mob:stealStatusEffect(target)
    end

    return damage
end

return mobskillObject
