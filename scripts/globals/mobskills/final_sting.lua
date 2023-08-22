-----------------------------------
--  Final Sting
--
--  Description: Deals damage proportional to HP. Reduces HP to 1 after use. Damage varies with TP.
--  Type: Physical (Slashing)
--
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local param = skill:getParam()
    if param == 0 then
        param = 33
    end

    if mob:getHPP() <= param then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getHP() * 0.5

    mob:setHP(0)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    return dmg
end

return mobskillObject
