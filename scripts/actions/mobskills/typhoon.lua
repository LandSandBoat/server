-----------------------------------
--  Typhoon
--  Description: Spins around dealing damage to targets in an area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-4 shadows
--  Range: 10' radial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 4
    local accmod = 1
    local ftp    = 0.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    if mob:getName() == 'Faust' then
        if mob:getLocalVar('Typhoon') == 0 then
            mob:useMobAbility(539)
            mob:setLocalVar('Typhoon', 1)
        else
            mob:setLocalVar('Typhoon', 0)
        end
    end

    return dmg
end

return mobskillObject
