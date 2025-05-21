-----------------------------------
-- Bloody Claw
-- Family: Gargouille
-- Description: Steals an enemy's HP. Additional effect: Reduces a random stat.
-- Type: Physical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: Despite the attack ignoring Utsusemi, it is physical, and therefore capable of missing entirely.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 4 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 0.9
    local typeEffect = 136 + math.random(0, 6) -- 136 is xi.effect.STR_DOWN add 0 to 6 for all 7 of the possible attribute reductions

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 3, 120)

    return dmg
end

return mobskillObject
