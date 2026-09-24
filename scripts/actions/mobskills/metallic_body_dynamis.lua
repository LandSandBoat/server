-----------------------------------
-- Metalic Body
--
-- Gives the effect of "Stoneskin."
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local result = xi.mobskills.mobBuffMove(target, xi.effect.STONESKIN, 700, 0, 300)
    local effect = target:getStatusEffect(xi.effect.STONESKIN)
    if effect then
        effect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    skill:setMsg(result)

    return xi.effect.STONESKIN
end

return mobskillObject
