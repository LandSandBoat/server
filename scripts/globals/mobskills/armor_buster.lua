-----------------------------------
-- Armor_Buster
-- Description:
-- Type: Magical
-- additional effect: WEIGHT
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")

    if (phase >= 3) then -- only proto-ultima has the var at a value other than 0. Note that the phase values range from 0-4 for the five phases.
        if mob:getLocalVar("nuclearWaste") == 0 and mob:getLocalVar("citadelBuster") == 0 then
            return 0
        end
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.WEIGHT
    local dmgmod = 2.5
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 3, 45)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end
return mobskill_object
