-----------------------------------
--  Glow before Wrath of Zeus or Lightning Spear
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getAnimationSub() == 1 or
        mob:getLocalVar('charging') == 1
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    return 0 -- cosmetic move only
end

return mobskillObject
