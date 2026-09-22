-----------------------------------
-- Scissor Guard
-- Grants a massive protect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:hasStatusEffect(xi.effect.PROTECT) then
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
        return xi.effect.NONE
    else
        local result = xi.mobskills.mobBuffMove(target, xi.effect.PROTECT, 2000, 0, 30) -- The actual amount of defense needs to be capped.
        local effect = target:getStatusEffect(xi.effect.PROTECT)
        if effect then
            effect:delEffectFlag(xi.effectFlag.DISPELABLE)
        end

        skill:setMsg(result)

        return xi.effect.PROTECT
    end
end

return mobskillObject
