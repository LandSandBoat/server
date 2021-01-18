-----------------------------------
--  Amatsu: Hanaikusa
--  Type: Physical
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
    local typeEffect = tpz.effect.PARALYSIS
    local power = 22.5
    local duration = 60
    local numhits = 1
    local accmod = 2
    local dmgmod = 6
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    if info.hitslanded > 0 then
        target:addStatusEffect(typeEffect, power, 0, duration)
    end
    return dmg
end

return mobskill_object
