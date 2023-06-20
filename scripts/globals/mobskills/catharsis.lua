-----------------------------------
-- Catharsis
-- Description: Restores HP.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:getCurrentRegion() == xi.region.TAVNAZIANARCH then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = skill:getParam()

    if potency == 0 then
        potency = 12
    end

    potency = potency - math.random(0, potency / 4)
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
end

return mobskillObject
