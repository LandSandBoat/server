-----------------------------------
-- Granite Skin
-- Description: Enhances defense and guarding skill (nullifies all physical damage from the front).
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- This is a special case where the defense boost prevents damage
    -- while the attacker is in front of the defender at the given subpower angle
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 60, 90)
    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.DEFENSE_BOOST, 0, 0, duration))

    if mob:hasStatusEffect(xi.effect.DEFENSE_BOOST) then
        local effect = mob:getStatusEffect(xi.effect.DEFENSE_BOOST)
        effect:setSubPower(90)
    end

    return xi.effect.DEFENSE_BOOST
end

return mobskillObject
