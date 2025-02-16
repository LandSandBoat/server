-----------------------------------
--  Drop Hammer
--
--  Description: Drops the hammer. Additional effect: Bind
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows?
--  Range: Melee
--  Notes: Only used by "destroyers" (carrying massive warhammers).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2.4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(2, 3))

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    if mob:getPool() == 6750 then  -- Fahrafahr the Bloodied
        mob:resetEnmity(target)
    end

    return dmg
end

return mobskillObject
