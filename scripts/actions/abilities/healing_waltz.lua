-----------------------------------
-- Ability: Healing Waltz
-- Removes one detrimental status effect from target party member.
-- Obtained: Dancer Level 35
-- TP Required: 20%
-- Recast Time: 00:15
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local waltzCost = 200 - player:getMod(xi.mod.WALTZ_COST) * 10
    local returnCode = 0
    local canUseAbility = false
    if target:getHP() == 0 then
        returnCode = xi.msg.basic.CANNOT_ON_THAT_TARG
    elseif player:hasStatusEffect(xi.effect.SABER_DANCE) then
        returnCode = xi.msg.basic.UNABLE_TO_USE_JA2
    elseif player:hasStatusEffect(xi.effect.TRANCE) then
        canUseAbility = true
    elseif player:getTP() < waltzCost then
        returnCode = xi.msg.basic.NOT_ENOUGH_TP
    else
        --[[ Apply "Waltz Ability Delay" reduction
            1 modifier = 1 second]]
        local recastMod = player:getMod(xi.mod.WALTZ_DELAY)
        if recastMod ~= 0 then
            local newRecast = ability:getRecast() + recastMod
            ability:setRecast(utils.clamp(newRecast, 0, newRecast))
        end

        -- Apply "Fan Dance" Waltz recast reduction
        if player:hasStatusEffect(xi.effect.FAN_DANCE) then
            local fanDanceMerits = target:getMerit(xi.merit.FAN_DANCE)
            -- Every tier beyond the 1st is -5% recast time
            if fanDanceMerits > 5 then
                ability:setRecast(ability:getRecast() * ((fanDanceMerits - 5) / 100))
            end
        end

        canUseAbility = true
    end

    if
        canUseAbility and
        player:getStatusEffect(xi.effect.CONTRADANCE)
    then
        ability:setAOE(1)
        ability:setRange(10)
        player:delStatusEffect(xi.effect.CONTRADANCE)
    end

    return returnCode, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    local waltzCost = 200 - player:getMod(xi.mod.WALTZ_COST) * 10
    -- Only remove TP if the player doesn't have Trance.
    if
        not player:hasStatusEffect(xi.effect.TRANCE) and
        action:getPrimaryTargetID() == target:getID()
    then
        player:delTP(waltzCost)
    end

    local effect = target:healingWaltz()

    if effect == xi.effect.NONE then
        ability:setMsg(xi.msg.basic.NO_EFFECT) -- no effect
    else
        ability:setMsg(xi.msg.basic.JA_REMOVE_EFFECT)
    end

    return effect
end

return abilityObject
