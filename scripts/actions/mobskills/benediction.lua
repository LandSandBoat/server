-----------------------------------
-- Benediction
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- if target:getAllegiance() ~= mob:getAllegiance() then
    --     return 0
    -- end
    printf(
    "[DEBUG][Benediction] mob=%s target=%s target_is_nil=%s",
    mob:getName(),
    target and target:getName() or "nil",
    target == nil and "true" or "false"
    )

    target:eraseAllStatusEffect()

    local maxHeal = target:getMaxHP() - target:getHP()

    target:addHP(maxHeal)
    target:wakeUp()

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return maxHeal
end

return mobskillObject
