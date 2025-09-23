-----------------------------------
-- Floral Bouquet
-- Puts enemies in area of effect to sleep. Charms nearby vermin.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:getAllegiance() == mob:getAllegiance() then
        if target:getEcosystem() == xi.ecosystem.VERMIN then
            local mobTarget = mob:getTarget()

            if mobTarget ~= nil then
                target:engage(mobTarget:getTargID())
            end

            skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)

            return xi.effect.CHARM_I
        else
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)

            return 0
        end
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30))

    return xi.effect.SLEEP_I
end

return mobskillObject
