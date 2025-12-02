-----------------------------------
-- Harden Shell
-- Description: Enhances defense.
-- Type: Magical (Earth)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:hasStatusEffect(xi.effect.DEFENSE_BOOST) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = math.random(60, 180)
    local power = 33
    if mob:isNM() then
        power = 80
    end

    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.DEFENSE_BOOST, power, 0, duration))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
