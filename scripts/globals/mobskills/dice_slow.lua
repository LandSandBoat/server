-----------------------------------
-- Goblin Dice
--
-- Description: Stun
-- Type: Physical (Blunt)
--
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local slowed = false
    local sleeped = false

    slowed = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 0, 120)
    sleeped = xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30)

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    if sleeped then
        return xi.effect.SLEEP_I
    elseif slowed then
        return xi.effect.SLOW
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS) -- no effect
    end

    return nil
end

return mobskillObject
