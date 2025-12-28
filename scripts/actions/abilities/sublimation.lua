-----------------------------------
-- Ability: Sublimation
-- Gradually creates a storage of MP while reducing your HP. The effect ends once an MP limit is reached, or your HP has gone too low. The stored MP is then transferred to your MP pool by using the ability a second time.
-- Obtained: Scholar Level 35
-- Recast Time: 30 seconds after the ability is reactivated
-- Duration (Charging): Until MP stored is 25% of Max HP or until HP = 50%
-- Duration (Charged): 2 hours
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    local mp        = 0
    local maxMP     = player:getMaxMP()
    local currentMP = player:getMP()

    if player:hasStatusEffect(xi.effect.SUBLIMATION_COMPLETE) then
        mp = player:getStatusEffect(xi.effect.SUBLIMATION_COMPLETE):getPower()

        if mp + currentMP > maxMP then
            mp = maxMP - currentMP
        end

        player:addMP(mp)
        player:delStatusEffectSilent(xi.effect.SUBLIMATION_COMPLETE)
        ability:setMsg(xi.msg.basic.JA_RECOVERS_MP)
    elseif player:hasStatusEffect(xi.effect.SUBLIMATION_ACTIVATED) then
        mp = player:getStatusEffect(xi.effect.SUBLIMATION_ACTIVATED):getPower()

        if mp + currentMP > maxMP then
            mp = maxMP - currentMP
        end

        player:addMP(mp)
        player:delStatusEffectSilent(xi.effect.SUBLIMATION_ACTIVATED)
        ability:setMsg(xi.msg.basic.JA_RECOVERS_MP)
    else
        local refreshTier = player:hasStatusEffect(xi.effect.REFRESH) and player:getStatusEffect(xi.effect.REFRESH):getTier() or 0
        if refreshTier < 3 then
            player:delStatusEffect(xi.effect.REFRESH)
            player:addStatusEffect(xi.effect.SUBLIMATION_ACTIVATED, 0, 3, 7200)
        else
            ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        end
    end

    return mp
end

return abilityObject
