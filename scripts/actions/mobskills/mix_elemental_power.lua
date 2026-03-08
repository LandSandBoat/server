-----------------------------------
-- Mix: Elemental Power - Applies Magic Attack Bonus to all party members for 60 seconds.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- TODO: verify no effect messaging
mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if target:getID() == mob:getID() then
        skill:setMsg(194) -- Monberaux uses Mix: Guard Drink -- Monberaux gains the effect of {ID}
    else
        skill:setMsg(280) -- Target gains the effect of {ID}
    end

    if not target:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, { power = 20, duration = 60, origin = mob })
        return xi.effect.MAGIC_ATK_BOOST
    end

    return 0
end

return mobskillObject
