-----------------------------------
-- Quake Stomp
-- Description: Stomps the ground to boost next attack.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1680 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 1
    local duration = 60

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, power, 0, duration))
    return xi.effect.BOOST
end

return mobskillObject
