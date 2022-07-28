-----------------------------------
-- Mix: Max Potion - Restores 700 HP.
-- Note the subtle name difference from 'Max Potion'.
-- This feels like a localization error otherwise.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(target, 700)
end

return mobskill_object
