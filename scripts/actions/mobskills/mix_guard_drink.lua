-----------------------------------
-- Mix: Guard Drink - Applies Protect (+220 Defense) and Shell to all party members for 5 minutes.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if target:getID() == mob:getID() then
        skill:setMsg(194) -- Monberaux uses Mix: Guard Drink -- Monberaux gains the effect of {ID}
    else
        skill:setMsg(280) -- Target gains the effect of {ID}
    end

    -- TODO: what happens when this has no effect?
    target:addStatusEffect(xi.effect.PROTECT, { power = 220, duration = 300, origin = mob })
    target:addStatusEffect(xi.effect.SHELL, { power = 2930, duration = 300, origin = mob })

    return xi.effect.PROTECT -- Monberaux gains the effect of Protect.
end

return mobskillObject
