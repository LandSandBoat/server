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
    local potency           = mob:getMaxHP()
    local powerMultiplier   = 147 / 1024
    local healingMultiplier = 1 + target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100
    local randomMultiplier  = math.random(75, 100) / 100

    potency = math.floor(potency * powerMultiplier)
    potency = math.floor(potency * healingMultiplier)
    potency = math.floor(potency * randomMultiplier)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, potency)
end

return mobskillObject
