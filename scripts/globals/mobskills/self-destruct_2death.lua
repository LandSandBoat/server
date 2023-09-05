-----------------------------------
-- Self-Destruct
-- Bomb Cluster Self Destruct - 2 Bombs up
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if (mob:getHPP() > 32 or mob:getAnimationSub() ~= 5) and math.random() < .2 then -- 20% chance for all bombs to explode
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = skill:getMobHP() / 6
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1, 1.1, 1.2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskillObject
