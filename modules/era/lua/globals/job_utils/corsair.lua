-----------------------------------
-- Module: Corsair Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_corsair'
local m = Module:new(moduleName)

-----------------------------------
-- Rhapsodies of Vana'diel Era
-----------------------------------

if not xi.module.isContentEnabled('ROV') then
    -- Beast Roll: Remove pet ranged attack
    -- Source: https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
    m:addOverride('xi.effects.beast_roll.onEffectGain', function(target, effect)
        target:addPetMod(xi.mod.ATTP, effect:getPower())
    end)

    m:addOverride('xi.effects.beast_roll.onEffectLose', function(target, effect)
        target:delPetMod(xi.mod.ATTP, effect:getPower())
        xi.job_utils.corsair.onRollEffectLose(target, effect)
    end)
end

-----------------------------------
-- Seekers of Adoulin Era
-----------------------------------
if not xi.module.isContentEnabled('SOA') then
    -- Phantom Roll powers and bonus changed in the SoA era
    -- Source: https://forum.square-enix.com/ffxi/threads/41814-May-15-2014-%28JST%29-Version-Update
    local soaRollData =
    {
        [xi.jobAbility.NINJA_ROLL] =
        {
            powers = { 4, 6,  8, 25, 10, 12, 14, 2, 17, 20, 30, 8 },
            bonus  = 10,
        },

        [xi.jobAbility.WIZARDS_ROLL] =
        {
            powers = { 2, 3,  4,  4, 10,  5,  6, 7,  1,  7, 12, 4 },
            bonus  = 4,
        },

        [xi.jobAbility.DANCERS_ROLL] =
        {
            powers = { 3, 4, 11,  4,  5,  6,  1, 7,  8,  8, 14, 3 },
            bonus  = 3,
        },
    }

    do
        local rollModData = xi.job_utils.corsair.rollData

        for abilityId, data in pairs(soaRollData) do
            local rollInfo  = rollModData[abilityId]
            rollInfo.powers = data.powers
            rollInfo.bonus  = data.bonus
        end
    end
end

-----------------------------------
-- Abyssea Era
-----------------------------------
if not xi.module.isContentEnabled('ABYSSEA') then
    -- Phantom Roll powers and bonuses differ before the Abyssea era.
    -- Source: https://forum.square-enix.com/ffxi/threads/20744?p=278735#post278735
    local abysseaRollData =
    {
        [xi.jobAbility.WARLOCKS_ROLL] =
        {
            powers = {  2,  3,  4, 10,  4,  5,  6,  1,  7,  7, 12,  4 },
            bonus  = 4,
        },

        [xi.jobAbility.BEAST_ROLL] =
        {
            powers = {  5,  6,  7, 19,  8,  9, 12,  2, 13, 14, 23,  8 },
            bonus  = 8,
        },

        [xi.jobAbility.CHORAL_ROLL] =
        {
            powers = {  4, 17,  5,  6,  7,  2,  8, 10, 11, 12, 21,  8 },
            bonus  = 8,
        },

        [xi.jobAbility.DANCERS_ROLL] =
        {
            powers = {  3,  4, 11,  4,  5,  6,  1,  7,  8,  8, 14,  3 },
            bonus  = 3,
        },

        [xi.jobAbility.HEALERS_ROLL] =
        {
            powers = {  2,  3, 10,  4,  4,  5,  1,  6,  7,  7, 12,  3 },
            bonus  = 3,
        },

        [xi.jobAbility.GALLANTS_ROLL] =
        {
            powers = {  4,  5, 15,  6,  7,  8,  3,  9, 10, 12, 20, 10 },
            bonus  = 10,
        },

        [xi.jobAbility.DRACHEN_ROLL] =
        {
            powers = {  4,  5, 18,  7,  9, 10,  2, 11, 13, 15, 22,  8 },
            bonus  = 8,
        },

        [xi.jobAbility.PUPPET_ROLL] =
        {
            powers = { 10, 13, 15, 40, 18, 20, 25,  5, 28, 30, 50, 15 },
            bonus  = 15,
        },
    }

    do
        local rollData = xi.job_utils.corsair.rollData

        for abilityId, data in pairs(abysseaRollData) do
            local rollInfo  = rollData[abilityId]
            rollInfo.powers = data.powers
            rollInfo.bonus  = data.bonus
        end
    end

    -- Healer's Roll: Revert from Cure potency bonus to MP heal bonus
    m:addOverride('xi.effects.healers_roll.onEffectGain', function(target, effect)
        effect:addMod(xi.mod.MPHEAL, effect:getPower())
    end)

    -- Gallant's Roll: Revert to proportional damage reflection relative to damage taken.
    m:addOverride('xi.effects.gallants_roll.onEffectGain', function(target, effect)
        effect:addMod(xi.mod.SPIKES, xi.subEffect.BLAZE_SPIKES)
        target:addListener('TAKE_DAMAGE', 'GALLANTS_ROLL_REFLECT', function(entity, amount, attacker, attackType, damageType)
            if
                amount > 0 and
                attackType == xi.attackType.PHYSICAL
            then
                entity:setMod(xi.mod.SPIKES_DMG, math.floor(amount * effect:getPower() / 100))
            end
        end)
    end)

    m:addOverride('xi.effects.gallants_roll.onEffectLose', function(target, effect)
        target:removeListener('GALLANTS_ROLL_REFLECT')
        target:setMod(xi.mod.SPIKES_DMG, 0)
        super(target, effect)
    end)

    -- Drachen Roll: Revert from Pet Accuracy bonus to Pet Magic Acc/Attack bonus
    m:addOverride('xi.effects.drachen_roll.onEffectGain', function(target, effect)
        target:addPetMod(xi.mod.MATT, effect:getPower())
        target:addPetMod(xi.mod.MACC, effect:getPower())
    end)

    m:addOverride('xi.effects.drachen_roll.onEffectLose', function(target, effect)
        target:delPetMod(xi.mod.MATT, effect:getPower())
        target:delPetMod(xi.mod.MACC, effect:getPower())
        xi.job_utils.corsair.onRollEffectLose(target, effect)
    end)

    -- Puppet Roll: Revert from Pet Magic Acc/Attack bonus to Pet Accuracy bonus
    m:addOverride('xi.effects.puppet_roll.onEffectGain', function(target, effect)
        target:addPetMod(xi.mod.ACC, effect:getPower())
        target:addPetMod(xi.mod.RACC, effect:getPower())
    end)

    m:addOverride('xi.effects.puppet_roll.onEffectLose', function(target, effect)
        target:delPetMod(xi.mod.ACC, effect:getPower())
        target:delPetMod(xi.mod.RACC, effect:getPower())
        xi.job_utils.corsair.onRollEffectLose(target, effect)
    end)

    -- Light Shot / Dark Shot: Revert Dia and Bio subpower baselines to pre-April-2019 values (5/10/15 instead of 10/15/20).
    -- Source: https://forum.square-enix.com/ffxi/threads/55263-April.-3-2019-%28JST%29-Version-Update
    local diaBasePowerByTier = xi.job_utils.corsair.quickDrawEffectBoostTable[xi.jobAbility.LIGHT_SHOT][1].basePowerByTier
    diaBasePowerByTier[1] = 5
    diaBasePowerByTier[3] = 10
    diaBasePowerByTier[5] = 15

    local bioBasePowerByTier = xi.job_utils.corsair.quickDrawEffectBoostTable[xi.jobAbility.DARK_SHOT][1].basePowerByTier
    bioBasePowerByTier[2] = 5
    bioBasePowerByTier[4] = 10
    bioBasePowerByTier[6] = 15

    -- Phantom Roll XI bonus: Reverts various bonuses added to rolling and having an XI effect active
    -- - Disable reduced recast while an XI is active.
    -- - Disable bust effect prevention while an XI is active.
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
    m:addOverride('xi.job_utils.corsair.checkForElevenRoll', function(caster)
        return false
    end)

    -- - Disable Phantom Roll recast reset when landing on XI via Double-Up.
    m:addOverride('xi.job_utils.corsair.useDoubleUp', function(caster, target, ability, action)
        if caster:getID() == target:getID() then -- the COR handles all the calculations
            local duEffect = caster:getStatusEffect(xi.effect.DOUBLE_UP_CHANCE)
            local prevRoll = caster:getStatusEffect(duEffect:getSubPower())
            local roll     = prevRoll:getSubPower()
            local job      = duEffect:getTier()

            caster:setLocalVar('corsairActiveRoll', duEffect:getSourceTypeParam())

            local snakeEye = caster:getStatusEffect(xi.effect.SNAKE_EYE)

            if snakeEye then
                if roll >= 5 and math.randomInt(1, 100) < snakeEye:getPower() then
                    roll = 11
                else
                    roll = roll + 1
                end

                caster:delStatusEffect(xi.effect.SNAKE_EYE)
            else
                roll = roll + math.randomInt(1, 6)
            end

            if roll >= 12 then -- bust
                roll = 12
                caster:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)
            end

            caster:setLocalVar('corsairRollTotal', roll)
            action:info(caster:getID(), roll - prevRoll:getSubPower())
            xi.job_utils.corsair.checkForJobBonus(caster, job)
        end

        local total       = caster:getLocalVar('corsairRollTotal')
        local activeRoll  = caster:getLocalVar('corsairActiveRoll')
        local prevAbility = GetAbility(activeRoll)

        if prevAbility then -- Apply rolls to target(s), including the COR
            action:actionID(prevAbility:getID())

            total = xi.job_utils.corsair.applyRoll(caster, target, prevAbility, total, true, ability)

            if total > 11 then
                action:setAnimation(target:getID(), 98) -- 98 is bust anim for all rolls
            else
                action:setAnimation(target:getID(), prevAbility:getAnimation())
            end

            return total
        end
    end)

    -- Snake Eye: Revert to cooldown reduction from merit points, remove bonus free XI effect.
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
    -- Merit value is set to 150s/level by modules/abyssea/sql/job_adjustments.sql
    m:addOverride('xi.job_utils.corsair.useSnakeEye', function(player, action)
        local recastReduction = player:getMerit(xi.merit.SNAKE_EYE) - 150
        action:setRecast(action:getRecast() - recastReduction)

        player:addStatusEffect(xi.effect.SNAKE_EYE, { power = 0, duration = 60, origin = player })

        return xi.effect.SNAKE_EYE
    end)

    -- Fold: Revert to cooldown reduction from merit points, remove bonus phantom roll reset.
    m:addOverride('xi.job_utils.corsair.useFold', function(player, action)
        local sourceId   = player:getID()
        local newestBust = nil
        local newestRoll = nil
        local bustExpiry = 0
        local rollExpiry = 0

        for _, effect in pairs(player:getStatusEffects()) do
            local effectType = effect:getEffectType()
            local expiry     = effect:getStartTime() + effect:getDuration() / 1000

            if
                effectType == xi.effect.BUST and
                (newestBust == nil or expiry > bustExpiry)
            then
                newestBust = effect
                bustExpiry = expiry
            elseif
                effect:hasEffectFlag(xi.effectFlag.ROLL) and
                effect:getSourceTypeParam() == sourceId and
                (newestRoll == nil or expiry > rollExpiry)
            then
                newestRoll = effect
                rollExpiry = expiry
            end
        end

        local selected = newestBust or newestRoll

        if selected ~= nil then
            player:delStatusEffect(selected:getEffectType())
            player:delStatusEffectSilent(xi.effect.DOUBLE_UP_CHANCE)

            -- Merit value is set to 150s/level by modules/abyssea/sql/job_adjustments.sql
            local recastReduction = player:getMerit(xi.merit.FOLD) - 150
            action:setRecast(action:getRecast() - recastReduction)
        end
    end)

    -- Elemental Shot: Revert TP gain and Marksmanship skillup added to Quick Draw.
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
    m:addOverride('xi.job_utils.corsair.useElementalShot', function(actor, target, ability, action)
        local abilityId = ability:getID()

        -- Fetch specific ability data.
        local data = xi.job_utils.corsair.quickDrawDataTable[abilityId]
        if not data then
            return
        end

        -- Handle card consumption.
        if not actor:delItem(data.cardAmmo, 1) then
            actor:delItem(xi.item.TRUMP_CARD, 1)
        end

        -- Handle recast.
        action:setRecast(math.max(0, action:getRecast() - actor:getMod(xi.mod.QUICK_DRAW_RECAST)))

        -- Handle claim.
        target:updateClaim(actor)

        -- Calculate resist rate.
        local bonusAcc = actor:getMerit(xi.merit.QUICK_DRAW_ACCURACY) + actor:getMod(xi.mod.QUICK_DRAW_MACC)
        local resist   = xi.combat.magicHitRate.calculateResistRate(actor, target, 0, xi.skill.MARKSMANSHIP, 0,  data.element, xi.mod.AGI, 0, bonusAcc)

        -- Handle damage.
        local damage = 0
        if data.canDamage then
            damage = xi.job_utils.corsair.handleQuickDrawDamage(actor, target, action, data.element, resist)
        end

        -- Handle effect boost.
        xi.job_utils.corsair.handleQuickDrawEffectBoost(actor, target, abilityId, data.multiplier)

        -- Handle effect application.
        if data.applyEffectId > 0 then
            if
                xi.data.statusEffect.isTargetImmune(target, data.applyEffectId, data.element) or
                xi.data.statusEffect.isTargetResistant(actor, target, data.applyEffectId) or
                not xi.data.statusEffect.isResistRateSuccessfull(data.applyEffectId, resist, 0)
            then
                ability:setMsg(xi.msg.basic.JA_MISS_2)
                return data.applyEffectId
            end

            -- Light shot.
            if data.applyEffectId == xi.effect.SLEEP_I then
                if target:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = math.floor(90 * resist), subPower = data.element, origin = actor }) then
                    ability:setMsg(xi.msg.basic.JA_ENFEEB_IS)
                else
                    ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
                end

                return xi.effect.SLEEP_I

            -- Dark shot.
            else
                ability:setMsg(xi.msg.basic.JA_REMOVE_EFFECT_2)

                local dispelledEffect = target:dispelStatusEffect()
                if dispelledEffect == xi.effect.NONE then
                    ability:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
                end

                return dispelledEffect
            end
        end

        return damage
    end)
end

if #m.overrides > 0 then
    return m
end

return { name = moduleName }
