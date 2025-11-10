-----------------------------------
-- Airy Shield
--
-- Description: Ranged shield
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ARROW_SHIELD, 1, 0, 60))

    local effect1 = mob:getStatusEffect(xi.effect.ARROW_SHIELD)
    if effect1 then
        effect1:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    -- Removes Magic Barrier effect if used
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)

    return xi.effect.ARROW_SHIELD
end

return mobskillObject
