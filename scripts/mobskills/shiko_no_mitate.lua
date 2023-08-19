-----------------------------------
-- Shiko no Mitate
-- Enhances defense.
-- Trust: Gessho: Shiko no Mitate : Defense Boost + Stoneskin + Issekigan
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DEFENSE_BOOST
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 15, 0, 300))

    -- Extra stuff for Trust: Gessho
    if mob:getObjType() == xi.objType.TRUST then
        mob:addStatusEffect(xi.effect.ISSEKIGAN, 25, 0, 300)
        mob:addStatusEffect(xi.effect.STONESKIN, 300, 0, 300)
    end

    return typeEffect
end

return mobskillObject
