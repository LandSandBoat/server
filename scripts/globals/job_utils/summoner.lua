-----------------------------------
-- Summoner Job Utilities
-----------------------------------
require('scripts/globals/ability')
require('scripts/globals/jobpoints')
require('scripts/globals/combat/tp')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.summoner = xi.job_utils.summoner or {}
-----------------------------------

-- sort of a misnomer, as if Apogee is up, the 'base' mp cost rises.
local function getBaseMPCost(player, ability)
    local baseMPCostMap =
    {
        -- Carbuncle
        [xi.jobAbility.HEALING_RUBY]     =   6,
        [xi.jobAbility.POISON_NAILS]     =  11,
        [xi.jobAbility.SHINING_RUBY]     =  44,
        [xi.jobAbility.GLITTERING_RUBY]  =  62,
        [xi.jobAbility.SOOTHING_RUBY]    =  74,
        [xi.jobAbility.PACIFYING_RUBY]   =  83,
        [xi.jobAbility.METEORITE]        = 108,
        [xi.jobAbility.HEALING_RUBY_II]  = 124,
        [xi.jobAbility.HOLY_MIST]        = 152,
        -- Leviathan
        [xi.jobAbility.BARRACUDA_DIVE]   =   8,
        [xi.jobAbility.WATER_II]         =  24,
        [xi.jobAbility.SLOWGA]           =  48,
        [xi.jobAbility.TAIL_WHIP]        =  49,
        [xi.jobAbility.SOOTHING_CURRENT] =  95,
        [xi.jobAbility.SPRING_WATER]     =  99,
        [xi.jobAbility.WATER_IV]         = 118,
        [xi.jobAbility.TIDAL_ROAR]       = 138,
        [xi.jobAbility.SPINNING_DIVE]    = 164,
        [xi.jobAbility.GRAND_FALL]       = 182,
        -- Siren
        [xi.jobAbility.WELT]             =   9,
        [xi.jobAbility.ROUNDHOUSE]       =  52,
        [xi.jobAbility.SONIC_BUFFET]     = 164,
        [xi.jobAbility.TORNADO_II]       = 182,
        [xi.jobAbility.HYSTERIC_ASSAULT] = 222,
    }

    local baseMPCost = nil

    if ability:getAddType() == xi.addType.ADDTYPE_ASTRAL_FLOW then
        baseMPCost = player:getMainLvl() * 2
    elseif ability ~= nil then
        baseMPCost = baseMPCostMap[ability:getID()]
    end

    if baseMPCost == nil then
        printf('[warning] scripts/globals/job_utils/summoner.lua::getBaseMPCost(): MP cost for xi.jobAbility with id %d not implemented.', ability:getID())
        return 9999
    end

    -- https://www.bg-wiki.com/ffxi/Apogee
    -- Apogee, 1.5x MP cost, don't delete effect here because we need to reset BP: Ward/Rage timer upon use
    if player:hasStatusEffect(xi.effect.APOGEE) then
        baseMPCost = baseMPCost * 1.5
    end

    return baseMPCost
end

local function getMPCost(baseMPCost, player, petskill)
    local mpCost = baseMPCost

    -- don't proc blood boon on Astral Flow
    if petskill:getAddType() ~= xi.addType.ADDTYPE_ASTRAL_FLOW then
        local bloodBoonRate = player:getMod(xi.mod.BLOOD_BOON)
        -- assuming it works like Conserve MP... https://www.bg-wiki.com/ffxi/Conserve_MP
        if math.random(1, 100) <= bloodBoonRate then
            mpCost = mpCost * math.random(8, 15) / 16
        end
    end

    return mpCost
end

-- Bloodpact Delay is handled in charentity.cpp
xi.job_utils.summoner.canUseBloodPact = function(player, pet, target, petAbility)
    -- TODO: verify order of out of MP/range/etc checks.
    if pet ~= nil then
        -- There is some complex interaction here.
        -- First off, you will get out of range message if the pet isn't within the abilities range to it's target.
        -- Second, if your pet is in range, but you're out of range of your pet, retail provides no message for some reason but the pet does nothing.
        -- No out of range error message is unhelpful so we are setting that message anyway.

        -- TODO: The hardcoded ranges of 21/22 need to take into account mob size.
        -- TODO: add "era" setting or setting in general for this. Era used to have a smaller range for BPs.
        -- This is a "new" change -- https://forum.square-enix.com/ffxi/threads/48564-Sep-16-2015-%28JST%29-Version-Update
        -- TODO: verify who/what is "out of range" for out of range messages

        -- check if target is too far from pet for ability
        if pet:checkDistance(target) >= petAbility:getRange() then
            return xi.msg.basic.TARG_OUT_OF_RANGE, 0
        end

        -- check if player is too far from pet
        if pet:checkDistance(player) >= 21 then
            return xi.msg.basic.TARG_OUT_OF_RANGE, 0
        end

        -- check if player is too far from target
        if target:checkDistance(player) >= 22 then
            return xi.msg.basic.TARG_OUT_OF_RANGE, 0
        end

        local baseMPCost = getBaseMPCost(player, petAbility)

        if player:getMP() < baseMPCost then
            return xi.msg.basic.UNABLE_TO_USE_JA2, 0 -- TODO: verify exact message in packet.
        end

        return 0, 0
    end

    return xi.msg.basic.UNABLE_TO_USE_JA2, 0 -- TODO: verify exact message in packet.
end

xi.job_utils.summoner.onUseBloodPact = function(target, petskill, summoner, action)
    local bloodPactAbility = GetAbility(petskill:getID()) -- Player abilities and Avatar abilities are mapped 1:1
    local baseMPCost       = getBaseMPCost(summoner, bloodPactAbility)
    local mpCost           = getMPCost(baseMPCost, summoner, bloodPactAbility)

    if summoner:hasStatusEffect(xi.effect.APOGEE) then
        summoner:resetRecast(xi.recast.ABILITY, bloodPactAbility:getRecastID())
        summoner:delStatusEffect(xi.effect.APOGEE)
    end

    if target:getID() == action:getPrimaryTargetID() then
        summoner:delMP(mpCost)
    end
end

-- to be removed once damage is overhauled
xi.job_utils.summoner.calculateTPReturn = function(avatar, target, damage, numHits)
    if damage ~= 0 and numHits > 0 then -- absorbed hits still give TP, though we can't know how many hits actually connected in the current avatar damage formulas
        local tpReturn = xi.combat.tp.getSingleMeleeHitTPReturn(avatar, target)
        tpReturn = tpReturn + 10 * (numHits - 1) -- extra hits give 10 TP each
        avatar:setTP(tpReturn)
    else
        avatar:setTP(0)
    end
end

xi.job_utils.summoner.useManaCede = function(player, ability, action)
    local avatar = player:getPet()

    if avatar ~= nil then
        local avatarTP = avatar:getTP()
        local bonusTP = 1000 + player:getJobPointLevel(xi.jp.MANA_CEDE_EFFECT) * 50
        local manaCedeBonus = (100 + player:getMod(xi.mod.ENHANCES_MANA_CEDE)) / 100
        local avatarNewTP = utils.clamp(avatarTP + bonusTP * manaCedeBonus, 1000, 3000)

        action:ID(player:getID(), avatar:getID())
        avatar:setTP(avatarNewTP)
        player:delMP(100)
    end
end

xi.job_utils.summoner.useSoothingRuby = function(target, pet, petskill, summoner, action)
    local targetEffectTable = target:getStatusEffects()

    -- Generate table with erasable effects from target effect table.
    local erasableEffectTable        = {}
    local additionalRemovableEffects =
    set{
        xi.effect.POISON,
        xi.effect.BLINDNESS,
        xi.effect.PARALYSIS,
        xi.effect.SILENCE,
        xi.effect.CURSE_I,
        xi.effect.PLAGUE,
        xi.effect.DISEASE
    }

    for _, effect in pairs(targetEffectTable) do
        local id = effect:getEffectType()
        if
            bit.band(effect:getEffectFlags(), xi.effectFlag.ERASABLE) == xi.effectFlag.ERASABLE or
            additionalRemovableEffects[id]
        then
            table.insert(erasableEffectTable, id)
        end
    end

    -- Calculate the ammount of effects this skill can potentialy erase.
    local summoningSkillFactor = math.floor((summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) + 99) / 100)
    local soothingRubyPower    = utils.clamp(summoningSkillFactor, 1, 6)

    -- Erase effects.
    local effectsErased = math.min(#erasableEffectTable, soothingRubyPower)
    local index         = 0

    if effectsErased > 0 then
        for i = 1, effectsErased do
            index = math.random(1, #erasableEffectTable)
            target:delStatusEffect(erasableEffectTable[index])
            table.remove(erasableEffectTable, index)
        end

        petskill:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    return effectsErased
end
