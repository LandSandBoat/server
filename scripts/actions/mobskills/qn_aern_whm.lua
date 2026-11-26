-----------------------------------
-- Benediction
-- Meant for Qn'aern (WHM) with Ix'Aern encounter
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getPool() == xi.mobPool.QNAERN_WHM and mob:getHPP() <= 50 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local maxHeal = target:getMaxHP() - target:getHP()
    target:eraseAllStatusEffect()
    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.USES_SKILL_RECOVERS_HP_AREA_OF_EFFECT)

    return maxHeal
end

return mobskillObject
