-----------------------------------
-- Ability: Curing Waltz IV
-- Heals HP to target player.
-- Obtained: Dancer Level 70
-- TP Required: 65%
-- Recast Time: 00:17
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if (target:getHP() == 0) then
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    elseif (player:hasStatusEffect(xi.effect.SABER_DANCE)) then
        return xi.msg.basic.UNABLE_TO_USE_JA2, 0
    elseif (player:hasStatusEffect(xi.effect.TRANCE)) then
        return 0, 0
    elseif (player:getTP() < 650) then
        return xi.msg.basic.NOT_ENOUGH_TP, 0
    else
        --[[ Apply "Waltz Ability Delay" reduction
            1 modifier = 1 second]]
        local recastMod = player:getMod(xi.mod.WALTZ_DELAY)
        if (recastMod ~= 0) then
            local newRecast = ability:getRecast() +recastMod
            ability:setRecast(utils.clamp(newRecast, 0, newRecast))
        end
        -- Apply "Fan Dance" Waltz recast reduction
        if (player:hasStatusEffect(xi.effect.FAN_DANCE)) then
            local fanDanceMerits = target:getMerit(xi.merit.FAN_DANCE)
            -- Every tier beyond the 1st is -5% recast time
            if (fanDanceMerits > 5) then
                ability:setRecast(ability:getRecast() * ((fanDanceMerits -5)/100))
            end
        end
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    -- Only remove TP if the player doesn't have Trance.
    if not player:hasStatusEffect(xi.effect.TRANCE) then
        player:delTP(650)
    end

    --Grabbing variables.
    local vit = target:getStat(xi.mod.VIT)
    local chr = player:getStat(xi.mod.CHR)
    local mjob = player:getMainJob() --19 for DNC main.
    local cure = 0

    --Performing mj check.
    if mjob == xi.job.DNC then
        cure = (vit+chr)+450
    else
        cure = (vit+chr)*0.5+450
    end

    -- apply waltz modifiers
    cure = math.floor(cure * (1.0 + (player:getMod(xi.mod.WALTZ_POTENTCY)/100)))

    --Reducing TP.

    --Applying server mods....
    cure = cure * CURE_POWER

    --Cap the final amount to max HP.
    if ((target:getMaxHP() - target:getHP()) < cure) then
        cure = (target:getMaxHP() - target:getHP())
    end

    --Do it
    target:restoreHP(cure)
    target:wakeUp()
    player:updateEnmityFromCure(target, cure)

    return cure

end

return ability_object
