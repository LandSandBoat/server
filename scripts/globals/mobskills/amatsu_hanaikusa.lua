-----------------------------------
--  Amatsu: Hanaikusa
--  Type: Physical
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if mob:getObjType() == xi.objType.TRUST then
        return 0
    elseif mob:AnimationSub() == 0 then -- if tenzen is in melee stance (BCNM Version)
        return 0
    else
        return 1
    end
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PARALYSIS
    local power = 22.5
    local duration = 60
    local numhits = 1
    local accmod = 2
    local dmgmod = 6
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    if info.hitslanded > 0 then
        target:addStatusEffect(typeEffect, power, 0, duration)
    end
    return dmg
end

return mobskill_object
