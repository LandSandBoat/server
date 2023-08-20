-----------------------------------
-- Pyric Bulwark
-- Description: Grants a Physical Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1796 then
            return 0
        else
            return 1
        end
    end

    -- TODO: Used only when second/left head is alive (animationsub 0 or 1)
    if mob:getAnimationSub() <= 1 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- addEx to pervent dispel
    mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 45)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    if mob:getFamily() == 313 then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1580)
    end

    return xi.effect.PHYSICAL_SHIELD
end

return mobskillObject
