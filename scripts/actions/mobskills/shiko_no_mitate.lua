-----------------------------------
-- Shiko no Mitate
-- Enhances defense.
-- Trust: Gessho: Shiko no Mitate : Defense Boost + Stoneskin + Issekigan
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 15, 0, 300))

    -- Extra stuff for Trust: Gessho
    if mob:getObjType() == xi.objType.TRUST then
        mob:addStatusEffect(xi.effect.ISSEKIGAN, { power = 25, duration = 300, origin = mob })
        mob:addStatusEffect(xi.effect.STONESKIN, { power = 300, duration = 300, origin = mob })
    end

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
