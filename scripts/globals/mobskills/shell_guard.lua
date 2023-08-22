-----------------------------------
-- Shell Guard
-- Increases defense of user.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local defBoost = 25
    if mob:isInDynamis() then
        defBoost = 50
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, defBoost, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
