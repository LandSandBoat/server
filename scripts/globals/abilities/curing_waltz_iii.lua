-----------------------------------
-- Ability: Curing Waltz III
-- Heals HP to target player.
-- Obtained: Dancer Level 45
-- TP Required: 50%
-- Recast Time: 00:10
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if (target:getHP() == 0) then
        return tpz.msg.basic.CANNOT_ON_THAT_TARG, 0
    elseif (player:hasStatusEffect(tpz.effect.SABER_DANCE)) then
        return tpz.msg.basic.UNABLE_TO_USE_JA2, 0
    elseif (player:hasStatusEffect(tpz.effect.TRANCE)) then
        return 0, 0
    elseif (player:getTP() < 500) then
        return tpz.msg.basic.NOT_ENOUGH_TP, 0
    else
        --[[ Apply "Waltz Ability Delay" reduction
            1 modifier = 1 second]]
        local recastMod = player:getMod(tpz.mod.WALTZ_DELAY)
        if (recastMod ~= 0) then
            local newRecast = ability:getRecast() +recastMod
            ability:setRecast(utils.clamp(newRecast, 0, newRecast))
        end
        -- Apply "Fan Dance" Waltz recast reduction
        if (player:hasStatusEffect(tpz.effect.FAN_DANCE)) then
            local fanDanceMerits = target:getMerit(tpz.merit.FAN_DANCE)
            -- Every tier beyond the 1st is -5% recast time
            if (fanDanceMerits > 5) then
                ability:setRecast(ability:getRecast() * ((fanDanceMerits -5)/100))
            end
        end
        return 0, 0
    end
end

function onUseAbility(player, target, ability)
    -- Only remove TP if the player doesn't have Trance.
    if not player:hasStatusEffect(tpz.effect.TRANCE) then
        player:delTP(500)
    end

    --Grabbing variables.
    local vit = target:getStat(tpz.mod.VIT)
    local chr = player:getStat(tpz.mod.CHR)
    local mjob = player:getMainJob() --19 for DNC main.
    local cure = 0



    --Performing mj check.
    if mjob == tpz.job.DNC then
        cure = (vit+chr)*0.75+270
    else
        cure = (vit+chr)*0.375+270
    end

    -- apply waltz modifiers
    cure = math.floor(cure * (1.0 + (player:getMod(tpz.mod.WALTZ_POTENTCY)/100)))

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
