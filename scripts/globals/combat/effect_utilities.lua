xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.effect = xi.combat.effect or {}

xi.combat.effect.handleConsumeMana = function(player)
    local damage = 0

    if player:hasStatusEffect(xi.effect.CONSUME_MANA) then
        damage = damage + math.floor(player:getMP() / 10)
        player:setMP(0)
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
            player:addHP(-utils.stoneskin(player, math.floor(bonusDamage * stalwartSoulBonus)))

            if player:getMainJob() == xi.job.DRK then
                damage = math.floor(damage + bonusDamage)
            else
                damage = math.floor(damage + (bonusDamage / 2))
            end
        end
    end

    return damage
end

xi.combat.effect.handleRestraint = function(player)
    if player:hasStatusEffect(xi.effect.RESTRAINT) then
        local effect = player:getStatusEffect(xi.effect.RESTRAINT)
        if effect == nil then
            return
        end

        local power = effect:getPower()

        if effect:getPower() < 30 then
            local jpBonus = 0

            if player:isPC() then
                jpBonus = player:getJobPointLevel(xi.jp.RESTRAINT) * 2
            end

            -- Convert weapon delay and divide
            -- Pull remainder of previous hit's value from Effect Sub Power
            local boostPerRound = ((player:getBaseDelay() / 1000) * 60) / 385
            local remainder = effect:getSubPower() / 100

            -- Calculate bonuses from Enhances Restraint, Job Point upgrades, and remainder from previous hit
            boostPerRound = (boostPerRound * (1 + player:getMod(xi.Mod.ENHANCES_RESTRAINT) / 100) * (1 + jpBonus / 100)) + remainder

            -- Calculate new remainder and multiply by 100 so significant digits aren't lost
            remainder = math.floor((1 - (math.ceil(boostPerRound) - boostPerRound)) * 100)
            boostPerRound = math.floor(boostPerRound)

            -- Cap total power to +30% WSD
            if power + boostPerRound > 30 then
                boostPerRound = 30 - power
            end

            effect:setPower(power + boostPerRound)
            effect:setSubPower(remainder)
            player:setMod(xi.mod.ALL_WSDMG_FIRST_HIT, boostPerRound)
        end
    end
end
