-----------------------------------
-- Amplification
-- Enhances Magic Attack and Magic Defense. Bonus stacks when used by mobs.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local mabTotal = mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    local mdbTotal = mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST)

    if mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST) ~= nil then -- mag atk bonus stacking
        mabTotal = mabTotal:getPower() + 10
    else
        mabTotal = 10
    end

    if mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST) ~= nil then -- mag def bonus stacking
        mdbTotal = mdbTotal:getPower() + 10
    else
        mdbTotal = 10
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_ATK_BOOST, mabTotal, 0, 180))
    xi.mobskills.mobBuffMove(mob, xi.effect.MAGIC_DEF_BOOST, mdbTotal, 0, 180)

    return xi.effect.MAGIC_ATK_BOOST
end

return mobskillObject
