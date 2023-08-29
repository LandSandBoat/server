-----------------------------------
-- Regeneration
--
-- Description: Adds a Regen xi.effect.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.min(1, math.floor(((mob:getMainLvl() - 3) / 2)))
    local duration = 60

    if
        mob:getFamily() == 218 or
        mob:getFamily() == 219
    then
        power = math.min(1, math.floor(((mob:getMainLvl() - 1) / 2) / 2))
        duration = 300
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.REGEN, power, 3, duration))
    return xi.effect.REGEN
end

return mobskillObject
