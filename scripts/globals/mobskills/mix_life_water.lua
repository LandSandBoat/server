-----------------------------------
-- Mix: Life Water - Applies Regen (20 HP/3 seconds) to all party members for 1 minute.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

-- TODO: what does no effect messaging look like?
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:getID() == mob:getID() then
        skill:setMsg(194) -- Monberaux uses {mix} -- Monberaux gains the effect of {ID}
    else
        skill:setMsg(280) -- Target gains the effect of {ID}
    end

    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, 20, 3, 60)
        return xi.effect.REGEN
    end

    return 0 -- Very wrong if no effect.
end

return mobskillObject
