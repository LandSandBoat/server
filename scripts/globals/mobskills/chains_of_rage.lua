---------------------------------------------
-- Chains of Rage
--
---------------------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if (v.entity:isPC()) then
            local race = v.entity:getRace()
            if (race == tpz.race.GALKA) and not v.entity:hasKeyItem(tpz.ki.LIGHT_OF_ALTAIEU) then
                mob:showText(mob, ID.text.PROMATHIA_TEXT + 4)
                return 0
            end
        end
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local power = 30
    local duration = 30

    if target:isPC() and ((target:getRace() == tpz.race.GALKA) and not target:hasKeyItem(tpz.ki.LIGHT_OF_ALTAIEU)) then
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end

    return typeEffect
end
