-----------------------------------
-- Pollen
-- Description: Restores HP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local potencyBonus = mob:isNM() and math.random(0, 294) or 0
    local potency      = (147 + potencyBonus) / 1024
    local finalPotency = math.floor(mob:getMaxHP() * potency)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, finalPotency)
end

return mobskillObject
