-----------------------------------
-- Rear Lasers
-- Fires aft lasers at players behind user. Additional effects: Petrification
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob) then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PETRIFICATION, 1, 0, 30))

    return xi.effect.PETRIFICATION
end

return mobskillObject
