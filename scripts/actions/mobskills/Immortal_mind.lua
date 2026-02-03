-----------------------------------
-- Immortal Mind
-- Description: Gains Magic Attack Bonus and Magic Defense Bonus.
-- Type: Self
-- Range: AoE 10'
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, 50, 0, 120))
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, 100, 0, 120)

    local mabEffect = mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    if mabEffect then
        mabEffect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    local mdbEffect = mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST)
    if mdbEffect then
        mdbEffect:delEffectFlag(xi.effectFlag.DISPELABLE)
    end

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
