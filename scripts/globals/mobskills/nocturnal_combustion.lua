-----------------------------------
--  Nocturnal Combustion
--
--  Description: Self-destructs, releasing dark energy at nearby targets.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 20'  radial
--  Notes: Damage is based on remaining HP and time of day (more damaging near midnight). The djinn will not use this until it has been affected by the current day's element.
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
    local dmgmod = 1
    local BOMB_TOSS_HPP = skill:getMobHPP() / 100

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*20*BOMB_TOSS_HPP, xi.magic.ele.DARK, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskill_object
