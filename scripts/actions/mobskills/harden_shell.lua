-----------------------------------
-- Harden Shell
-- Description: Enhances defense.
-- Type: Magical (Earth)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = math.random(60, 180)

    if mob:isNM() then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 80, 0, duration))
    else
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 33, 0, duration))
    end

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
