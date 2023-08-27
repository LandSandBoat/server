---------------------------------------------
-- Noctoshield
--
-- Description: Gives the effect of "Phalanx."
-- Type: Magical
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.PHALANX) then
        return 1
    end
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.PHALANX, 13, 0, 120))
    return xi.effect.PHALANX
end

return mobskillObject
