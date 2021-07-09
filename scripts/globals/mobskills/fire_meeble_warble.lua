-----------------------------------
-- Fire Meeble Warble
-- AOE Fire Elemental damage, inflicts Plague (50 MP/tick, 300 TP/tick) and Burn (50 HP/tick).
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WIND, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    MobStatusEffectMove(mob, target, xi.effect.PLAGUE, 30, 3, 60)
    MobStatusEffectMove(mob, target, xi.effect.BURN, 50, 3, 60)
    return dmg
end

return mobskill_object
