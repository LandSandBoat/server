-----------------------------------
-- Perfect Defense
--
-- Description: Reduces damage taken and greatly increases resistance to most status effects.
-- Type: Enhancing
-- Can be dispelled: No
-- Range: Self
-- Notes:
-- Grants immunity to either physical, magical, or ranged damage.
-- Randomly switches immunities starting at 10% health. Accompanied by text
-- "Cease thy struggles...
-- I am immutable...indestructible...impervious...immortal..."
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 10000
    local duration = 10
    local tick     = 3

    xi.mobskills.mobBuffMove(mob, xi.effect.PERFECT_DEFENSE, power, tick, duration)

    skill:setMsg(xi.msg.basic.USES)
    return xi.effect.PERFECT_DEFENSE
end

return mobskillObject
