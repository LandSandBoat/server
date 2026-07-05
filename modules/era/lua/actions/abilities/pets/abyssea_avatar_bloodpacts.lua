-----------------------------------
-- Reverts blood pacts to no longer have a duration based on summoning magic.
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
-----------------------------------
require('modules/module_utils')
-----------------------------------

local moduleName = 'abyssea_avatar_bloodpacts'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-----------------------------------
-- Shining Ruby
-----------------------------------
m:addOverride('xi.actions.abilities.pets.shining_ruby.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    target:delStatusEffect(xi.effect.SHINING_RUBY)
    target:addStatusEffect(xi.effect.SHINING_RUBY, { power = 1, duration = duration, origin = pet })

    if target:getID() == action:getPrimaryTargetID() then
        petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
    end

    return xi.effect.SHINING_RUBY
end)

-----------------------------------
-- Hastega
-----------------------------------
m:addOverride('xi.actions.abilities.pets.hastega.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    -- Reverts Garuda's Hastega to use 102/1024 or 9.96%
    local typeEffect = xi.effect.HASTE
    if target:addStatusEffect(typeEffect, { power = 996, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end)

-----------------------------------
-- Crimson Howl
-----------------------------------
m:addOverride('xi.actions.abilities.pets.crimson_howl.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 60

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local typeEffect = xi.effect.WARCRY
    if target:addStatusEffect(typeEffect, { power = 9, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end)

-----------------------------------
-- Frost Armor
-----------------------------------
m:addOverride('xi.actions.abilities.pets.frost_armor.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local typeEffect = xi.effect.ICE_SPIKES
    target:delStatusEffect(typeEffect)

    if target:addStatusEffect(typeEffect, { power = 15, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end)

-----------------------------------
-- Rolling Thunder
-----------------------------------
m:addOverride('xi.actions.abilities.pets.rolling_thunder.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 120

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
end)

-----------------------------------
-- Lightning Armor
-----------------------------------
m:addOverride('xi.actions.abilities.pets.lightning_armor.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local typeEffect = xi.effect.SHOCK_SPIKES
    target:delStatusEffect(typeEffect)

    if target:addStatusEffect(typeEffect, { power = 15, duration = duration, origin = pet }) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT_2)
        else
            petskill:setMsg(xi.msg.basic.JA_GAIN_EFFECT)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return typeEffect
end)

-----------------------------------
-- Ecliptic Growl
-----------------------------------
m:addOverride('xi.actions.abilities.pets.ecliptic_growl.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
end)

-----------------------------------
-- Ecliptic Howl
-----------------------------------
m:addOverride('xi.actions.abilities.pets.ecliptic_howl.onPetAbility', function(target, pet, petskill, summoner, action)
    local duration = 180

    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
end)

-----------------------------------
-- Noctoshield
-----------------------------------
m:addOverride('xi.actions.abilities.pets.noctoshield.onPetAbility', function(target, pet, petskill, summoner, action)
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
end)

-----------------------------------
-- Dream Shroud
-----------------------------------
m:addOverride('xi.actions.abilities.pets.dream_shroud.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
    local duration = 180
    local hour = VanadielHour()
    local buffvalue = math.abs(12 - hour) + 1

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
end)

return m
