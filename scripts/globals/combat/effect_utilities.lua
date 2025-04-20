xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.effect = xi.combat.effect or {}

xi.combat.effect.handleStoneskin = function(defender, damage)
    -- Stoneskin
    local skin = defender:getMod(xi.mod.STONESKIN)
    if damage > 0 and skin > 0 then
        if skin > damage then
            defender:delMod(xi.mod.STONESKIN, damage)
            return 0
        end
            
        defender:delStatusEffect(xi.effect.STONESKIN)
        return damage - skin
    end

    return damage
end

xi.combat.effect.handleScarletDelirium = function(defender, damage)
    -- Check for Scarlet Delirium and update Effect Power with bonus from damage
    if defender:hasStatusEffect(xi.effect.SCARLET_DELIRIUM) then
        local effect = defender:getStatusEffect(xi.effect.SCARLET_DELIRIUM)

        -- Damage bonus calculation, update Effect Power
        if effect:getPower() == 0 then
            -- Damage to Max HP Ratio
            local bonus = math.floor(damage * 100 / defender:getMaxHP() / 2)
            local duration = 90 + effect:getSubPower()

            -- Convert status effect from "Absorb damage" mode to "Provide damage bonus" mode
            defender:delStatusEffectSilent(xi.effect.SCARLET_DELIRIUM)
            defender:addStatusEffect(xi.effect.SCARLET_DELIRIUM_1, xi.effect.SCARLET_DELIRIUM_1, bonus, 0, duration)
        end
    end
end

xi.combat.effect.handleConsumeMana = function(player)
    local damage = 0

    if player:hasStatusEffect(xi.effect.CONSUME_MANA) then
        damage = damage + math.floor(player.getHP() / 10)
        player:setHP(0)
        player:delStatusEffect(xi.effect.CONSUME_MANA)
    end

    return damage
end

xi.combat.effect.handleSoulEater = function(player, damage)
    if player:hasStatusEffect(xi.effect.SOULEATER) then
        -- Souleater's HP consumed is 10% (base) + x% from gear (only highest) + x% from gear augments.
        local souleaterBonus = player:getMaxGearMod(xi.mod.SOULEATER_EFFECT) * 0.01
        local souleaterBonusII = player:getMod(xi.mod.SOULEATER_EFFECT_II) * 0.01
        local stalwartSoulBonus = 1 - player:getMod(xi.mod.STALWART_SOUL) / 100
        local bonusDamage = player:getHP() * (0.1 + souleaterBonus + souleaterBonusII)

        if bonusDamage >= 1 then
            player:addHP(-handleStoneskin(player, math.floor(bonusDamage * stalwartSoulBonus)))

            if player:getMainJob() == xi.job.DRK then
                damage = math.floor(damage + bonusDamage)
            else
                damage = math.floor(damage + (bonusDamage / 2))
            end
        end
    end

    return damage
end
