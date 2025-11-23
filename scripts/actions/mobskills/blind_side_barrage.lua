-----------------------------------
-- Blindside Barrage
-- Description: Deals physical damage to a single target. Additional Effect: MND,INT Down - Can critically strike.
-- Notorious Monster/Nightmare version deals damage in a 10 yalm area of effect around target.
-- Type: Physical (Blunt)
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2.0
    local power   = 3 + math.floor(mob:getMainLvl() / 5)
    local params  = { canCrit = true }
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0, params)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MND_DOWN, power, 0, 120) -- Does not decay
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.INT_DOWN, power, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
