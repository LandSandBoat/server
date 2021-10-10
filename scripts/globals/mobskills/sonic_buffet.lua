-----------------------------------
-- Sonic Buffet
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target,mob,skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()  *2.5, xi.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, MOBPARAM_IGNORE_SHADOWS)

    for i = 1, math.random(2,3) do
        target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    end

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return dmg
end

return mobskill_object
