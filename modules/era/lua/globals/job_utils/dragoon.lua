-----------------------------------
-- Module: Dragoon Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_job_utils_dragoon')

-- Each override declares one implementation per era, keyed by xi.expansion.
-- A case applies when its content is disabled. The loader orders cases
-- newest era first, so the oldest applicable era ends up outermost and its
-- super chain reaches back through the newer reverts.

-- Healing Breath: Revert to consume TP and formula based on TP usage
-- Source: https://forum.square-enix.com/ffxi/threads/52969
m:addOverrideByEra('xi.job_utils.dragoon.useHealingBreath', {
    [xi.expansion.ROV] = function(wyvern, target, skill, action)
        local healingBreathTable =
        {
            --                                    { base, multiplier }
            [xi.jobAbility.HEALING_BREATH]     = {  8, 25 },
            [xi.jobAbility.HEALING_BREATH_II]  = { 24, 38 },
            [xi.jobAbility.HEALING_BREATH_III] = { 42, 45 },
            [xi.jobAbility.HEALING_BREATH_IV]  = { 60, 53 },
        }

        local master              = wyvern:getMaster()
        local deepMult            = xi.job_utils.dragoon.getDeepBreathingBonus(wyvern, master, true)
        local jobPointBonus       = master:getJobPointLevel(xi.jp.WYVERN_BREATH_EFFECT) * 10
        local breathAugmentsBonus = 1 + master:getMod(xi.mod.UNCAPPED_WYVERN_BREATH) / 100
        local gear                = master:getMod(xi.mod.WYVERN_BREATH) -- Master gear that enhances breath
        local base                = healingBreathTable[skill:getID()][1]
        local baseMultiplier      = healingBreathTable[skill:getID()][2]

        -- TP bonus: wyvern TP enhances healing multiplier
        local tpBonus = math.floor(wyvern:getTP() / 200) / 1.165

        -- gear cap of 64/256 in multiplier
        local multiplier      = (baseMultiplier + math.min(gear, 64) + math.floor(deepMult) + tpBonus) / 256
        local curePower       = math.floor(wyvern:getMaxHP() * multiplier) + base + jobPointBonus * breathAugmentsBonus
        local totalHPRestored = target:addHP(curePower)

        -- Consume wyvern TP after calculating breath power
        wyvern:setTP(0)

        skill:setMsg(xi.msg.basic.JA_RECOVERS_HP_2)

        -- Also cure the Wyvern if Spirit Bond is up
        if master:hasStatusEffect(xi.effect.SPIRIT_BOND) then
            local totalWyvernHPRestored = wyvern:addHP(curePower)

            action:addAdditionalTarget(wyvern:getID())
            action:setAnimation(wyvern:getID(), action:getAnimation(target:getID()))
            action:messageID(wyvern:getID(), xi.msg.basic.SELF_HEAL_SECONDARY)
            action:param(wyvern:getID(), totalWyvernHPRestored)
        end

        if master:getMod(xi.mod.ENHANCES_STRAFE) > 0 then
            local strafeTP = master:getMerit(xi.merit.STRAFE_EFFECT) * 50
            wyvern:addTP(strafeTP) -- add 50 TP per merit with augmented AF2 legs
        end

        return totalHPRestored
    end,
})

-- Elemental Breath: Revert to consume TP on breath usage
-- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
m:addOverrideByEra('xi.job_utils.dragoon.useDamageBreath', {
    [xi.expansion.ROV] = function(wyvern, target, skill, action, damageType)
        local result = super(wyvern, target, skill, action, damageType)

        wyvern:setTP(0)

        return result
    end,
})

m:addOverrideByEra('xi.job_utils.dragoon.useSpiritLink', {
    -- Spirit Link: Revert to pre-September 2015 HP cost and heal formula.
    -- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
    -- Formula taken from: https://wiki.ffo.jp/html/1897.html
    [xi.expansion.ROV] = function(player, target, ability, action)
        local wyvern      = player:getPet()
        local playerHP    = player:getHP()
        local petTP       = wyvern:getTP()
        local regenAmount = player:getMainLvl() / 3 -- level/3 tic regen

        xi.job_utils.dragoon.checkForRemovableEffectsOnSpiritLink(player, wyvern)

        -- Empathy: copy status effects and grant wyvern EXP
        xi.job_utils.dragoon.applyEmpathyBonus(player, wyvern)

        wyvern:addStatusEffect(xi.effect.REGEN, { power = regenAmount, duration = 90, origin = player, tick = 3 }) -- 90 seconds of regen
        player:addTP(petTP / 2) -- add half wyvern tp to you
        wyvern:delTP(petTP / 2) -- remove half tp from wyvern

        -- Calculate drain amount.
        local drainamount = 0

        if wyvern:getHP() ~= wyvern:getMaxHP() then
            drainamount = (math.randomInt(25, 35) / 100) * playerHP
            drainamount = drainamount * (1 - (0.01 * player:getJobPointLevel(xi.jp.SPIRIT_LINK_EFFECT)))
        end

        -- Handle Stoneskin.
        local stoneskinPower = 0

        if player:hasStatusEffect(xi.effect.STONESKIN) then
            stoneskinPower = player:getMod(xi.mod.STONESKIN)

            -- If stoneskin is more powerfull than the amount to be drained.
            if stoneskinPower > drainamount then
                local effect = player:getStatusEffect(xi.effect.STONESKIN)
                effect:setPower(effect:getPower() - drainamount) -- Fixes the status effect so when it ends it uses the new power instead of old.
                player:delMod(xi.mod.STONESKIN, drainamount)     -- Removes the amount from the mod.

            -- If stoneskin is as powerful or less than the amount to be drained.
            else
                player:delStatusEffect(xi.effect.STONESKIN)
            end
        end

        -- Handle master damage and pet healing.
        player:takeDamage(math.max(0, drainamount - stoneskinPower))

        local playerMND = player:getStat(xi.mod.MND)
        local alpha     = math.floor(wyvern:getMainLvl() * 0.7)
        local healPet   = (drainamount + playerMND + alpha) * 2

        if player:getEquipID(xi.slot.HEAD) == xi.item.DRACHEN_ARMET_P1 then
            healPet = healPet + 10
        end

        -- Spirit Link is self target but reports effect on Wyvern.
        action:ID(player:getID(), wyvern:getID())

        return wyvern:addHP(healPet) -- add the hp to wyvern
    end,

    -- Spirit Link: Revert TP transfer from wyvern to master, regen, and doubled heal
    -- TP Transfer Source: https://www.bg-wiki.com/ffxi/Version_Update_(06/21/2010)
    -- Heal Doubling Source: https://forum.square-enix.com/ffxi/threads/20744
    -- Regen Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
    [xi.expansion.ABYSSEA] = function(player, target, ability, action)
        local wyvern      = player:getPet()
        local playerHP    = player:getHP()

        xi.job_utils.dragoon.checkForRemovableEffectsOnSpiritLink(player, wyvern)

        -- Empathy: copy status effects and grant wyvern EXP
        xi.job_utils.dragoon.applyEmpathyBonus(player, wyvern)

        -- Pre-Abyssea: No TP transfer from wyvern to master

        -- Calculate drain amount.
        local drainAmount = 0

        if wyvern:getHP() ~= wyvern:getMaxHP() then
            drainAmount = (math.randomInt(25, 35) / 100) * playerHP
            drainAmount = drainAmount * (1 - (0.01 * player:getJobPointLevel(xi.jp.SPIRIT_LINK_EFFECT)))
        end

        -- Handle Stoneskin.
        local stoneskinPower = 0

        if player:hasStatusEffect(xi.effect.STONESKIN) then
            stoneskinPower = player:getMod(xi.mod.STONESKIN)

            -- If stoneskin is more powerfull than the amount to be drained.
            if stoneskinPower > drainAmount then
                local effect = player:getStatusEffect(xi.effect.STONESKIN)
                effect:setPower(effect:getPower() - drainAmount) -- Fixes the status effect so when it ends it uses the new power instead of old.
                player:delMod(xi.mod.STONESKIN, drainAmount)     -- Removes the amount from the mod.

            -- If stoneskin is as powerful or less than the amount to be drained.
            else
                player:delStatusEffect(xi.effect.STONESKIN)
            end
        end

        -- Handle master damage and pet healing.
        player:takeDamage(math.max(0, drainAmount - stoneskinPower))

        -- Pre-February 2012: Heal is not doubled.
        -- Source: https://wiki.ffo.jp/html/1897.html
        local playerMND = player:getStat(xi.mod.MND)
        local alpha     = math.floor(wyvern:getMainLvl() * 0.7)
        local healPet   = drainAmount + playerMND + alpha

        if player:getEquipID(xi.slot.HEAD) == xi.item.DRACHEN_ARMET_P1 then
            healPet = healPet + 10
        end

        -- Spirit Link is self target but reports effect on Wyvern.
        action:ID(player:getID(), wyvern:getID())

        return wyvern:addHP(healPet) -- add the hp to wyvern
    end,
})

m:addOverrideByEra('xi.job_utils.dragoon.addWyvernExp', {
    -- Wyvern EXP: Revert WS Damage bonus from wyvern level-ups
    -- Source: https://forum.square-enix.com/ffxi/threads/55997-October.-10-2019-%28JST%29-Version-Update
    [xi.expansion.ROV] = function(player, exp)
        local wyvern      = player:getPet()
        local prevExp     = wyvern:getLocalVar('wyvern_exp')
        local numLevelUps = 0

        if prevExp < 1000 then
            local currentExp = exp
            if prevExp + currentExp > 1000 then
                currentExp = 1000 - prevExp
            end

            numLevelUps = math.floor((prevExp + currentExp) / 200) - math.floor(prevExp / 200)

            if numLevelUps ~= 0 then
                local wyvernAttributeIncreaseEffectJP = player:getJobPointLevel(xi.jp.WYVERN_ATTR_BONUS)
                local wyvernBonusDA = player:getMod(xi.mod.WYVERN_ATTRIBUTE_DA)

                wyvern:addMod(xi.mod.ACC, 6 * numLevelUps)
                wyvern:addMod(xi.mod.HPP, 6 * numLevelUps)
                wyvern:addMod(xi.mod.ATTP, 5 * numLevelUps)

                wyvern:updateHealth()
                wyvern:setHP(wyvern:getMaxHP())

                player:messageBasic(xi.msg.basic.STATUS_INCREASED, 0, 0, wyvern)

                player:addMod(xi.mod.ATT, wyvernAttributeIncreaseEffectJP * numLevelUps)
                player:addMod(xi.mod.DEF, wyvernAttributeIncreaseEffectJP * numLevelUps)
                player:addMod(xi.mod.ATTP, 4 * numLevelUps)
                player:addMod(xi.mod.DEFP, 4 * numLevelUps)
                player:addMod(xi.mod.HASTE_ABILITY, 200 * numLevelUps)
                player:addMod(xi.mod.DOUBLE_ATTACK, wyvernBonusDA * numLevelUps)
            end

            wyvern:setLocalVar('wyvern_exp', prevExp + exp)
            wyvern:setLocalVar('level_Ups', wyvern:getLocalVar('level_Ups') + numLevelUps)
        end

        return numLevelUps
    end,

    -- Wyvern Levelup: Remove player stat transfers from wyvern levelups
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
    [xi.expansion.SOA] = function(player, exp)
        local wyvern      = player:getPet()
        local prevExp     = wyvern:getLocalVar('wyvern_exp')
        local numLevelUps = 0

        if prevExp < 1000 then
            -- cap exp at 1000 to prevent wyvern leveling up many times from large exp awards
            local currentExp = exp
            if prevExp + currentExp > 1000 then
                currentExp = 1000 - prevExp
            end

            numLevelUps = math.floor((prevExp + currentExp) / 200) - math.floor(prevExp / 200)

            if numLevelUps ~= 0 then
                wyvern:addMod(xi.mod.ACC, 6 * numLevelUps)
                wyvern:addMod(xi.mod.HPP, 6 * numLevelUps)
                wyvern:addMod(xi.mod.ATTP, 5 * numLevelUps)

                wyvern:updateHealth()
                wyvern:setHP(wyvern:getMaxHP())

                player:messageBasic(xi.msg.basic.STATUS_INCREASED, 0, 0, wyvern)
            end

            wyvern:setLocalVar('wyvern_exp', prevExp + exp)
            wyvern:setLocalVar('level_Ups', wyvern:getLocalVar('level_Ups') + numLevelUps)
        end

        return numLevelUps
    end,

    -- Wyvern: Revert experience points Wyvern system
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/11/2008)
    [xi.expansion.WOTG] = function(player, exp)
        return 0
    end,
})

-- Wyvern Level Removal: Match addWyvernExp by omitting ALL_WSDMG_ALL_HITS
m:addOverrideByEra('xi.pets.wyvern.removeWyvernLevels', {
    [xi.expansion.ROV] = function(mob)
        local master  = mob:getMaster()
        local numLvls = mob:getLocalVar('level_Ups')

        if numLvls ~= 0 then
            local wyvernAttributeIncreaseEffectJP = master:getJobPointLevel(xi.jp.WYVERN_ATTR_BONUS)
            local wyvernBonusDA = master:getMod(xi.mod.WYVERN_ATTRIBUTE_DA)

            master:delMod(xi.mod.ATT, wyvernAttributeIncreaseEffectJP * numLvls)
            master:delMod(xi.mod.DEF, wyvernAttributeIncreaseEffectJP * numLvls)
            master:delMod(xi.mod.ATTP, 4 * numLvls)
            master:delMod(xi.mod.DEFP, 4 * numLvls)
            master:delMod(xi.mod.HASTE_ABILITY, 200 * numLvls)
            master:delMod(xi.mod.DOUBLE_ATTACK, wyvernBonusDA * numLvls)
        end
    end,
})

m:addOverrideByEra('xi.effects.spirit_surge.onEffectGain', {
    -- Spirit Surge: Removes ATK and DEF bonuses
    -- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-%28JST%29-Version-Update
    [xi.expansion.SOA] = function(target, effect)
        effect:addMod(xi.mod.HP, effect:getPower())
        target:updateHealth()

        effect:addMod(xi.mod.STR, effect:getSubPower())
        effect:addMod(xi.mod.ACC, 50)
        effect:addMod(xi.mod.HASTE_ABILITY, 2500)
        effect:addMod(xi.mod.MAIN_DMG_RATING, target:getJobPointLevel(xi.jp.SPIRIT_SURGE_EFFECT))
    end,

    -- Spirit Surge: Revert haste to be HASTE_MAGIC instead of HASTE_ABILITY
    -- Also removes ATK and DEF bonuses which are removed in SoA case
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
    [xi.expansion.ABYSSEA] = function(target, effect)
        effect:addMod(xi.mod.HP, effect:getPower())
        target:updateHealth()

        effect:addMod(xi.mod.STR, effect:getSubPower())
        effect:addMod(xi.mod.ACC, 50)
        effect:addMod(xi.mod.HASTE_MAGIC, 2500)
        effect:addMod(xi.mod.MAIN_DMG_RATING, target:getJobPointLevel(xi.jp.SPIRIT_SURGE_EFFECT))
    end,
})

m:addOverrideByEra('xi.pets.wyvern.onMobSpawn', {
    -- Wyvern Breath: Show readying animation to match the reverted 3-second prepare time
    -- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-%28JST%29-Version-Update
    [xi.expansion.SOA] = function(mob)
        super(mob)

        mob:addMod(xi.mod.WYVERN_SHOW_READYING, 1)
    end,

    -- Wyvern Spawn: Revert innate -40% DT and reduce status breath table
    -- DT Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/19/2011)
    -- Status Breath Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
    [xi.expansion.ABYSSEA] = function(mob)
        super(mob)

        local master = mob:getMaster()

        -- Revert innate -40% DT
        mob:addMod(xi.mod.DMG, 4000)

        -- Determine if wyvern is DEFENSIVE type (status breath on WS)
        local defensiveJobs =
        {
            [xi.job.WHM] = true,
            [xi.job.BLM] = true,
            [xi.job.RDM] = true,
            [xi.job.SMN] = true,
            [xi.job.BLU] = true,
            [xi.job.SCH] = true,
            [xi.job.GEO] = true,
        }

        if defensiveJobs[master:getSubJob()] then
            -- Replace WS listener with pre-2012 status breath table
            master:removeListener('PET_WYVERN_WS')

            local removeBreathTable =
            {
                { 40, xi.jobAbility.REMOVE_PARALYSIS, { xi.effect.PARALYSIS } },
                { 20, xi.jobAbility.REMOVE_BLINDNESS, { xi.effect.BLINDNESS } },
                {  1, xi.jobAbility.REMOVE_POISON,    { xi.effect.POISON    } },
            }

            local breathRange = 14

            local function doStatusBreath(target, player)
                local wyvern = player:getPet()

                for _, v in pairs(removeBreathTable) do
                    local minLevel = v[1]
                    local ability  = v[2]
                    local statuses = v[3]

                    if wyvern:getMainLvl() >= minLevel then
                        for _, effect in pairs(statuses) do
                            if
                                target:hasStatusEffect(effect) and
                                wyvern:checkDistance(target) <= breathRange
                            then
                                wyvern:usePetAbility(ability, target)

                                return true
                            end
                        end
                    end
                end

                return false
            end

            master:addListener('WEAPONSKILL_USE', 'PET_WYVERN_WS', function(player, target, skillid)
                if not doStatusBreath(player, player) then
                    local party = player:getParty()
                    for _, member in pairs(party) do
                        if doStatusBreath(member, player) then
                            break
                        end
                    end
                end
            end)
        end
    end,

    -- Wyvern Spawn: Remove EXPERIENCE_POINTS listener that feeds wyvern EXP system
    [xi.expansion.WOTG] = function(mob)
        super(mob)

        local master = mob:getMaster()
        master:removeListener('PET_WYVERN_EXP')
    end,
})

-- Ancient Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverrideByEra('xi.job_utils.dragoon.useAncientCircle', {
    [xi.expansion.ABYSSEA] = function(player, target, ability)
        local duration = 60 + player:getMod(xi.mod.ANCIENT_CIRCLE_DURATION)
        local power    = 15

        if player:getMainJob() ~= xi.job.DRG then
            power = 5
        end

        power = power + player:getMod(xi.mod.ANCIENT_CIRCLE_POTENCY)

        ability:setMsg(xi.msg.basic.USES_ABILITY_FORTIFIED_DRAGONS)

        target:addStatusEffect(xi.effect.ANCIENT_CIRCLE, { power = power, duration = duration, origin = player })

        return xi.effect.ANCIENT_CIRCLE
    end,
})

-- Spirit Surge + Super Jump: Revert enmity reduction from 100% to 50%
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverrideByEra('xi.job_utils.dragoon.superJumpSurgeEffect', {
    [xi.expansion.ABYSSEA] = function(player, target)
        if player:hasStatusEffect(xi.effect.SPIRIT_SURGE) then
            local minDistance = 9999
            local closestPartyMember = nil

            -- Find the closest party member
            local party = player:getPartyWithTrusts()
            for _, member in pairs(party) do
                local distance = member:checkDistance(player)
                if
                    member:getID() ~= player:getID() and
                    not member:isDead() and
                    (distance < minDistance or closestPartyMember == nil)
                then
                    closestPartyMember = member
                    minDistance = distance
                end
            end

            -- TODO: verify conditions for how close the dragoon needs to be to the mob, if at all
            if
                closestPartyMember and
                closestPartyMember:isBehind(player) and
                (player:checkDistance(target) < closestPartyMember:checkDistance(target))
            then
                if target:isMob() then
                    target:lowerEnmity(closestPartyMember, 50)
                end
            end
        end
    end,
})

-- Deep Breathing: Apply merit recast reduction instead of breath power bonus
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverrideByEra('xi.job_utils.dragoon.useDeepBreathing', {
    [xi.expansion.ABYSSEA] = function(player, target, ability, action)
        local recastReduction = player:getMerit(xi.merit.DEEP_BREATHING) - 150
        action:setRecast(action:getRecast() - recastReduction)

        local wyvern = player:getPet()

        if wyvern and wyvern:getPetID() == xi.petId.WYVERN then
            wyvern:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, { duration = 180, origin = player })
        end
    end,
})

-- Deep Breathing Bonus: Remove merit scaling, use flat base bonus only
m:addOverrideByEra('xi.job_utils.dragoon.getDeepBreathingBonus', {
    [xi.expansion.ABYSSEA] = function(wyvern, master, isHealing)
        local bonus = 0
        local hadEffect = wyvern:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST)

        if hadEffect then
            bonus = isHealing and 37.5 or 0.75

            wyvern:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
        end

        return bonus
    end,
})

-- Empathy: Revert Spirit Link granting wyvern 200 EXP per Empathy merit level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
m:addOverrideByEra('xi.job_utils.dragoon.applyEmpathyBonus', {
    [xi.expansion.ABYSSEA] = function(player, wyvern)
        local empathyTotal = player:getMerit(xi.merit.EMPATHY)

        if empathyTotal > 0 then
            local validEffects = {}
            local i            = 0
            local effects      = player:getStatusEffects()
            local copyi        = 0

            for _, effect in pairs(effects) do
                if effect:hasEffectFlag(xi.effectFlag.EMPATHY) then
                    validEffects[i + 1] = effect
                    i = i + 1
                end
            end

            if i < empathyTotal then
                empathyTotal = i
            elseif i > empathyTotal then
                validEffects = xi.job_utils.dragoon.cutEmpathyEffectTable(validEffects, i, empathyTotal)
            end

            local copyEffect = nil
            while copyi < empathyTotal do
                copyEffect = validEffects[copyi + 1]
                if wyvern:hasStatusEffect(copyEffect:getEffectType()) then
                    wyvern:delStatusEffectSilent(copyEffect:getEffectType())
                end

                wyvern:copyStatusEffect(copyEffect)
                copyi = copyi + 1
            end
        end
    end,
})
