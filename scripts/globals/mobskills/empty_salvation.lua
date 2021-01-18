---------------------------------------------
-- Empty Salvation
-- Damages all targets in range with the salvation of emptiness. Additional effect: Dispels 3 effects
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    target:dispelStatusEffect(tpz.effectFlag.DISPELABLE)
    target:dispelStatusEffect(tpz.effectFlag.DISPELABLE)
    target:dispelStatusEffect(tpz.effectFlag.DISPELABLE)

    local dmgmod = 1
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_3_SHADOW)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return dmg
end

return mobskill_object
