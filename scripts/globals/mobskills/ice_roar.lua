-----------------------------------
-- Ice Roar
-- Emits the roar of an impact event, dealing damage in a fan-shaped area of effect. Ice damage
-- Ignores Shadows
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)

    if (mob:getZoneID() == 135 or mob:getZoneID() == 111) then
        return 0
    end

    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.ICE, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    return dmg
end

return mobskill_object
