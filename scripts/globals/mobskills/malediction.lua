-----------------------------------
-- Malediction
-- Steals an enemy's HP. Ineffective against undead.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1.5, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_MAGICAL, MOBPARAM_DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg))

    return dmg
end

return mobskill_object
