---------------------------------------------
--  Vorpal Wheel
--
--  Description: Throws a slicing wheel at a single target.
--  Type: Physical
--  Utsusemi/Blink absorb: No
--  Range: Unknown
--  Notes: Only used by Gulool Ja Ja, and will use it as a counterattack to any spells cast on him. Damage increases as his health drops. Can be Shield Blocked.
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    -- Increase damage as health drops
    local dmgmod = (1 - (mob:getHP() / mob:getMaxHP())) * 6
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)
    return dmg
end
