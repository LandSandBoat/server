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
        -- Garuda
        [xi.jobAbility.CLAW]             =   7,
        [xi.jobAbility.AERO_II]          =  24,
        [xi.jobAbility.AERIAL_ARMOR]     =  92,
        [xi.jobAbility.FLEET_WIND]       = 114,
        [xi.jobAbility.AERO_IV]          = 118,
        [xi.jobAbility.WHISPERING_WIND]  = 119,
        [xi.jobAbility.HASTEGA]          = 129,
        [xi.jobAbility.PREDATOR_CLAWS]   = 164,
        [xi.jobAbility.WIND_BLADE]       = 182,
        [xi.jobAbility.HASTEGA_II]       = 248,
        -- Titan
        [xi.jobAbility.ROCK_THROW]       =  10,
        [xi.jobAbility.STONE_II]         =  24,
        [xi.jobAbility.ROCK_BUSTER]      =  39,
        [xi.jobAbility.MEGALITH_THROW]   =  62,
        [xi.jobAbility.EARTHEN_WARD]     =  92,
        [xi.jobAbility.STONE_IV]         = 118,
        [xi.jobAbility.CRAG_THROW]       = 124,
        [xi.jobAbility.EARTHEN_ARMOR]    = 156,
        [xi.jobAbility.MOUNTAIN_BUSTER]  = 164,
        [xi.jobAbility.GEOCRUSH]         = 182,
        -- Titan
        [xi.jobAbility.PUNCH]            =   9,
        [xi.jobAbility.FIRE_II]          =  24,
        [xi.jobAbility.BURNING_STRIKE]   =  48,
        [xi.jobAbility.DOUBLE_PUNCH]     =  56,
        [xi.jobAbility.INFERNO_HOWL]     =  72,
        [xi.jobAbility.CRIMSON_HOWL]     =  84,
        [xi.jobAbility.FIRE_IV]          = 118,
        [xi.jobAbility.CONFLAG_STRIKE]   = 141,
        [xi.jobAbility.FLAMING_CRUSH]    = 164,
        [xi.jobAbility.METEOR_STRIKE]    = 182,
        -- Fenrir
        [xi.jobAbility.MOONLIT_CHARGE]   =  17,
        [xi.jobAbility.CRESCENT_FANG]    =  19,
        [xi.jobAbility.LUNAR_ROAR]       =  27,
        [xi.jobAbility.LUNAR_CRY]        =  41,
        [xi.jobAbility.ECLIPTIC_GROWL]   =  46,
        [xi.jobAbility.ECLIPTIC_HOWL]    =  57,
        [xi.jobAbility.HEAVENWARD_HOWL]  =  96,
        [xi.jobAbility.ECLIPSE_BITE]     = 109,
        [xi.jobAbility.LUNAR_BAY]        = 174,
        [xi.jobAbility.IMPACT]           = 222,
        -- Shiva
        [xi.jobAbility.AXE_KICK]         =  10,
        [xi.jobAbility.BLIZZARD_II]      =  24,
        [xi.jobAbility.SLEEPGA]          =  56,
        [xi.jobAbility.FROST_ARMOR]      =  63,
        [xi.jobAbility.DOUBLE_SLAP]      =  96,
        [xi.jobAbility.BLIZZARD_IV]      = 118,
        [xi.jobAbility.DIAMOND_STORM]    = 138,
        [xi.jobAbility.RUSH]             = 164,
        [xi.jobAbility.HEAVENLY_STRIKE]  = 182,
        [xi.jobAbility.CRYSTAL_BLESSING] = 201,
        -- Ramuh
        [xi.jobAbility.SHOCK_STRIKE]     =   6,
        [xi.jobAbility.THUNDER_II]       =  24,
        [xi.jobAbility.THUNDERSPARK]     =  38,
        [xi.jobAbility.ROLLING_THUNDER]  =  52,
        [xi.jobAbility.SHOCK_SQUALL]     =  67,
        [xi.jobAbility.LIGHTNING_ARMOR]  =  91,
        [xi.jobAbility.THUNDER_IV]       = 118,
        [xi.jobAbility.CHAOTIC_STRIKE]   = 164,
        [xi.jobAbility.THUNDERSTORM]     = 182,
        [xi.jobAbility.VOLT_STRIKE]      = 229,
        -- Diabolos
        [xi.jobAbility.CAMISADO]         =  20,
        [xi.jobAbility.ULTIMATE_TERROR]  =  27,
        [xi.jobAbility.SOMNOLENCE]       =  30,
        [xi.jobAbility.NIGHTMARE]        =  42,
        [xi.jobAbility.NOCTOSHIELD]      =  92,
        [xi.jobAbility.NETHER_BLAST]     = 109,
        [xi.jobAbility.DREAM_SHROUD]     = 121,
        [xi.jobAbility.BLINDSIDE]        = 147,
        [xi.jobAbility.NIGHT_TERROR]     = 177,
        [xi.jobAbility.PAVOR_NOCTURNUS]  = 246,
        -- Cait Sith
        [xi.jobAbility.REGAL_SCRATCH]    = 5,
        [xi.jobAbility.MEWING_LULLABY]   = 61,
        [xi.jobAbility.EARIE_EYE]        = 134,
        [xi.jobAbility.LEVEL_QM_HOLY]    = 235,
        [xi.jobAbility.RAISE_II]         = 160,
        [xi.jobAbility.RERAISE_II]       = 80,
        -- Siren
        [xi.jobAbility.WELT]             =   9,
        [xi.jobAbility.ROUNDHOUSE]       =  52,
        [xi.jobAbility.SONIC_BUFFET]     = 164,
        [xi.jobAbility.TORNADO_II]       = 182,
        [xi.jobAbility.HYSTERIC_ASSAULT] = 222,
    }

    local baseMPCost = nil

    if ability then
        if ability:getAddType() == xi.addType.ADDTYPE_ASTRAL_FLOW then
            baseMPCost = player:getMainLvl() * 2
        else
            baseMPCost = baseMPCostMap[ability:getID()]
        end
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

        local petAction = pet:getCurrentAction()

        -- check if avatar is under status effect
        if petAction == xi.action.SLEEP or petAction == xi.action.STUN then
            return xi.msg.basic.PET_CANNOT_DO_ACTION, 0 -- TODO: verify exact message in packet.
        end

        -- check if avatar is using a move already
        if petAction == xi.action.PET_MOBABILITY_FINISH then
            return xi.msg.basic.PET_CANNOT_DO_ACTION, 0 -- TODO: verify exact message in packet.
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
    local bloodPactRecast  = math.max(0, summoner:getLocalVar('bpRecastTime'))

    if target:getID() == action:getPrimaryTargetID() then
        -- MP and Cooldown is only consumed if the ability goes off
        summoner:delMP(mpCost)
        if summoner:hasStatusEffect(xi.effect.APOGEE) then
            summoner:resetRecast(xi.recast.ABILITY, bloodPactAbility:getRecastID())
            summoner:delStatusEffect(xi.effect.APOGEE)
        else
            if xi.settings.map.BLOOD_PACT_SHARED_TIMER then
                summoner:addRecast(xi.recast.ABILITY, xi.recastID.BLOODPACT_RAGE, bloodPactRecast)
                summoner:addRecast(xi.recast.ABILITY, xi.recastID.BLOODPACT_WARD, bloodPactRecast)
            else
                summoner:addRecast(xi.recast.ABILITY, bloodPactAbility:getRecastID(), bloodPactRecast)
            end
        end
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

    if effectsErased > 0 then
        for i = 1, effectsErased do
            local index = math.random(1, #erasableEffectTable)

            target:delStatusEffect(erasableEffectTable[index])
            table.remove(erasableEffectTable, index)
        end

        petskill:setMsg(xi.msg.basic.MAGIC_REMOVE_EFFECT_2)
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
    end

    return effectsErased
end
