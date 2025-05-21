-----------------------------------
--  Bilgestorm
--
--  Description: Deals damage in an area of effect. Additional effect: Lowers attack, accuracy, and defense
--  Type: Physical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Unknown
--  Notes: Only used at low health.*Experienced the use at 75%*
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.random(20, 25)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ACCURACY_DOWN, power, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.ATTACK_DOWN, power, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, power, 0, 60)

    local numhits = 1
    local accmod = 1
    local ftp    = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
