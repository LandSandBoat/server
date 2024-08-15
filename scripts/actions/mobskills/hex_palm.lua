-----------------------------------
-- Hex Palm
-- Family: Qutrub
-- Description: Steals HP from targets in front.
-- Type: Magical
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: Front cone
-- Notes: Used only when wielding no weapon.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 1 or mob:getAnimationSub() == 3 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() * 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, damage))

    return damage
end

return mobskillObject
