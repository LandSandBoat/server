-----------------------------------
--  Triclip
--  Description: Deals damage in a threefold attack. Additional effect: DEX Down
--  Type: Physical
--  Utsusemi/Blink absorb: 3 shadows
--  Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 0.8
    local ftp    = 0.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    -- Power is 10 at 1000 TP, 20 at 3000 TP
    local power = 5 + math.floor(skill:getTP() / 200)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEX_DOWN, power, 3, 90)

    return dmg
end

return mobskillObject
