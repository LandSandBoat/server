-----------------------------------
-- Ability: Healing Waltz
-- Removes one detrimental status effect from target party member.
-- Obtained: Dancer Level 35
-- TP Required: 20%
-- Recast Time: 00:15
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    local waltzCost = 200 - player:getMod(xi.mod.WALTZ_COST) * 10
    if target:getHP() == 0 then
        return xi.msg.basic.CANNOT_ON_THAT_TARG, 0
    elseif player:hasStatusEffect(xi.effect.SABER_DANCE) then
        return xi.msg.basic.UNABLE_TO_USE_JA2, 0
    elseif player:hasStatusEffect(xi.effect.TRANCE) then
        return 0, 0
    elseif player:getTP() < waltzCost then
        return xi.msg.basic.NOT_ENOUGH_TP, 0
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

        return 0, 0
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    local waltzCost = 200 - player:getMod(xi.mod.WALTZ_COST) * 10
    -- Only remove TP if the player doesn't have Trance.
    if not player:hasStatusEffect(xi.effect.TRANCE) then
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
