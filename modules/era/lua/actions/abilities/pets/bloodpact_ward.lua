-----------------------------------
-- Module: Blood Pact: Ward era adjustments
-- Reverts the doubled duration of wards and increased duration based on summoning magic skill over cap
-- Source: http://www.playonline.com/pcd/update/ff11us/20061017UJ0a71/detail.html
--         https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
-- Notes : https://wiki.ffo.jp/html/14112.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_bloodpact_ward')

-----------------------------------
-- Shining Ruby
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.shining_ruby.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        -- TODO: BGWiki says this shares a buff slot with Rampart, Winds Blessing and One For All.
        -- Need to capture tier priority.
        -- https://www.bg-wiki.com/ffxi/Shining_Ruby
        if target:hasStatusEffect(xi.effect.SHINING_RUBY) then
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT)

            return xi.effect.SHINING_RUBY
        end

        local baseDuration = 180

        target:addStatusEffect(xi.effect.SHINING_RUBY, { power = 10, subPower = 390, duration = duration, origin = pet })

        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end

        return xi.effect.SHINING_RUBY
    end,
})

-----------------------------------
-- Hastega
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.hastega.onPetAbility', {
    -- Reverts doubled base duration
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local baseDuration = 90
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet) * 3
        local duration     = math.min(baseDuration + bonusTime, 180)

        -- Old Notes:
        -- Garuda's Hastega is a weird exception and uses 153/1024 instead of 150/1024 like Haste spell
        -- That's why it overwrites some things regular haste won't. 153/1024 ~14.94%

        -- Note from retail capture: WHM Haste spell and Garuda's Hastega will overwrite eachother.
        if target:addStatusEffect(xi.effect.HASTE, { power = 1494, duration = duration, origin = pet }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            return
        end

        return xi.effect.HASTE
    end,

    -- Reverts doubled base duration and Slow overwrites the Haste tier
    -- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
    [xi.expansion.WOTG] = function(target, pet, petskill, summoner, action)
        local baseDuration = 90
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet) * 3
        local duration     = math.min(baseDuration + bonusTime, 180)

        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        if target:addStatusEffect(xi.effect.HASTE, { power = 1494, duration = duration, origin = pet, tier = 1 }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            return
        end

        return xi.effect.HASTE
    end,
})

-----------------------------------
-- Crimson Howl
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.crimson_howl.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local baseDuration = 30
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet)
        local duration     = math.min(baseDuration + bonusTime, 180)
        local power        = (math.floor((pet:getMainLvl() / 4) + 4.75) / 256) * 100

        if target:addStatusEffect(xi.effect.WARCRY, { power = power, duration = duration, origin = pet }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            return
        end

        return xi.effect.WARCRY
    end,
})

-----------------------------------
-- Frost Armor
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.frost_armor.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        -- TODO: JPWiki says this will overwrite Reprisal. Possibly other spike effects.
        target:delStatusEffect(xi.effect.ICE_SPIKES)

        local baseDuration = 90
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet) * 3
        local duration     = math.min(baseDuration + bonusTime, 180)

        -- TODO: Does power ever scale?
        if target:addStatusEffect(xi.effect.ICE_SPIKES, { power = 15, duration = duration, origin = pet }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            return
        end

        return xi.effect.ICE_SPIKES
    end,
})

-----------------------------------
-- Glittering Ruby
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.glittering_ruby.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        -- Randomly gives STR/DEX/VIT/AGI/INT/MND/CHR
        -- Can overwrite an existing Glittering Ruby effect
        local effects =
        {
            xi.effect.STR_BOOST,
            xi.effect.DEX_BOOST,
            xi.effect.VIT_BOOST,
            xi.effect.AGI_BOOST,
            xi.effect.INT_BOOST,
            xi.effect.MND_BOOST,
            xi.effect.CHR_BOOST,
        }

        local effectId     = utils.randomEntry(effects)
        local effectPower  = 3 + math.floor(pet:getMainLvl() / 5)
        local baseDuration = 90
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet) * 3
        local duration     = math.min(baseDuration + bonusTime, 180)

        -- TODO: Ecliptic Growl does not overwrite this.
        -- This does not overwrite Ecliptic Growl.
        -- This can overwrite itself.
        -- Unknown how it interacts with STAT_DOWN effects.
        -- Unknown how it interacts with GAIN/BOOST spells.

        if target:addStatusEffect(effectId, { power = effectPower, duration = duration, origin = pet }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)

            return
        end

        return effectId
    end,
})

-----------------------------------
-- Rolling Thunder
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.rolling_thunder.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        local baseDuration = 60
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet) * 2
        local duration     = math.min(baseDuration + bonusTime, 180)

        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local magicskill = xi.data.skillLevel.getSkillCap(target:getMainLvl(), xi.skillRank.A_PLUS)
        local potency    = 3 + 6 * magicskill / 100

        if magicskill > 200 then
            potency = 5 + 5 * magicskill / 100
        end

        xi.mobskills.mobBuffMove(target, xi.effect.ENTHUNDER, potency, 0, duration)

        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_EFFECT)
        end

        return xi.effect.ENTHUNDER
    end,
})

-----------------------------------
-- Lightning Armor
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.lightning_armor.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        local baseDuration = 90
        local bonusTime    = xi.summon.getSummoningSkillOverCap(pet) * 3
        local duration     = math.min(baseDuration + bonusTime, 180)

        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        target:delStatusEffect(xi.effect.SHOCK_SPIKES)

        if target:addStatusEffect(xi.effect.SHOCK_SPIKES, { power = 15, duration = duration, origin = pet }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            return
        end

        return xi.effect.SHOCK_SPIKES
    end,
})

-----------------------------------
-- Ecliptic Growl
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.ecliptic_growl.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local duration  = 180
        local moonCycle = getVanadielMoonCycle()

        local cycleBuffs =
        {
            [xi.moonCycle.NEW_MOON]                = 1,
            [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 2,
            [xi.moonCycle.GREATER_WAXING_CRESCENT] = 3,
            [xi.moonCycle.FIRST_QUARTER]           = 4,
            [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 5,
            [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 6,
            [xi.moonCycle.FULL_MOON]               = 7,
            [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 6,
            [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 5,
            [xi.moonCycle.THIRD_QUARTER]           = 4,
            [xi.moonCycle.GREATER_WANING_CRESCENT] = 3,
            [xi.moonCycle.LESSER_WANING_CRESCENT]  = 2,
        }

        local buffValue = cycleBuffs[moonCycle]

        target:delStatusEffect(xi.effect.STR_BOOST)
        target:delStatusEffect(xi.effect.DEX_BOOST)
        target:delStatusEffect(xi.effect.VIT_BOOST)
        target:delStatusEffect(xi.effect.AGI_BOOST)
        target:delStatusEffect(xi.effect.MND_BOOST)
        target:delStatusEffect(xi.effect.CHR_BOOST)

        target:addStatusEffect(xi.effect.STR_BOOST, { power = buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.DEX_BOOST, { power = buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.VIT_BOOST, { power = buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.AGI_BOOST, { power = 8 - buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.INT_BOOST, { power = 8 - buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.MND_BOOST, { power = 8 - buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.CHR_BOOST, { power = 8 - buffValue, duration = duration, origin = pet })

        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.STATUS_BOOST)
        else
            petskill:setMsg(xi.msg.basic.STATUS_BOOST_2)
        end

        return 0
    end,
})

-----------------------------------
-- Ecliptic Howl
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.ecliptic_howl.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local duration  = 180
        local moonCycle = getVanadielMoonCycle()

        local cycleBuffs =
        {
            [xi.moonCycle.NEW_MOON]                = 1,
            [xi.moonCycle.LESSER_WAXING_CRESCENT]  = 5,
            [xi.moonCycle.GREATER_WAXING_CRESCENT] = 9,
            [xi.moonCycle.FIRST_QUARTER]           = 13,
            [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = 17,
            [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = 21,
            [xi.moonCycle.FULL_MOON]               = 25,
            [xi.moonCycle.GREATER_WANING_GIBBOUS]  = 21,
            [xi.moonCycle.LESSER_WANING_GIBBOUS]   = 17,
            [xi.moonCycle.THIRD_QUARTER]           = 13,
            [xi.moonCycle.GREATER_WANING_CRESCENT] = 9,
            [xi.moonCycle.LESSER_WANING_CRESCENT]  = 5,
        }

        local buffValue = cycleBuffs[moonCycle]

        target:delStatusEffect(xi.effect.ACCURACY_BOOST)
        target:delStatusEffect(xi.effect.EVASION_BOOST)
        target:addStatusEffect(xi.effect.ACCURACY_BOOST, { power = buffValue, duration = duration, origin = pet })
        target:addStatusEffect(xi.effect.EVASION_BOOST, { power = 25 - buffValue, duration = duration, origin = pet })

        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.ACC_EVA_BOOST)
        else
            petskill:setMsg(xi.msg.basic.ACC_EVA_BOOST_2)
        end

        return 0
    end,
})

-----------------------------------
-- Healing Ruby
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.healing_ruby.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local params = {}

        params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
        params.baseHeal       = 3 * (pet:getMainLvl() - 30)
        params.additiveHeal   = 44
        params.fTP =
        {
            { tp = 0,    modifier = 256 / 256 },
            { tp = 1500, modifier = 351 / 256 },
            { tp = 3000, modifier = 446 / 256 },
        }

        if pet:getMainLvl() <= 30 then
            params.baseHeal     = pet:getMainLvl()
            params.additiveHeal = 14
        end

        return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
    end,
})

-----------------------------------
-- Healing Ruby II
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.healing_ruby_ii.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        -- https://wiki.ffo.jp/html/4080.html

        local params = {}

        params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
        params.baseHeal       = pet:getMainLvl() * 4
        params.additiveHeal   = 30
        params.fTP =
        {
            { tp = 0,    modifier = 256 / 256 },
            { tp = 1500, modifier = 299 / 256 }, -- TODO: Unconfirmed for 75 era.
            { tp = 3000, modifier = 342 / 256 },
        }

        return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
    end,
})

-----------------------------------
-- Noctoshield
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.noctoshield.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
        local duration = 180

        if target:addStatusEffect(xi.effect.PHALANX, { power = 13, duration = duration, origin = pet }) then
            if target:getID() == action:getPrimaryTargetID() then
                petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
            else
                petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
            end
        else
            petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
            return
        end

        return xi.effect.PHALANX
    end,
})

-----------------------------------
-- Dream Shroud
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.dream_shroud.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local baseDuration = 180
    local duration     = baseDuration
    local hour         = VanadielHour()
    local buffvalue    = math.abs(12 - hour) + 1

    -- TODO: Does this overwrite itself?
    target:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    target:delStatusEffect(xi.effect.MAGIC_DEF_BOOST)

    target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, { power = buffvalue, duration = duration, origin = pet })
    target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, { power = 14 - buffvalue, duration = duration, origin = pet })

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_MAB_MDB)
    else
        petskill:setMsg(xi.msg.basic.JA_RECEIVES_MAB_MDB_2)
    end

    return 0
    end,
})

-----------------------------------
-- Spring Water
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.spring_water.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local removableEffects =
        {
            xi.effect.BLINDNESS,
            xi.effect.DISEASE,
            xi.effect.PARALYSIS,
            xi.effect.PETRIFICATION,
            xi.effect.POISON,
            xi.effect.SILENCE,
            -- TODO: JPWiki mentions that Spring Water can remove Mute inflicted by Promathia. Need captures.
            -- Mute inflicted from Eight of Cups mob could not be removed by this skill.
        }

        local activeEffects = {}

        -- Fetch list of removable effects currently on target
        for _, effectId in ipairs(removableEffects) do
            if target:getStatusEffect(effectId) then
                table.insert(activeEffects, effectId)
            end
        end

        -- Remove one removable effect from the target, chosen at random
        if #activeEffects > 0 then
            activeEffects = utils.shuffle(activeEffects)

            target:delStatusEffect(activeEffects[1])
        end

        local params = {}

        params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
        params.baseHeal       = pet:getMainLvl() * 3
        params.additiveHeal   = 47
        params.fTP =
        {
            -- TODO: Heal formulas needs more research.
            -- Using closest match for now.
            { tp = 0,    modifier = 1024 / 1024 },
            { tp = 1500, modifier = 1164 / 1024 },
            { tp = 3000, modifier = 1304 / 1024 },
        }

        return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
    end,
})

-----------------------------------
-- Whispering Wind
-----------------------------------
m:addOverrideByEra('xi.actions.abilities.pets.whispering_wind.onPetAbility', {
    [xi.expansion.ABYSSEA] = function(target, pet, petskill, summoner, action)
        xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

        local params = {}

        params.primaryMessage = xi.msg.basic.JA_RECOVERS_HP_2
        params.baseHeal       = pet:getMainLvl() * 2.5
        params.additiveHeal   = 16
        params.fTP =
        {
            { tp = 0,    modifier = 1024 / 1024 },
            { tp = 1500, modifier = 1884 / 1024 },
            { tp = 3000, modifier = 2240 / 1024 },
        }

        return xi.mobskills.mobHealMove(pet, target, petskill, action, params)
    end,
})
