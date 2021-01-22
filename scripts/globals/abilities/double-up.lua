-----------------------------------
-- Ability: Double Up
-- Enhances an active Phantom Roll effect that is eligible for Double-Up.
-- Obtained: Corsair Level 5
-- Recast Time: 8 seconds
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    ability:setRange(ability:getRange() + player:getMod(tpz.mod.ROLL_RANGE))
    if (not player:hasStatusEffect(tpz.effect.DOUBLE_UP_CHANCE)) then
        return tpz.msg.basic.NO_ELIGIBLE_ROLL, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(caster, target, ability, action)
    if (caster:getID() == target:getID()) then
        local du_effect = caster:getStatusEffect(tpz.effect.DOUBLE_UP_CHANCE)
        local prev_roll = caster:getStatusEffect(du_effect:getSubPower())
        local roll = prev_roll:getSubPower()
        local job = du_effect:getTier()
        caster:setLocalVar("corsairActiveRoll", du_effect:getSubType())
        local snake_eye = caster:getStatusEffect(tpz.effect.SNAKE_EYE)
        if (snake_eye) then
            if (prev_roll:getPower() >= 5 and math.random(100) < snake_eye:getPower()) then
                roll = 11
            else
                roll = roll + 1
            end
            caster:delStatusEffect(tpz.effect.SNAKE_EYE)
        else
            roll = roll + math.random(1, 6)
            if (roll > 12) then
                roll = 12
                caster:delStatusEffectSilent(tpz.effect.DOUBLE_UP_CHANCE)
            end
        end
        if (roll == 11) then
            caster:resetRecast(tpz.recast.ABILITY, 193)
        end
        caster:setLocalVar("corsairRollTotal", roll)
        action:speceffect(caster:getID(), roll - prev_roll:getSubPower())
        checkForJobBonus(caster, job)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    local prev_ability = getAbility(caster:getLocalVar("corsairActiveRoll"))
    if (prev_ability) then
        action:animation(target:getID(), prev_ability:getAnimation())
        action:actionID(prev_ability:getID())
        dofile("scripts/globals/abilities/" .. prev_ability:getName() .. ".lua")
        local total = applyRoll(caster, target, ability, action, total)
        local msg = ability:getMsg()
        if msg == 420 then
            ability:setMsg(tpz.msg.basic.DOUBLEUP)
        elseif msg == 422 then
            ability:setMsg(tpz.msg.basic.DOUBLEUP_FAIL)
        end
        return total
    end
end

return ability_object
