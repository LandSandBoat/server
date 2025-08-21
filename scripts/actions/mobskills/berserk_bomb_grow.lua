-----------------------------------
-- Berserk
-- Notes: This ability is used by both Big Bomb and bombs in the area
--  That drop the item to spawn Big Bomb
--
--  Berserk (Bomb Grow) is observed to only be used when the bomb is in its default sub animation
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getModelId() == 282 then
        if mob:getAnimationSub() == 0 then -- Default sub animation
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, 50, 0, 180))
    return xi.effect.BERSERK
end

return mobskillObject
