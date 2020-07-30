-----------------------------------
-- Ability: Divine Waltz II
-- Restores the HP of all party members within a small radius.
-- Obtained: Dancer Level 78
-- TP Required: 80%
-- Recast Time: 00:20
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
    elseif (player:getTP() < 800) then
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
    -- Only remove TP if the player doesn't have Trance, and only deduct once instead of for each target.
    if (player:getID() == target:getID() and player:hasStatusEffect(tpz.effect.TRANCE) == false) then
        player:delTP(800)
    end

    -- Grabbing variables.
    local vit = target:getStat(tpz.mod.VIT)
    local chr = player:getStat(tpz.mod.CHR)
    local mjob = player:getMainJob() --19 for DNC main.
    local sjob = player:getSubJob()
    local cure = 0

    -- Performing sj mj check.
    if mjob == tpz.job.DNC then
        cure = (vit+chr)*0.75+270
    end

    if sjob == tpz.job.DNC then
        cure = (vit+chr)*0.175+270
    end

    -- Apply waltz modifiers
    cure = math.floor(cure * (1.0 + (player:getMod(tpz.mod.WALTZ_POTENTCY)/100)))

    -- Cap the final amount to max HP.
    if ((target:getMaxHP() - target:getHP()) < cure) then
        cure = (target:getMaxHP() - target:getHP())
    end

    -- Applying server mods....
    cure = cure * CURE_POWER

    target:restoreHP(cure)
    target:wakeUp()
    player:updateEnmityFromCure(target, cure)

    return cure
end
