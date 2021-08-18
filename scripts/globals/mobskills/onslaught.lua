-----------------------------------
--  Onslaught
--
--  Description: Lowers target's accuracy. Guttler/Ogre Killer: Temporarily increases Attack.
--  Type: Physical
--  Range: Melee
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 3, 3, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local duration = 60
    local typeEffect = xi.effect.ACCURACY_DOWN
    local power = 30

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    -- About 300-400 to a DD.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg

end

return mobskill_object
