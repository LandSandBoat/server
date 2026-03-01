-----------------------------------
-- Samurai Job Utilities
-----------------------------------
require('scripts/globals/ability')
require('scripts/globals/jobpoints')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.samurai = xi.job_utils.samurai or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------

xi.job_utils.samurai.checkMeikyoShisui = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

xi.job_utils.samurai.checkYaegasumi = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

xi.job_utils.samurai.checkThirdEye = function(player, target, ability)
    if
        player:hasStatusEffect(xi.effect.SEIGAN) and
        player:isWeaponTwoHanded()
    then
        ability:setRecast(ability:getRecast() / 2)
    end

    return 0, 0
end

xi.job_utils.samurai.checkHasso = function(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    end

    return 0, 0
end

xi.job_utils.samurai.checkSeigan = function(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    end

    return 0, 0
end

xi.job_utils.samurai.checkKonzenIttai = function(player, target, ability)
    if player:getAnimation() ~= 1 then
        return xi.msg.basic.REQUIRES_COMBAT, 0
    end

    return 0, 0
end

xi.job_utils.samurai.checkBladeBash = function(player, target, ability)
    if not player:isWeaponTwoHanded() then
        return xi.msg.basic.NEEDS_2H_WEAPON, 0
    end

    return 0, 0
end

xi.job_utils.samurai.checkShikikoyo = function(player, target, ability)
    if player:getID() == target:getID() then
        return xi.msg.basic.CANNOT_PERFORM_TARG, 0
    elseif player:getTP() < 1000 then
        return xi.msg.basic.NOT_ENOUGH_TP, 0
    end

    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------

xi.job_utils.samurai.useMeikyoShisui = function(player, target, ability)
    player:addStatusEffect(xi.effect.MEIKYO_SHISUI, { power = 1, duration = 30, origin = player })
    player:addTP(3000)

    return 0
end

xi.job_utils.samurai.useYaegasumi = function(player, target, ability)
    player:addStatusEffect(xi.effect.YAEGASUMI, { power = 12, duration = 45, origin = player })

    return xi.effect.YAEGASUMI
end

xi.job_utils.samurai.useWardingCircle = function(player, target, ability)
    local duration = 180 + player:getMod(xi.mod.WARDING_CIRCLE_DURATION)
    local power    = 15

    if player:getMainJob() ~= xi.job.SAM then
        power = 5
    end

    power = power + player:getMod(xi.mod.WARDING_CIRCLE_POTENCY)

    target:addStatusEffect(xi.effect.WARDING_CIRCLE, { power = power, duration = duration, origin = player })

    return xi.effect.WARDING_CIRCLE
end

xi.job_utils.samurai.useThirdEye = function(player, target, ability)
    if
        player:hasStatusEffect(xi.effect.COPY_IMAGE) or
        player:hasStatusEffect(xi.effect.BLINK)
    then
        -- Returns "no effect" message when Copy Image is active when Third Eye is used.
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
    else
        player:addStatusEffect(xi.effect.THIRD_EYE, { duration = 30, origin = player }) -- Power keeps track of procs
    end

    return xi.effect.THIRD_EYE
end

xi.job_utils.samurai.useHasso = function(player, target, ability)
    local strboost = 0

    if target:getMainJob() == xi.job.SAM then
        strboost = target:getMainLvl() / 7 + target:getJobPointLevel(xi.jp.HASSO_EFFECT)
    elseif target:getSubJob() == xi.job.SAM then
        strboost = target:getSubLvl() / 7
    end

    if strboost > 0 then
        target:delStatusEffect(xi.effect.HASSO)
        target:delStatusEffect(xi.effect.SEIGAN)
        target:addStatusEffect(xi.effect.HASSO, { power = strboost, duration = 300, origin = player })
    end

    return xi.effect.HASSO
end

xi.job_utils.samurai.useMeditate = function(player, target, ability)
    local amount   = 12
    local duration = 15 + player:getMod(xi.mod.MEDITATE_DURATION)

    if player:getMainJob() == xi.job.SAM then
        amount = 20 + player:getJobPointLevel(xi.jp.MEDITATE_EFFECT) * 5
    end

    player:addStatusEffect(xi.effect.MEDITATE, { power = amount, duration = duration, origin = player, tick = 3, icon = 0 })

    return xi.effect.MEDITATE
end

xi.job_utils.samurai.useSeigan = function(player, target, ability)
    if target:isWeaponTwoHanded() then
        target:delStatusEffect(xi.effect.HASSO)
        target:delStatusEffect(xi.effect.SEIGAN)
        target:addStatusEffect(xi.effect.SEIGAN, { duration = 300, origin = player })
    end

    return xi.effect.SEIGAN
end

xi.job_utils.samurai.useSekkanoki = function(player, target, ability)
    target:delStatusEffect(xi.effect.SEKKANOKI)
    target:addStatusEffect(xi.effect.SEKKANOKI, { power = 1, duration = 60, origin = player })

    return xi.effect.SEKKANOKI
end

xi.job_utils.samurai.useKonzenIttai = function(player, target, ability, action)
    local params =
    {
        miss = 1,
        hit  = 5,
    }

    local infoValue = params.miss
    if
        not target:hasStatusEffect(xi.effect.CHAINBOUND, 0) and
        not target:hasStatusEffect(xi.effect.SKILLCHAIN, 0)
    then
        infoValue = params.hit
        target:addStatusEffect(xi.effect.CHAINBOUND, { power = 2, duration = 10, origin = player, icon = 0, subPower = 1 })
    else
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
    end

    local animationTable =
    {
        [xi.skill.AXE         ] = 28,
        [xi.skill.DAGGER      ] = 36,
        [xi.skill.SWORD       ] = 36,
        [xi.skill.NONE        ] = 37,
        [xi.skill.HAND_TO_HAND] = 37,
        [xi.skill.CLUB        ] = 39,
        [xi.skill.GREAT_AXE   ] = 40,
        [xi.skill.SCYTHE      ] = 40,
        [xi.skill.GREAT_SWORD ] = 41,
        [xi.skill.POLEARM     ] = 42,
        [xi.skill.KATANA      ] = 43,
        [xi.skill.GREAT_KATANA] = 44,
        [xi.skill.STAFF       ] = 45,
    }

    local animation = animationTable[player:getWeaponSkillType(xi.slot.MAIN)] or 37
    action:setAnimation(target:getID(), animation)
    action:info(target:getID(), infoValue)

    return infoValue == params.hit and 3 or 0
end

xi.job_utils.samurai.useBladeBash = function(player, target, ability, action)
    -- Stun
    if
        not xi.data.statusEffect.isTargetImmune(target, xi.effect.STUN, xi.element.THUNDER) and
        not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.STUN) and
        not xi.data.statusEffect.isEffectNullified(target, xi.effect.STUN, 0)
    then
        local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.A_PLUS, xi.element.THUNDER, xi.mod.INT, xi.effect.STUN, 0)
        if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.STUN, resistanceRate, 0) then
            target:addStatusEffect(xi.effect.STUN, { power = 1, duration = 6 * resistanceRate, origin = player })
        end
    end

    -- Plague
    if
        not xi.data.statusEffect.isTargetImmune(target, xi.effect.PLAGUE, xi.element.FIRE) and
        not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.PLAGUE) and
        not xi.data.statusEffect.isEffectNullified(target, xi.effect.PLAGUE, 0)
    then
        local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.A_PLUS, xi.element.FIRE, xi.mod.INT, xi.effect.PLAGUE, 0)
        if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.PLAGUE, resistanceRate, 0) then
            local duration = (15 + player:getMerit(xi.merit.BLADE_BASH)) * resistanceRate
            target:addStatusEffect(xi.effect.PLAGUE, { power = 5, duration = duration, origin = player })
        end
    end

    -- Animation
    local animationTable =
    {
        -- [weapon type] = animation ID
        [xi.skill.GREAT_SWORD ] = 201,
        [xi.skill.GREAT_KATANA] = 201,
        [xi.skill.GREAT_AXE   ] = 202,
        [xi.skill.SCYTHE      ] = 202,
        [xi.skill.STAFF       ] = 202,
        [xi.skill.POLEARM     ] = 203,
    }

    local animation = animationTable[player:getWeaponSkillType(xi.slot.MAIN)] or 0
    action:setAnimation(target:getID(), animation)

    ability:setMsg(xi.msg.basic.JA_DAMAGE)

    -- Blade Bash does not deal damage
    return 0
end

xi.job_utils.samurai.useShikikoyo = function(player, target, ability, action)
    local pTP = (player:getTP() - 1000) * (1 + (player:getMerit(xi.merit.SHIKIKOYO) - 12) / 100)
    pTP       = utils.clamp(pTP, 0, 3000 - target:getTP())

    player:setTP(1000)
    target:setTP(target:getTP() + pTP)

    return pTP
end

xi.job_utils.samurai.useSengikori = function(player, target, ability)
    player:addStatusEffect(xi.effect.SENGIKORI, { power = 25, duration = 60, origin = player })

    return xi.effect.SENGIKORI
end

xi.job_utils.samurai.useHamanoha = function(player, target, ability)
    local jpValue = target:getJobPointLevel(xi.jp.HAMANOHA_DURATION)

    target:addStatusEffect(xi.effect.HAMANOHA, { power = 12, duration = 180 + jpValue, origin = player })

    return xi.effect.HAMANOHA
end

xi.job_utils.samurai.useHagakure = function(player, target, ability)
    player:delStatusEffect(xi.effect.HAGAKURE)
    player:addStatusEffect(xi.effect.HAGAKURE, { power = 400, duration = 60, origin = player, subPower = 1000 })

    return xi.effect.HAGAKURE
end
