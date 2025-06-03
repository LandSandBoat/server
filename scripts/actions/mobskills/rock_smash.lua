-----------------------------------
--  Rock Smash
--  Description: Damages a single target. Additional effect: Petrification
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1680 then
            return 0
        else
            return 1
        end
    end

    -- Do not use if still holding a weapon
    if mob:getAnimationSub() == 0 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local ftp    = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    local power = math.random(25, 40) + mob:getMainLvl() / 3

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PETRIFICATION, 1, 0, power)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
