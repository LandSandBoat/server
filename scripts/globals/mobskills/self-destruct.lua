-----------------------------------
-- Self-Destruct
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) or mob:getHPP() > 75 then
        return 1
    end

    mob:setLocalVar("HPSelfDestruct", mob:getHP())
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local bombHPP = mob:getLocalVar("HPSelfDestruct") / 3

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, bombHPP, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
