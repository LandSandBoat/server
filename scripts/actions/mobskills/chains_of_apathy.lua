-----------------------------------
-- Chains of Apathy
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if v.entity:isPC() then
            local race = v.entity:getRace()
            if
                (race == xi.race.HUME_M or race == xi.race.HUME_F) and
                not v.entity:hasKeyItem(xi.ki.LIGHT_OF_VAHZL)
            then
                mob:showText(mob, ID.text.PROMATHIA_TEXT)
                return 0
            end
        end
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if
        target:isPC() and
        (
            (target:getRace() == xi.race.HUME_M or target:getRace() == xi.race.HUME_F) and
            not target:hasKeyItem(xi.ki.LIGHT_OF_VAHZL)
        )
    then
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 30, 0, 30))
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.TERROR
end

return mobskillObject
