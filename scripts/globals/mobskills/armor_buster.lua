-----------------------------------
-- Armor_Buster
-- Description:
-- Type: Magical
-- additional effect: WEIGHT
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
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
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.WATER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 20, 3, 45)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end
return mobskill_object
