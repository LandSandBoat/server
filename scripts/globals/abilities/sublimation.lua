-----------------------------------
-- Ability: Sublimation
-- Gradually creates a storage of MP while reducing your HP. The effect ends once an MP limit is reached, or your HP has gone too low. The stored MP is then transferred to your MP pool by using the ability a second time.
-- Obtained: Scholar Level 35
-- Recast Time: 30 seconds after the ability is reactivated
-- Duration (Charging): Until MP stored is 25% of Max HP or until HP = 50%
-- Duration (Charged): 2 hours
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)

    local sublimationComplete = player:getStatusEffect(tpz.effect.SUBLIMATION_COMPLETE)
    local sublimationCharging = player:getStatusEffect(tpz.effect.SUBLIMATION_ACTIVATED)
    local mp = 0

    if sublimationComplete ~= nil then
        mp = sublimationComplete:getPower()
        local maxmp = player:getMaxMP()
        local currmp = player:getMP()
        if ( mp + currmp > maxmp ) then
            mp = maxmp - currmp
        end
        player:addMP(mp)
        player:delStatusEffectSilent(tpz.effect.SUBLIMATION_COMPLETE)
        ability:setMsg(tpz.msg.basic.JA_RECOVERS_MP)
    elseif sublimationCharging ~= nil then
        mp = sublimationCharging:getPower()
        local maxmp = player:getMaxMP()
        local currmp = player:getMP()
        if ( mp + currmp > maxmp ) then
            mp = maxmp - currmp
        end
        player:addMP(mp)
        player:delStatusEffectSilent(tpz.effect.SUBLIMATION_ACTIVATED)
        ability:setMsg(tpz.msg.basic.JA_RECOVERS_MP)
    else
        local refresh = player:getStatusEffect(tpz.effect.REFRESH)
        if refresh == nil or refresh:getSubPower() < 3 then
            player:delStatusEffect(tpz.effect.REFRESH)
            player:addStatusEffect(tpz.effect.SUBLIMATION_ACTIVATED, 0, 3, 7200)
        else
            ability:setMsg(tpz.msg.basic.JA_NO_EFFECT_2)
        end
    end
    return mp
end
