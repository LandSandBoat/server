---------------------------------------------
--  Coronach
--
--  Description: Annihilator/Ferninand: Temporarily lowers enmity.
--  Type: Physical
--  Shadow per hit
--  Range: Melee
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 3, 3, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.RANGED, tpz.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, tpz.attackType.RANGED, tpz.damageType.PIERCING)
    return dmg

end

return mobskill_object
