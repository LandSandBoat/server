-----------------------------------
-- Immortal Mind
-- Description: Gains Magic Attack Bonus and Magic Defense Bonus.
-- Type: Self
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mabTotal = 10
    local mdbTotal = 10

    local mabEffect = mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    if mabEffect then
        mabTotal = mabEffect:getPower() + 10
    end

    local mdbEffect = mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST)
    if mdbEffect then
        mdbTotal = mdbEffect:getPower() + 10
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, mabTotal, 0, 180))
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, mdbTotal, 0, 180)

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
