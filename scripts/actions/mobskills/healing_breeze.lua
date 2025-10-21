-----------------------------------
-- Healing Breeze
-- Description: Restores HP for party members within area of effect.
-- Type: Magical (Wind)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power       = mob:getMaxHP()
    local skillTP     = utils.clamp(skill:getTP() - 1000, 0, 2000)
    local skillFactor = 172 / 1024
    local tpFactor    = 1 + 0.25 * skillTP / 1000

    power = math.floor(power * skillFactor)
    power = math.floor(power * tpFactor)

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(target, power)
end

return mobskillObject
