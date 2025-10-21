-----------------------------------
--  Sinker Drill
--  Family: Acrolith
--  Type: Physical
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: Up to 5 shadows
--  Range: Single Target TODO Capture
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('lost_body') == 1 then
        -- Lost body, filtering out Sinker Drill!
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 5
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
