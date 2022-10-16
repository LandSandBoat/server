-----------------------------------
-- Rage
--
-- Description: The Ram goes berserk
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 25% Attack UP, -25% defense DOWN
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 60

    if mob:isPet() then
        local player = mob:getMaster();
        -- isJugPet is really hasJugPet.  Given an entity it returns true if that entity has a pet and the pet is a jug pet
        -- TODO - Rule of 3 counter = 1 - rename isJugPet to has, add isJugPet
        if player~=nil and player:isJugPet() then
            local tp = skill:getTP()
            duration = math.max(duration, duration* (tp/1000))
        end
    end

    local typeEffect = xi.effect.BERSERK
    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 50, 0, duration))
    return typeEffect
end

return mobskillObject
