-----------------------------------
-- Pollen
--
-- Description: Restores HP.
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potency = 12

    if mob:getPool() == 385 then
        potency = 25
        potency = potency - math.random(0, 5)
    end

    potency = potency - math.random(0, potency / 4)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    if mob:getPool() == 979 then -- Demonic Tiphia pollen recovers 3k+ HP
        return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 30)
    elseif mob:getPool() == 385 then
        return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency / 100)
    else
        return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * (147 / 1024))
    end
end

return mobskillObject
