---------------------------------------------------
-- Abyssal Drain
-- Deals dark damage to a single target. Additional effect: Drain
-- Type: Magical
-- Utsusemi/Blink absorb: 1 shadow
-- Range: Melee
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)



    return dmg
end

return mobskill_object
