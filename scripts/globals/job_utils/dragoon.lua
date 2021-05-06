-----------------------------------
-- Dragoon Job Utilities
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/weaponskills")
require("scripts/globals/jobpoints")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.dragoon = xi.job_utils.dragoon or {}
-----------------------------------

-- Returns a table of WS Parameters common to all damage-dealing jumps
local function getJumpWSParams(player, atkMultiplier, tpMultiplier)
    local ftp = 1 + (player:getStat(xi.mod.VIT) / 256)

    local params =
    {
        numHits = 1,
        ftp100 = ftp,
        ftp200 = ftp,
        ftp300 = ftp,

        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0,

        crit100 = 0.0,
        crit200 = 0.0,
        crit300 = 0.0,
        canCrit = true,

        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,

        atk100 = atkMultiplier,
        atk200 = atkMultiplier,
        atk300 = atkMultiplier,

        bonusTP = player:getMod(xi.mod.JUMP_TP_BONUS),
        targetTPMult = tpMultiplier,
        hitsHigh = true,
    }

    if player:getMod(xi.mod.FORCE_JUMP_CRIT) > 0 then
        params.crit100 = 1.0
        params.crit200 = 1.0
        params.crit300 = 1.0
    end

    return params
end

local function getWyvern(player)
    local pet = player:getPet()

    if pet and player:getPetID() == xi.pet.id.WYVERN then
        return pet
    end

    return nil
end

local function hasWyvern(player)
    return getWyvern(player) and true or false
end

-- Generic Function for damage-based Jumps
local function performWSJump(player, target, action, params)
    local taChar = player:getTrickAttackChar(target)
    local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, 0, params, 0, action, true, taChar)
    local totalHits = tpHits + extraHits

    if totalHits > 0 then
        if criticalHit then
            action:speceffect(target:getID(), 38)
        end

        action:messageID(target:getID(), xi.msg.basic.USES_JA_TAKE_DAMAGE)
        action:speceffect(target:getID(), 32)
    else
        action:messageID(target:getID(), xi.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), 0)
    end

    return damage, totalHits
end

local function cutEmpathyEffectTable(validEffects, i, maxCount)
    local delindex = 1

    while maxCount < i do
        delindex = math.random(1, i)
        while validEffects[delindex+1] ~= nil do
            validEffects[delindex] = validEffects[delindex+1]
            delindex = delindex + 1
        end
        validEffects[delindex+1] = nil -- could be in the above loop, but unsure if Lua allows copying of nil?
        i = i - 1
    end

    return validEffects
end

-- Ability Check Functions
-- Note: This does not include Always-Allow abilitys (return 0, 0 by default)
xi.job_utils.dragoon.abilityCheckRequiresPet = function(player, target, ability)
    if not hasWyvern(target) then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if ability:getID() == xi.jobAbility.SPIRIT_SURGE then
            ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
        end
        return 0, 0
    end
end

xi.job_utils.dragoon.abilityCheckCallWyvern = function(player, target, ability)
    if player:getPet() ~= nil then
         return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif player:hasStatusEffect(xi.effect.SPIRIT_SURGE) then
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    else
        return 0, 0
    end
end

xi.job_utils.dragoon.abilityCheckSpiritLink = function(player, target, ability)
    local pet = player:getPet()

    if not hasWyvern(player) then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if
            pet:getHP() == pet:getMaxHP() and
            player:getMerit(xi.merit.EMPATHY) == 0
        then
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        else
            return 0, 0
        end
    end
end

xi.job_utils.dragoon.abilityCheckDeepBreathing = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not hasWyvern(player) then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

xi.job_utils.dragoon.abilityCheckAngon = function(player, target, ability)
    local id = player:getEquipID(xi.slot.AMMO)

    if id == 18259 then
        return 0, 0
    else
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    end
end

xi.job_utils.dragoon.useSpiritSurge = function(player, target, ability)
    local pet = player:getPet()
    local petTP = pet:getTP()
    local duration = 60

    -- Spirit Surge increases dragoon's MAX HP increases by 25% of wyvern MaxHP
    -- bg wiki says 25% ffxiclopedia says 15%, going with 25 for now
    local mhp_boost = target:getPet():getMaxHP() * 0.25

    -- Dragoon gets all of wyverns TP when using Spirit Surge
    target:addTP(petTP)
    pet:delTP(petTP)

    -- Spirit Surge increases dragoon's Strength
    local strBoost = 0
    if target:getMainJob() == xi.job.DRG then
        strBoost = 1 + math.floor(target:getMainLvl() / 5)
    else
        strBoost = 1 + math.floor(target:getSubLvl() / 5)
    end

    target:despawnPet()

    -- All Jump recast times are reset
    target:resetRecast(xi.recast.ABILITY, 158) -- Jump
    target:resetRecast(xi.recast.ABILITY, 159) -- High Jump
    target:resetRecast(xi.recast.ABILITY, 160) -- Super Jump

    target:addStatusEffect(xi.effect.SPIRIT_SURGE, mhp_boost, 0, duration, 0, strBoost)
end

xi.job_utils.dragoon.useCallWyvern = function(player, target, ability)
    xi.pet.spawnPet(player, xi.pet.id.WYVERN)
end

xi.job_utils.dragoon.useAncientCircle = function(player, target, ability)
    local duration = 180 + player:getMod(xi.mod.ANCIENT_CIRCLE_DURATION)
    local jpValue = player:getJobPointLevel(xi.jp.ANCIENT_CIRCLE_EFFECT)
    local power = 5

    if player:getMainJob() == xi.job.DRG then
        power = 15 + jpValue
    end

    target:addStatusEffect(xi.effect.ANCIENT_CIRCLE, power, 0, duration)
end

xi.job_utils.dragoon.useJump = function(player, target, ability, action)
    local atkMultiplier = (player:getMod(xi.mod.JUMP_ATT_BONUS) + 100) / 100
    local params = getJumpWSParams(player, atkMultiplier, nil)
    local damage, totalHits = performWSJump(player, target, action, params)

    -- Under Spirit Surge, Jump also decreases target defense by 20% for 60 seconds
    if
        totalHits > 0 and
        player:hasStatusEffect(xi.effect.SPIRIT_SURGE) and
        not target:hasStatusEffect(xi.effect.DEFENSE_DOWN)
    then
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 20, 0, 60)
    end

    return damage
end

xi.job_utils.dragoon.useSpiritLink = function(player, target, ability)
    local pet = player:getPet()
    local playerHP = player:getHP()
    local drainamount = (math.random(25, 35) / 100) * playerHP
    local jpValue = player:getJobPointLevel(xi.jp.SPIRIT_LINK_EFFECT)

    drainamount = drainamount * (1 - (0.01 * jpValue))

    if pet:getHP() == pet:getMaxHP() then
        drainamount = 0 -- Prevents player HP lose if wyvern is at full HP
    end

    if player:hasStatusEffect(xi.effect.STONESKIN) then
        local skin = player:getMod(xi.mod.STONESKIN)

        if skin >= drainamount then
            if skin == drainamount then
                player:delStatusEffect(xi.effect.STONESKIN)
            else
                local effect = player:getStatusEffect(xi.effect.STONESKIN)
                effect:setPower(effect:getPower() - drainamount) -- fixes the status effeect so when it ends it uses the new power instead of old
                player:delMod(xi.mod.STONESKIN, drainamount) --removes the amount from the mod

            end
        else
            player:delStatusEffect(xi.effect.STONESKIN)
            player:takeDamage(drainamount - skin)
        end

    else
        player:takeDamage(drainamount)
    end

    local healPet = drainamount * 2
    local petTP = pet:getTP()
    local regenAmount = player:getMainLvl() / 3 -- level/3 tic regen

    if player:getEquipID(xi.slot.HEAD) == 15238 then
        healPet = healPet + 15
    end

    pet:delStatusEffect(xi.effect.POISON)
    pet:delStatusEffect(xi.effect.BLINDNESS)
    pet:delStatusEffect(xi.effect.PARALYSIS)

    if math.random(1, 2) == 1 then
        pet:delStatusEffect(xi.effect.DOOM)
    end

    if pet:getHP() < pet:getMaxHP() then -- sleep is only removed if it heals the wyvern
        removeSleepEffects(pet)
    end

    -- Empathy copying
    local empathyTotal = player:getMerit(xi.merit.EMPATHY)
    if empathyTotal > 0 then
        local effects = player:getStatusEffects()
        local validEffects = {}
        local i = 0 -- highest existing index
        local copyi = 0

        for _, effect in pairs(effects) do
            if bit.band(effect:getFlag(), xi.effectFlag.EMPATHY) == xi.effectFlag.EMPATHY then
                validEffects[i+1] = effect
                i = i + 1
            end
        end

        if i < empathyTotal then
            empathyTotal = i
        elseif i > empathyTotal then
            validEffects = cutEmpathyEffectTable(validEffects, i, empathyTotal)
        end

        local copyEffect = nil
        while copyi < empathyTotal do
            copyEffect = validEffects[copyi+1]
            if pet:hasStatusEffect(copyEffect:getType()) then
                pet:delStatusEffect(copyEffect:getType())
            end

            pet:addStatusEffect(copyEffect:getType(), copyEffect:getPower(), copyEffect:getTick(), math.ceil((copyEffect:getTimeRemaining())/1000)) -- id, power, tick, duration(convert ms to s)
            copyi = copyi + 1
        end
    end

    pet:addHP(healPet) --add the hp to pet
    pet:addStatusEffect(xi.effect.REGEN, regenAmount, 3, 90, 0, 0, 0) -- 90 seconds of regen
    player:addTP(petTP / 2) --add half pet tp to you
    pet:delTP(petTP / 2) -- remove half tp from pet
end

xi.job_utils.dragoon.useHighJump = function(player, target, ability, action)
    local params = getJumpWSParams(player, 1, 0)
    local damage, totalHits = performWSJump(player, target, action, params)

    if target:isMob() then
        local enmityShed = 50
        if player:getMainJob() ~= xi.job.DRG then
            enmityShed = 30
        end

        target:lowerEnmity(player, enmityShed + player:getMod(xi.mod.HIGH_JUMP_ENMITY_REDUCTION)) -- reduce total accumulated enmity
    end

    if
        totalHits > 0 and
        player:hasStatusEffect(xi.effect.SPIRIT_SURGE)
    then
        -- Under Spirit Surge, High Jump reduces TP of target
        target:delTP(damage * 0.2)
    end

    return damage
end

xi.job_utils.dragoon.useSuperJump = function(player, target, ability)
    -- Reduce 99% of total accumulated enmity
    if target:isMob() then
        target:lowerEnmity(player, 99)
    end

    ability:setMsg(xi.msg.basic.NONE)

    -- Prevent the player from performing actions while in the air
    player:queue(0, function(player)
        player:stun(5000)
    end)

    -- If the Dragoon's wyvern is out and alive, tell it to use Super Climb
    local wyvern = getWyvern(player)
    if
        wyvern ~= nil and
        wyvern:getHP() > 0
    then
        wyvern:useJobAbility(636, wyvern)
    end
end

xi.job_utils.dragoon.useAngon = function(player, target, ability)
    local typeEffect = xi.effect.DEFENSE_DOWN
    local duration = 15 + player:getMerit(xi.merit.ANGON) -- This will return 30 sec at one investment because merit power is 15.

    if target:addStatusEffect(typeEffect, 20, 0, duration) == false then
        ability:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    target:updateClaim(player)
    player:removeAmmo()

    return typeEffect
end

xi.job_utils.dragoon.useDeepBreathing = function(player, target, ability)
   local wyvern = getWyvern(player)
   wyvern:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 0, 0, 180) -- Message when effect is lost is "Magic Attack boost wears off."
end

xi.job_utils.dragoon.useSpiritBond = function(player, target, ability)
    -- player:addStatusEffect(xi.effect.SPIRIT_BOND, 14, 0, 60) -- TODO: implement xi.effect.SPIRIT_BOND
end

xi.job_utils.dragoon.useSpiritJump = function(player, target, ability, action)
    local atkMultiplier = (player:getMod(xi.mod.JUMP_ATT_BONUS) + 100) / 100
    local params = getJumpWSParams(player, atkMultiplier, nil)
    local damage, totalHits = performWSJump(player, target, action, params)

    -- Reduce 99% of total accumulated enmity
    if target:isMob() then
        target:lowerEnmity(player, 99)
    end

    return damage
end

xi.job_utils.dragoon.useSoulJump = function(player, target, ability, action)
    local params = getJumpWSParams(player, 1, 0)
    local damage, totalHits = performWSJump(player, target, action, params)

    -- Reduce 99% of total accumulated enmity
    if target:isMob() then
        target:lowerEnmity(player, 99)
    end

    return damage
end

xi.job_utils.dragoon.useDragonBreaker = function(player, target, ability)
    player:addStatusEffect(xi.effect.DRAGON_BREAKER, 14, 0, 180)
end

xi.job_utils.dragoon.useFlyHigh = function(player, target, ability)
    player:addStatusEffect(xi.effect.FLY_HIGH, 14, 0, 30)
end
