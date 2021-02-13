-----------------------------------
-- Spinning Dive
-- Leviathan delivers a single-hit attack on target.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    numhits = 1
    accmod = 2
    dmgmod = 2
    info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, 1, 2, 3)
    dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg

end

return mobskill_object
