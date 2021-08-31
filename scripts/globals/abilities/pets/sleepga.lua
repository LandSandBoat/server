-----------------------------------
-- Sleepga
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/spell_data")
require("scripts/globals/summon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local duration = 90
    local dINT = pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local bonus = getSummoningSkillOverCap(pet)
    local resm = applyPlayerResistance(pet, -1, target, dINT, bonus, xi.magic.element.ICE)
    if (resm < 0.5) then
        skill:setMsg(xi.msg.basic.JA_MISS_2) -- resist message
        return xi.effect.SLEEP_I
    end
    duration = duration * resm
    if (target:hasImmunity(1) or hasSleepEffects(target)) then
        --No effect
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_ENFEEB)

        target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration)
    end

    return xi.effect.SLEEP_I
end

return ability_object
