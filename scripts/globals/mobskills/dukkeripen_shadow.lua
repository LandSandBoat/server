-----------------------------------
-- Dukkeripen
-- adds 10 shadows
-- Type: Magical
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getMainJob() == xi.job.COR then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BLINK, 10, 0, 120))

    return xi.effect.BLINK
end

return mobskillObject
