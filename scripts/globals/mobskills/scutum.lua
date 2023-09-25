-----------------------------------
-- Scutum
-- Enhances defense.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 70
    if skill:getID() == 1860 then -- Nightmare Bugard - 2x DEFENSE_BOOST
        power = 100
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 180))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
