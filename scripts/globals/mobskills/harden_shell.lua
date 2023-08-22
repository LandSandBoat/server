-----------------------------------
-- Harden Shell
--
-- Description: Enhances defense.
-- Type: Magical (Earth)
--
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 33

    if mob:isNM() then
        power = 80
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
