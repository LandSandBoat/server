-----------------------------------
--  Flying Hip Press
--
--  Description: Deals Wind damage to enemies within area of effect.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 15' radial
--  Notes:
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local newtonID = require("scripts/zones/Newton_Movalpolos/IDs")
-----------------------------------

local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local bonus = 300

     -- Bugbear Matman has stronger Flying Hip Press
    if mob:getID() == newtonID.mob.BUGBEAR_MATMAN then
        bonus = 700
    end

    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.333, 1, xi.magic.ele.WIND, bonus)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WIND)
    return dmg
end

return mobskill_object
