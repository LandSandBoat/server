-----------------------------------
-- BrainJack
-- Charms a player and inflicts a 25/tick dot while charmed
-- Only used by Long-Armed Chariot and Long-Horned Chariot. Last roughly 90 seconds; DoT takes about 25HP/tick.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 90
    local typeEffect = xi.effect.CHARM_I

    if not target:isPC() then
        skill:setMsg(xi.msg.basic.SKILL_MISS)
        return typeEffect
    elseif mob:getFamily() == 316 then -- Pandemonium Warden
        duration = 30
    end

    local msg = xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 0, 0, duration)
    if msg == xi.msg.basic.SKILL_ENFEEB_IS then
        target:addMod(xi.mod.REGEN_DOWN, 25)
        -- apply regen_down on the target, and stack DoT on the effect so it gets removed when charm is removed
        local effect = target:getStatusEffect(typeEffect)
        effect:addMod(xi.mod.REGEN_DOWN, 25)
        mob:charm(target)
        mob:resetEnmity(target)
    end

    skill:setMsg(msg)
    return typeEffect
end

return mobskillObject
