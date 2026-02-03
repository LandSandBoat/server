-----------------------------------
-- Immortal Shield
-- Description: Grants a 1000 damage stoneskin effect, stacking up to 2 times.
-- Type: Enhancing
-- Range: Self
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- TODO: Rework to utilize a magical damage only stoneskin effect
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local currentStacks = mob:getLocalVar('immortalShieldStacks')
    local stoneskinEffect = mob:getStatusEffect(xi.effect.STONESKIN)
    local newPower = 1000

    if stoneskinEffect then
        -- Calculate new total power and remove old effect
        newPower = stoneskinEffect:getPower() + 1000
        mob:delStatusEffectSilent(xi.effect.STONESKIN)
    end

    -- Create stoneskin with combined power
    mob:addStatusEffect(xi.effect.STONESKIN, newPower, 0, 600)
    stoneskinEffect = mob:getStatusEffect(xi.effect.STONESKIN)

    -- Make stoneskin undispellable
    if stoneskinEffect then
        stoneskinEffect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    mob:setLocalVar('immortalShieldStacks', currentStacks + 1)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)

    return xi.effect.STONESKIN
end

mobskillObject.onMobSkillFinalize = function(mob, skill)
    -- Soulflayers change animation sub to indicate currently active shield stacks
    -- 0 = no shield, 1 = one stack, 2 = two stacks
    local stacks = mob:getLocalVar('immortalShieldStacks')
    mob:setAnimationSub(stacks)
end

return mobskillObject
