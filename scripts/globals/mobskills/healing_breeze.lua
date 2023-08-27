-----------------------------------
-- Healing Breeze
--
-- Description: Restores HP for party members within area of effect.
-- Type: Magical (Wind)
--
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Healing value is max hp * 172 / 1024
    local potency = 172 / 1024

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, target:getMaxHP() * potency)
end

return mobskillObject
