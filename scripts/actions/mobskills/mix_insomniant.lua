-----------------------------------
-- Mix: Insomniant - Negates Sleep.
-- Monberaux only uses this on himself when hit with an attack that causes sleep.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- Messaging and return value assumed.
mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(194)

    if not target:hasStatusEffect(xi.effect.NEGATE_SLEEP) then
        target:addStatusEffect(xi.effect.NEGATE_SLEEP, { power = 10, duration = 60, origin = mob })
    end

    return xi.effect.NEGATE_SLEEP
end

return mobskillObject
