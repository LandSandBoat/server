-----------------------------------
-- BrainJack
-- Charms a player and inflicts a 25/tick dot while charmed
-- Brainjack is single target Charm plus DoT (-25 HP/tick) for 60 seconds
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.CHARM_I
    local duration = 60

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHARM_I, 0, 3, duration))
    if skill:getMsg() == xi.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
        mob:resetEnmity(target)
        local effect = target:getStatusEffect(typeEffect)
        if effect then
            effect:addMod(xi.mod.REGEN_DOWN, 25)
        end
    end

    return typeEffect
end

return mobskillObject
