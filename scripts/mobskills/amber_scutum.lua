-----------------------------------
-- Amber Scutum
-- Family: Wamouracampa
-- Description: Increases defense.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local status = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
    local power  = 100

    if status ~= nil then
        -- This is as accurate as we get until effects applied by mob moves can use subpower..
        power = status:getPower() * 2
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, power, 0, 60))

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
