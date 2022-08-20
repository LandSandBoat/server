-----------------------------------
-- Frostbite
-- Great Sword weapon skill
-- Delivers an ice elemental attack. Damage varies with TP.
-----------------------------------
local mobskill_object = {}

require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
require("scripts/globals/mobskills")
-----------------------------------
mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    return dmg
end

return mobskill_object
