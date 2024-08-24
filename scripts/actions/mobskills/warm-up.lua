-----------------------------------
-- Warm-Up
-- Description: Enhances accuracy and evasion.
-- Type: Magical (Earth)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 40
    local effectID

    if mob:hasStatusEffect(xi.effect.ACCURACY_BOOST) then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ACCURACY_BOOST, power, 0, 60))
        effectID = xi.effect.ACCURACY_BOOST
    end

    if mob:hasStatusEffect(xi.effect.EVASION_BOOST) then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, power, 0, 60))
        effectID = xi.effect.EVASION_BOOST
    end

    return effectID
end

return mobskillObject
