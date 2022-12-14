-----------------------------------
-- Petribreath
--
-- Description: Petrifies targets within a fan-shaped area.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown  cone, Seen up to 15' distance.
-- Notes:
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 60))

    return xi.effect.PETRIFICATION
end

return mobskillObject
