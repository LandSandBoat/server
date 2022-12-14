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
    local duration = 120
    local power = (116 / 256) * 100

    if mob:isPet() then
        local player = mob:getMaster()
        -- isJugPet is really hasJugPet.  Given an entity it returns true if that entity has a pet and the pet is a jug pet
        -- TODO - Rule of 3 counter = 1 - rename isJugPet to has, add isJugPet
        if player ~= nil and player:isJugPet() then
            local tp = skill:getTP()
            duration = math.max(60, 60 * (tp / 1000))
        end
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, power, 0, duration))
    return xi.effect.BERSERK
end

return mobskillObject
