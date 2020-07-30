---------------------------------------------
-- Chains of Apathy
--
---------------------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local targets = mob:getEnmityList()
    for i, v in pairs(targets) do
        if (v.entity:isPC()) then
            local race = v.entity:getRace()
            if (race == tpz.race.HUME_M or race == tpz.race.HUME_F) and not v.entity:hasKeyItem(tpz.ki.LIGHT_OF_VAHZL) then
                mob:showText(mob, ID.text.PROMATHIA_TEXT)
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

    if target:isPC() and ((target:getRace() == tpz.race.HUME_M or target:getRace() == tpz.race.HUME_F) and not target:hasKeyItem(tpz.ki.LIGHT_OF_VAHZL)) then
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    return typeEffect
end
