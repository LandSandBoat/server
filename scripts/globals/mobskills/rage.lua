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
        if player ~= nil and player:hasJugPet() then
            local tp = skill:getTP()
            duration = math.max(60, 60 * (tp / 1000))
        end
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, power, 0, duration))
    return xi.effect.BERSERK
end

return mobskillObject
