-----------------------------------
-- Self-Destruct
--
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS) or mob:getHPP() > 75) then
        return 1
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
        BOMB_TOSS_HPP = skill:getMobHPP() / 100

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*18*BOMB_TOSS_HPP, xi.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg
end

return mobskill_object
