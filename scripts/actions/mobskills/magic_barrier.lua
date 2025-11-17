-----------------------------------
-- Magic Barrier
-- Description: Magic shield
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
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_SHIELD, 1, 0, 60))

    local effect1 = mob:getStatusEffect(xi.effect.MAGIC_SHIELD)
    if effect1 then
        effect1:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    -- Removes Airy Shield effect if used
    mob:delStatusEffect(xi.effect.ARROW_SHIELD)

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
