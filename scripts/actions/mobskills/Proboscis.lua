-----------------------------------
-- Proboscis
-- Description: Drains MP and steals 1 Buff
-- Type: Magical (Element)
-- Range: Conal
-- Utsusemi/Blink absorb: 1 shadow
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.8
    local damage = mob:getWeaponDmg()

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage * dmgmod, xi.element.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    mob:addMP(damage)

    xi.mobskills.mobDrainStatusEffectMove(mob, target)

    skill:setMsg(xi.mobskills.mobMagicDrainMove(mob, target, skill, xi.mobskills.drainType.MP, damage))

    return damage
end

return mobskillObject
