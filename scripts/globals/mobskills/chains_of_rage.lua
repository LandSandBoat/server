-----------------------------------
-- Chains of Rage
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                race == xi.race.GALKA and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + 4)
                return 0
            end
        end
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.TERROR
    local power = 30
    local duration = 30

    if
        target:isPC() and
        target:getRace() == xi.race.GALKA and
        not target:hasKeyItem(xi.ki.LIGHT_OF_ALTAIEU)
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end

return mobskillObject
