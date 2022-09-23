-----------------------------------
-- Entangle
--
-- Description: Attempts to bind a single target with vines.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Melee
-- Notes: When used by the Cemetery Cherry and Jidra: it also deals damage, inflicts Poison, and resets hate.
--        When used by Cernunnos: deals damage, also drains HP equal to the damage inflicted.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if mob:getName() == "Cernunnos" then
        local numhits = 3
        local accmod = 1
        local dmgmod = 2.0
        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
        local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

        xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, dmg)

        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill,  xi.effect.BIND, 1, 0, 30)

        return dmg
    else
        local typeEffect = xi.effect.BIND
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 30))
        return typeEffect
    end
end

return mobskill_object
