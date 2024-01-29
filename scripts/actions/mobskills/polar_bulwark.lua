-----------------------------------
-- Polar Bulwark
-- Description: Grants a Magic Shield effect for a time.
-- Type: Enhancing
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- addEx to pervent dispel
    mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 45)
    skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    if mob:getFamily() == 313 then -- Tinnin follows this up immediately with Nerve Gas
        mob:useMobAbility(1580)
    end

    return xi.effect.MAGIC_SHIELD
end

return mobskillObject
