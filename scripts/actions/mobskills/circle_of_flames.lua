-----------------------------------
--  Circle of Flames
--
--  Description: Deals damage to targets in an area of effect. Additional effect: Weight
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes
--  Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Determine number of bombs exploded based on animation sub
    -- 3/4 or 11/12 = 3 bombs remaining (0 exploded)
    -- 5 or 13 = 2 bombs remaining (1 exploded)
    local animation     = mob:getAnimationSub()
    local bombsExploded = 0
    if animation == 5 or animation == 13 then
        bombsExploded = 1
    elseif animation == 6 or animation == 14 then
        bombsExploded = 2
    end

    local damage = (mob:getMainLvl() + 2) + (25 * bombsExploded)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 0.5, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 20, 0, 120)

    return damage
end

return mobskillObject
