-----------------------------------
-- Amplification
-- Enhances Magic Attack and Magic Defense. Bonus stacks when used by mobs.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect1 = xi.effect.MAGIC_ATK_BOOST
    local typeEffect2 = xi.effect.MAGIC_DEF_BOOST
    local mabTotal = mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    local mdbTotal = mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST)

    if (mob:getStatusEffect(xi.effect.MAGIC_ATK_BOOST) ~= nil) then -- mag atk bonus stacking
        mabTotal = mabTotal:getPower() + 10
    else
        mabTotal = 10
    end
    if (mob:getStatusEffect(xi.effect.MAGIC_DEF_BOOST) ~= nil) then -- mag def bonus stacking
        mdbTotal = mdbTotal:getPower() + 10
    else
        mdbTotal = 10
    end
    -- print(mabTotal)
    -- print(mdbTotal)

    skill:setMsg(MobBuffMove(mob, typeEffect1, mabTotal, 0, 180))
    MobBuffMove(mob, typeEffect2, mdbTotal, 0, 180)

    return typeEffect1
end

return mobskill_object
