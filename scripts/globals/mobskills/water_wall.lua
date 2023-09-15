-----------------------------------
-- Water Wall
-- Enhances defense.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 100
    if skill:getID() == 1868 then -- Nightmare Makara - Triples DEFENSE_BOOST
        power = 300
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, math.random(60, 180)))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
