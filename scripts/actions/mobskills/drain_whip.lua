-----------------------------------
-- Drain Whip
-- Description: Drains HP, MP, or TP from the target.
-- Type: Magical
-- Utsusemi/Blink absorb: ignores shadows
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage     = mob:getWeaponDmg() * 3
    local drainTable = { xi.mobskills.drainType.HP, xi.mobskills.drainType.MP, xi.mobskills.drainType.TP }

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobPhysicalDrainMove(mob, target, skill, drainTable[math.random(1, 3)], damage))

    return damage
end

return mobskillObject
