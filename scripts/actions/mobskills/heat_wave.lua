-----------------------------------
-- Heat Wave
-- Notes: This ability is used by both Big Bomb and bombs in the area
--  That drop the item to spawn Big Bomb. It applies a potent burn effect to
--  targets in the area.
--
--  Hellstorm is observed to only be used when the bomb has grown two times.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getModelId() == 282 then
        if mob:getAnimationSub() >= 2 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = math.floor(mob:getMainLvl() / 2.05)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BURN, power, 3, 180)

    return xi.effect.BURN
end

return mobskillObject
