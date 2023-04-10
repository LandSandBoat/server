-----------------------------------
--  Flame Blast Regular Attack
--
--  Description: Deals single target fire damage to target.
--  Type: Magical
--  Utsusemi/Blink absorb: N/A
--  Range: 18'
--  Notes: Used only by KS99 Wyrm in while flying as regular attack. Only use in a dedicated flying attack skill set.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.FIRE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    skill:setMsg(xi.msg.basic.HIT_DMG)
    return dmg
end

return mobskillObject
