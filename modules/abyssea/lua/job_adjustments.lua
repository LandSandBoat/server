-----------------------------------
-- Module: Job Adjustments (Abyssea Era)
-- Desc: Removes traits/abilities/effects that were added to jobs during the Abyssea era
-----------------------------------
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local m = Module:new('abyssea_job_adjustments')

-----------------------------------
-- Warrior
-----------------------------------

-- Warrior's Charge: Remove Triple Attack bonus
m:addOverride('xi.effects.warriors_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.DOUBLE_ATTACK, 100)
end)

-- Warrior's Charge: Apply merit recast reduction
m:addOverride('xi.job_utils.warrior.useWarriorsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.WARRIORS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.WARRIORS_CHARGE, { power = 1, duration = 60, origin = player })

    return xi.effect.WARRIORS_CHARGE
end)

-----------------------------------
-- White Mage
-----------------------------------

-- Martyr: Apply merit recast reduction, remove merit healing bonus
m:addOverride('xi.job_utils.white_mage.useMartyr', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.MARTYR) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local damageHP = math.floor(player:getHP() * 0.25)
    local healHP = damageHP * 2
    healHP = utils.clamp(healHP, 0, target:getMaxHP() - target:getHP())

    -- If stoneskin is present, it should absorb damage
    damageHP = utils.handleStoneskin(player, damageHP)
    player:delHP(damageHP)
    target:addHP(healHP)

    return healHP
end)

-- Devotion: Apply merit recast reduction, remove merit MP bonus
m:addOverride('xi.job_utils.white_mage.useDevotion', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DEVOTION) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local damageHP = math.floor(player:getHP() * 0.25)
    local healMP = damageHP
    healMP = utils.clamp(healMP, 0, target:getMaxMP() - target:getMP())

    -- If stoneskin is present, it should absorb damage
    damageHP = utils.handleStoneskin(player, damageHP)
    player:delHP(damageHP)
    target:addMP(healMP)

    return healMP
end)

-----------------------------------
-- Thief
-----------------------------------

-- Assassin's Charge: Remove Quadruple Attack
m:addOverride('xi.effects.assassins_charge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.TRIPLE_ATTACK, 100)
end)

-- Assassin's Charge: Reduce cooldown by merit count
m:addOverride('xi.job_utils.thief.useAssassinsCharge', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.ASSASSINS_CHARGE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.ASSASSINS_CHARGE, { power = 1, duration = 60, origin = player })

    return xi.effect.ASSASSINS_CHARGE
end)

-- Feint: Remove Treasure Hunter rate and reduce cooldown by merit count
m:addOverride('xi.job_utils.thief.useFeint', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.FEINT) - 120
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.FEINT, { power = 150, duration = 60, origin = player })
end)

-----------------------------------
-- Dark Knight
-----------------------------------

-- Arcane Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.job_utils.dark_knight.useArcaneCircle', function(player, target, ability)
    local duration = 60 + player:getMod(xi.mod.ARCANE_CIRCLE_DURATION)
    local power    = 15

    if player:getMainJob() ~= xi.job.DRK then
        power = 5
    end

    power = power + player:getMod(xi.mod.ARCANE_CIRCLE_POTENCY)

    target:addStatusEffect(xi.effect.ARCANE_CIRCLE, { power = power, duration = duration, origin = player })

    return xi.effect.ARCANE_CIRCLE
end)

-- Last Resort: Revert duration from 3 minutes to 30 seconds
m:addOverride('xi.job_utils.dark_knight.useLastResort', function(player, target, ability)
    player:addStatusEffect(xi.effect.LAST_RESORT, { duration = 30, origin = player })

    return xi.effect.LAST_RESORT
end)

-- Dark Seal: Remove extra duration and cast speed from merits
m:addOverride('xi.effects.dark_seal.onEffectGain',  function(target, effect)
    -- Overwrites
    target:delStatusEffectSilent(xi.effect.DIVINE_EMBLEM)
    target:delStatusEffectSilent(xi.effect.DIVINE_SEAL)
    target:delStatusEffectSilent(xi.effect.ELEMENTAL_SEAL)
end)

-- Dark Seal: Apply merit recast reduction
m:addOverride('xi.job_utils.dark_knight.useDarkSeal', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DARK_SEAL) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.DARK_SEAL, { power = 1, duration = 60, origin = player })

    return xi.effect.DARK_SEAL
end)

-- Diabolic Eye: Remove extra duration and potency from merits and apply merit recast reduction
m:addOverride('xi.job_utils.dark_knight.useDiabolicEye', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DIABOLIC_EYE) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.DIABOLIC_EYE, { power = 20, duration = 180, origin = player })

    return xi.effect.DIABOLIC_EYE
end)

-----------------------------------
-- Beastmaster
-----------------------------------

-- Reward: Override pet food healing values to pre-Abyssea values
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
xi.job_utils.beastmaster.petFoodData =
{
    [xi.item.PET_FOOD_ALPHA_BISCUIT]   = { minHealing =  25, regen =  1, mndMult = 2, mndThreshold = 10 },
    [xi.item.PET_FOOD_BETA_BISCUIT]    = { minHealing =  50, regen =  3, mndMult = 1, mndThreshold = 33 },
    [xi.item.PET_FOOD_GAMMA_BISCUIT]   = { minHealing = 100, regen =  5, mndMult = 1, mndThreshold = 35 },
    [xi.item.PET_FOOD_DELTA_BISCUIT]   = { minHealing = 150, regen =  8, mndMult = 2, mndThreshold = 40 },
    [xi.item.PET_FOOD_EPSILON_BISCUIT] = { minHealing = 300, regen = 11, mndMult = 2, mndThreshold = 45 },
    [xi.item.PET_FOOD_ZETA_BISCUIT]    = { minHealing = 350, regen = 14, mndMult = 3, mndThreshold = 45 },
}

-- Feral Howl: Apply merit recast reduction, remove extra accuracy from merits
m:addOverride('xi.job_utils.beastmaster.useFeralHowl', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.FERAL_HOWL) - 150
    action:setRecast(action:getRecast() - recastReduction)

    if
        not xi.data.statusEffect.isTargetImmune(target, xi.effect.TERROR, xi.element.DARK) and
        not xi.data.statusEffect.isTargetResistant(player, target, xi.effect.TERROR) and
        not xi.data.statusEffect.isEffectNullified(target, xi.effect.TERROR, 0)
    then
        local resistanceRate = xi.combat.magicHitRate.calculateResistRate(player, target, 0, 0, xi.skillRank.B_MINUS, xi.element.DARK, xi.mod.CHR, xi.effect.TERROR)

        if xi.data.statusEffect.isResistRateSuccessfull(xi.effect.TERROR, resistanceRate, 0) then
            target:addStatusEffect(xi.effect.TERROR, { power = 1, duration = 10 * resistanceRate, origin = player })
        end
    end

    return xi.effect.TERROR
end)

-- Killer Insinct: Apply merit recast reduction, remove extra duration from merits
m:addOverride('xi.job_utils.beastmaster.useKillerInstinct', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.KILLER_INSTINCT) - 150
    action:setRecast(action:getRecast() - recastReduction)

    -- Notes: Pet ecosystem is assigned to the subPower, then mapped to the correct killer mod in the effect script.
    local pet          = player:getPet()
    local petEcosystem = pet:getEcosystem()
    local power        = 10

    target:addStatusEffect(xi.effect.KILLER_INSTINCT, { power = power, duration = 60, origin = player, subPower = petEcosystem })

    return xi.effect.KILLER_INSTINCT
end)

-----------------------------------
-- Samurai
-----------------------------------

-- Warding Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.job_utils.samurai.useWardingCircle', function(player, target, ability)
    local duration = 60 + player:getMod(xi.mod.WARDING_CIRCLE_DURATION)
    local power    = 15

    if player:getMainJob() ~= xi.job.SAM then
        power = 5
    end

    power = power + player:getMod(xi.mod.WARDING_CIRCLE_POTENCY)

    target:addStatusEffect(xi.effect.WARDING_CIRCLE, { power = power, duration = duration, origin = player })

    return xi.effect.WARDING_CIRCLE
end)

-- Blade Bash: Apply merit recast reduction, remove extra plague duration from merits
m:addOverride('xi.job_utils.samurai.useBladeBash', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.BLADE_BASH) - 150
    action:setRecast(action:getRecast() - recastReduction)

    -- Damage
    -- TODO: Verify damage formula and DRK interaction
    local jobLevel = utils.getActiveJobLevel(player, xi.job.DRK)
    local damage   = math.floor((jobLevel + 11) / 4 + player:getMod(xi.mod.WEAPON_BASH))
    damage = utils.handleStoneskin(target, damage)
    target:takeDamage(damage, player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(player, damage)

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
            target:addStatusEffect(xi.effect.PLAGUE, { power = 5, duration = 15 * resistanceRate, origin = player })
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

    return damage
end)

-- Shikikoyo: Apply merit recast reduction, remove extra TP sharing from merits
m:addOverride('xi.job_utils.samurai.useShikikoyo', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.SHIKIKOYO) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local pTP = player:getTP() - 1000
    pTP       = utils.clamp(pTP, 0, 3000 - target:getTP())

    player:setTP(1000)
    target:setTP(target:getTP() + pTP)

    return pTP
end)

-- Hasso: Remove Zanshin bonus
m:addOverride('xi.effects.hasso.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.TWOHAND_STR, effect:getPower())
    effect:addMod(xi.mod.TWOHAND_HASTE_ABILITY, 1000)
    effect:addMod(xi.mod.TWOHAND_ACC, 10)
end)

-- Seigan: Remove Zanshin-based counter bonus
m:addOverride('xi.effects.seigan.onEffectGain', function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SEIGAN_EFFECT)

    effect:addMod(xi.mod.DEF, jpValue * 3)
end)

-----------------------------------
-- Ranger
-----------------------------------

-- Flashy Shot: Apply merit recast reduction
m:addOverride('xi.job_utils.ranger.useFlashyShot', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.FLASHY_SHOT) - 150
    action:setRecast(action:getRecast() - recastReduction)

    player:addStatusEffect(xi.effect.FLASHY_SHOT, { power = 1, duration = 60, origin = player })

    return xi.effect.FLASHY_SHOT
end)

-- Flashy Shot Effect: Add level correction bypass
m:addOverride('xi.effects.flashy_shot.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.ENMITY, 50)
    effect:addMod(xi.mod.RA_IGNORE_LVL_DIFF, 1)
end)

-----------------------------------
-- Dragoon
-----------------------------------

-- Ancient Circle: Revert duration from 3 minutes to 1 minute
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.job_utils.dragoon.useAncientCircle', function(player, target, ability)
    local duration = 60 + player:getMod(xi.mod.ANCIENT_CIRCLE_DURATION)
    local power    = 15

    if player:getMainJob() ~= xi.job.DRG then
        power = 5
    end

    power = power + player:getMod(xi.mod.ANCIENT_CIRCLE_POTENCY)

    ability:setMsg(xi.msg.basic.USES_ABILITY_FORTIFIED_DRAGONS)

    target:addStatusEffect(xi.effect.ANCIENT_CIRCLE, { power = power, duration = duration, origin = player })

    return xi.effect.ANCIENT_CIRCLE
end)

-- Spirit Surge: Revert haste to be HASTE_MAGIC instead of HASTE_ABILITY
-- Also removes ATK and DEF bonuses which are removed in SoA module
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.effects.spirit_surge.onEffectGain', function(target, effect)
    effect:addMod(xi.mod.HP, effect:getPower())
    target:updateHealth()

    effect:addMod(xi.mod.STR, effect:getSubPower())
    effect:addMod(xi.mod.ACC, 50)
    effect:addMod(xi.mod.HASTE_MAGIC, 2500)
    effect:addMod(xi.mod.MAIN_DMG_RATING, target:getJobPointLevel(xi.jp.SPIRIT_SURGE_EFFECT))
end)

-- Spirit Surge + Super Jump: Revert enmity reduction from 100% to 50%
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverride('xi.job_utils.dragoon.superJumpSurgeEffect', function(player, target)
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
end)

-- Deep Breathing: Apply merit recast reduction instead of breath power bonus
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverride('xi.job_utils.dragoon.useDeepBreathing', function(player, target, ability, action)
    local recastReduction = player:getMerit(xi.merit.DEEP_BREATHING) - 150
    action:setRecast(action:getRecast() - recastReduction)

    local wyvern = player:getPet()

    if wyvern and wyvern:getPetID() == xi.petId.WYVERN then
        wyvern:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, { duration = 180, origin = player })
    end
end)

-- Deep Breathing Bonus: Remove merit scaling, use flat base bonus only
m:addOverride('xi.job_utils.dragoon.getDeepBreathingBonus', function(wyvern, master, isHealing)
    local bonus = 0
    local hadEffect = wyvern:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST)

    if hadEffect then
        bonus = isHealing and 37.5 or 0.75

        wyvern:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    end

    return bonus
end)

-- Spirit Link: Revert TP transfer from wyvern to master and removes regen
-- TP Transfer Source: https://www.bg-wiki.com/ffxi/Version_Update_(06/21/2010)
-- Regen Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
m:addOverride('xi.job_utils.dragoon.useSpiritLink', function(player, target, ability, action)
    local wyvern      = player:getPet()
    local playerHP    = player:getHP()

    xi.job_utils.dragoon.checkForRemovableEffectsOnSpiritLink(player, wyvern)

    -- Empathy: copy status effects and grant wyvern EXP
    xi.job_utils.dragoon.applyEmpathyBonus(player, wyvern)

    -- Pre-Abyssea: No TP transfer from wyvern to master

    -- Calculate drain amount.
    local drainAmount = 0

    if wyvern:getHP() ~= wyvern:getMaxHP() then
        drainAmount = (math.random(25, 35) / 100) * playerHP
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
    player:takeDamage(drainAmount - stoneskinPower)

    -- Pre-September 2015: Healing formula includes MND and wyvern level components.
    -- Source: https://wiki.ffo.jp/html/1897.html https://www.bg-wiki.com/ffxi/Spirit_Link
    local playerMND = player:getStat(xi.mod.MND)
    local alpha     = wyvern:getMainLvl() * 0.7
    local healPet   = (drainAmount + playerMND + alpha) * 2

    if player:getEquipID(xi.slot.HEAD) == xi.item.DRACHEN_ARMET_P1 then
        healPet = healPet + 15
    end

    -- Spirit Link is self target but reports effect on Wyvern.
    action:ID(player:getID(), wyvern:getID())

    return wyvern:addHP(healPet) -- add the hp to wyvern
end)

-- Empathy: Revert Spirit Link granting wyvern 200 EXP per Empathy merit level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
m:addOverride('xi.job_utils.dragoon.applyEmpathyBonus', function(player, wyvern)
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
end)

-- Wyvern Spawn: Revert innate -40% DT and reduce status breath table
-- DT Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/19/2011)
-- Status Breath Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
m:addOverride('xi.pets.wyvern.onMobSpawn', function(mob)
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
end)

return m
