-----------------------------------
--  Wild Rage
--
--  Description: Deals physical damage to enemies within area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 15' radial
--  Notes: Has additional effect of Poison when used by King Vinegarroon.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)

    -- Platoon Scorpion
    if mob:getPool() == 3157 then
        local ragePower = mob:getLocalVar("wildRagePower")
        info.dmg = info.dmg * (1 + 0.3 * ragePower)
    end

    -- King Vinegrroon
    if mob:getPool() == 2262 then
        local typeEffect = xi.effect.POISON
        local power = 25
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 3, 60)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
