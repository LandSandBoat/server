-----------------------------------
-- Deep Kiss
-- Steal one effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getPool() == 3132 then -- BCNM20 Charming Trio: Phoedme drains ALL effects except food/reraise
        local count = target:countEffectWithFlag(xi.effectFlag.DISPELABLE)

        if count == 0 then
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
            return count
        end

        for i = 1, count do
            mob:stealStatusEffect(target, xi.effectFlag.DISPELABLE) -- Steal all status effects valid on the player
        end

        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)

        return count
    end

    skill:setMsg(xi.mobskills.mobDrainStatusEffectMove(mob, target))

    return 1
end

return mobskillObject
