-----------------------------------
-- Dream Flower
-- 15' AoE sleep
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if mob:getZoneID() == xi.zone.DYNAMIS_VALKURM then
        local effect = xi.effect.SLEEP_I
        local resist = xi.mobskills.applyPlayerResistance(mob, nil, target, mob:getStat(xi.mod.INT)-target:getStat(xi.mod.INT), 1, xi.magic.ele.DARK)
        local duration = math.ceil(60 + math.floor(31 * math.random()) * resist) -- wiki: duration variable from 30 to 90. can be thought of random 60-90 with possible half resist making it range 30-90
        if resist >= 0.5 then
            if
                not (target:hasImmunity(xi.immunity.SLEEP) or
                target:hasStatusEffect(xi.effect.SLEEP_I) or
                target:hasStatusEffect(xi.effect.SLEEP_II) or
                target:hasStatusEffect(xi.effect.LULLABY)) and
                -- use nightmare tick with 50 hp every 3 seconds
                target:addStatusEffect(effect, 20, 3, duration, 135, 50)
            then
                skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
            else
                skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
            end
        else
            skill:setMsg(xi.msg.basic.SKILL_MISS)
        end

        return effect
    else
        local typeEffect = xi.effect.SLEEP_I
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 1, 0, 90))
        return typeEffect
    end
end

return mobskillObject
