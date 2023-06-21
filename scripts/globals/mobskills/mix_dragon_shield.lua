-----------------------------------
-- Mix: Dragon Shield - Applies Magic Defense Bonus to all party members for 60 seconds.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- TODO: verify no effect messaging
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:getID() == mob:getID() then
        skill:setMsg(194) -- Monberaux uses Mix: Guard Drink -- Monberaux gains the effect of {ID}
    else
        skill:setMsg(280) -- Target gains the effect of {ID}
    end

    if not target:hasStatusEffect(xi.effect.MAGIC_DEF_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 10, 0, 60)
    end

    return xi.effect.MAGIC_DEF_BOOST
end

return mobskillObject
