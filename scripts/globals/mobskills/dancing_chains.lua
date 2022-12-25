-----------------------------------
--  Dancing Chains
--  Description:  Applies AoE drown 15hp/sec
--  Notes: Ignores shadows, 10' AoE radius
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
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DROWN, 15, 3, 60))

    return xi.effect.DROWN
end

return mobskillObject
