-----------------------------------
-- Mix: Guard Drink - Applies Protect (+220 Defense) and Shell to all party members for 5 minutes.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:getID() == mob:getID() then
        skill:setMsg(194) -- Monberaux uses Mix: Guard Drink -- Monberaux gains the effect of {ID}
    else
        skill:setMsg(280) -- Target gains the effect of {ID}
    end

    -- TODO: what happens when this has no effect?
    target:addStatusEffect(xi.effect.PROTECT, 220, 0, 300)
    target:addStatusEffect(xi.effect.SHELL, 2930, 0, 300)

    return xi.effect.PROTECT -- Monberaux gains the effect of Protect.
end

return mobskillObject
