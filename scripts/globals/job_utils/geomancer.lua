-----------------------------------
-- Geomancer Job Utilities
-----------------------------------
require('scripts/globals/ability')
require('scripts/globals/pets')
require('scripts/globals/weaponskills')
require('scripts/globals/jobpoints')
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.geomancer = xi.job_utils.geomancer or {}
-----------------------------------

xi.job_utils.geomancer.luopanModels =
{
    FIRE    = 2850,
    ICE     = 2851,
    WIND    = 2852,
    EARTH   = 2853,
    THUNDER = 2854,
    WATER   = 2855,
    LIGHT   = 2856,
    DARK    = 2865,
}

xi.job_utils.geomancer.indiVisualEffect =
{
    FIRE    = { ALLIES = 0, ENEMIES = 8  },
    ICE     = { ALLIES = 1, ENEMIES = 9  },
    WIND    = { ALLIES = 2, ENEMIES = 10 },
    EARTH   = { ALLIES = 3, ENEMIES = 11 },
    THUNDER = { ALLIES = 4, ENEMIES = 12 },
    WATER   = { ALLIES = 5, ENEMIES = 13 },
    LIGHT   = { ALLIES = 6, ENEMIES = 14 },
    DARK    = { ALLIES = 7, ENEMIES = 15 },
}

xi.job_utils.geomancer.geoData =
{
    [xi.magic.spell.GEO_REGEN]      = { luopanModel = xi.job_utils.geomancer.luopanModels.LIGHT,   effect = xi.effect.GEO_REGEN,               targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_POISON]     = { luopanModel = xi.job_utils.geomancer.luopanModels.WATER,   effect = xi.effect.GEO_POISON,              targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_REFRESH]    = { luopanModel = xi.job_utils.geomancer.luopanModels.LIGHT,   effect = xi.effect.GEO_REFRESH,             targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_HASTE]      = { luopanModel = xi.job_utils.geomancer.luopanModels.WIND,    effect = xi.effect.GEO_HASTE,               targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_STR]        = { luopanModel = xi.job_utils.geomancer.luopanModels.FIRE,    effect = xi.effect.GEO_STR_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_DEX]        = { luopanModel = xi.job_utils.geomancer.luopanModels.THUNDER, effect = xi.effect.GEO_DEX_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_VIT]        = { luopanModel = xi.job_utils.geomancer.luopanModels.EARTH,   effect = xi.effect.GEO_VIT_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_AGI]        = { luopanModel = xi.job_utils.geomancer.luopanModels.WIND,    effect = xi.effect.GEO_AGI_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_INT]        = { luopanModel = xi.job_utils.geomancer.luopanModels.ICE,     effect = xi.effect.GEO_INT_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_MND]        = { luopanModel = xi.job_utils.geomancer.luopanModels.WATER,   effect = xi.effect.GEO_MND_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_CHR]        = { luopanModel = xi.job_utils.geomancer.luopanModels.LIGHT,   effect = xi.effect.GEO_CHR_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_FURY]       = { luopanModel = xi.job_utils.geomancer.luopanModels.FIRE,    effect = xi.effect.GEO_ATTACK_BOOST,        targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_BARRIER]    = { luopanModel = xi.job_utils.geomancer.luopanModels.EARTH,   effect = xi.effect.GEO_DEFENSE_BOOST,       targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_ACUMEN]     = { luopanModel = xi.job_utils.geomancer.luopanModels.ICE,     effect = xi.effect.GEO_MAGIC_ATK_BOOST,     targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_FEND]       = { luopanModel = xi.job_utils.geomancer.luopanModels.WATER,   effect = xi.effect.GEO_MAGIC_DEF_BOOST,     targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_PRECISION]  = { luopanModel = xi.job_utils.geomancer.luopanModels.THUNDER, effect = xi.effect.GEO_ACCURACY_BOOST,      targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_VOIDANCE]   = { luopanModel = xi.job_utils.geomancer.luopanModels.WIND,    effect = xi.effect.GEO_EVASION_BOOST,       targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_FOCUS]      = { luopanModel = xi.job_utils.geomancer.luopanModels.DARK,    effect = xi.effect.GEO_MAGIC_ACC_BOOST,     targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_ATTUNEMENT] = { luopanModel = xi.job_utils.geomancer.luopanModels.LIGHT,   effect = xi.effect.GEO_MAGIC_EVASION_BOOST, targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.GEO_WILT]       = { luopanModel = xi.job_utils.geomancer.luopanModels.WATER,   effect = xi.effect.GEO_ATTACK_DOWN,         targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_FRAILTY]    = { luopanModel = xi.job_utils.geomancer.luopanModels.WIND,    effect = xi.effect.GEO_DEFENSE_DOWN,        targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_FADE]       = { luopanModel = xi.job_utils.geomancer.luopanModels.FIRE,    effect = xi.effect.GEO_MAGIC_ATK_DOWN,      targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_MALAISE]    = { luopanModel = xi.job_utils.geomancer.luopanModels.THUNDER, effect = xi.effect.GEO_MAGIC_DEF_DOWN,      targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_SLIP]       = { luopanModel = xi.job_utils.geomancer.luopanModels.EARTH,   effect = xi.effect.GEO_ACCURACY_DOWN,       targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_TORPOR]     = { luopanModel = xi.job_utils.geomancer.luopanModels.ICE,     effect = xi.effect.GEO_EVASION_DOWN,        targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_VEX]        = { luopanModel = xi.job_utils.geomancer.luopanModels.LIGHT,   effect = xi.effect.GEO_MAGIC_ACC_DOWN,      targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_LANGUOR]    = { luopanModel = xi.job_utils.geomancer.luopanModels.DARK,    effect = xi.effect.GEO_MAGIC_EVASION_DOWN,  targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_SLOW]       = { luopanModel = xi.job_utils.geomancer.luopanModels.EARTH,   effect = xi.effect.GEO_SLOW,                targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_PARALYSIS]  = { luopanModel = xi.job_utils.geomancer.luopanModels.ICE,     effect = xi.effect.GEO_PARALYSIS,           targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.GEO_GRAVITY]    = { luopanModel = xi.job_utils.geomancer.luopanModels.WIND,    effect = xi.effect.GEO_WEIGHT,              targetType = xi.auraTarget.ENEMIES },
}

xi.job_utils.geomancer.indiData =
{
    [xi.magic.spell.INDI_REGEN]      = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.LIGHT.ALLIES,    effect = xi.effect.GEO_REGEN,               targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_POISON]     = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WATER.ENEMIES,   effect = xi.effect.GEO_POISON,              targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_REFRESH]    = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.LIGHT.ALLIES,    effect = xi.effect.GEO_REFRESH,             targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_HASTE]      = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WIND.ALLIES,     effect = xi.effect.GEO_HASTE,               targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_STR]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.FIRE.ALLIES,     effect = xi.effect.GEO_STR_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_DEX]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.THUNDER.ALLIES,  effect = xi.effect.GEO_DEX_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_VIT]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.EARTH.ALLIES,    effect = xi.effect.GEO_VIT_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_AGI]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WIND.ALLIES,     effect = xi.effect.GEO_AGI_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_INT]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.ICE.ALLIES,      effect = xi.effect.GEO_INT_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_MND]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WATER.ALLIES,    effect = xi.effect.GEO_MND_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_CHR]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.LIGHT.ALLIES,    effect = xi.effect.GEO_CHR_BOOST,           targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_FURY]       = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.FIRE.ALLIES,     effect = xi.effect.GEO_ATTACK_BOOST,        targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_BARRIER]    = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.EARTH.ALLIES,    effect = xi.effect.GEO_DEFENSE_BOOST,       targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_ACUMEN]     = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.ICE.ALLIES,      effect = xi.effect.GEO_MAGIC_ATK_BOOST,     targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_FEND]       = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WATER.ALLIES,    effect = xi.effect.GEO_MAGIC_DEF_BOOST,     targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_PRECISION]  = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.THUNDER.ALLIES,  effect = xi.effect.GEO_ACCURACY_BOOST,      targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_VOIDANCE]   = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WIND.ALLIES,     effect = xi.effect.GEO_EVASION_BOOST,       targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_FOCUS]      = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.DARK.ALLIES,     effect = xi.effect.GEO_MAGIC_ACC_BOOST,     targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_ATTUNEMENT] = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.LIGHT.ALLIES,    effect = xi.effect.GEO_MAGIC_EVASION_BOOST, targetType = xi.auraTarget.ALLIES  },
    [xi.magic.spell.INDI_WILT]       = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WATER.ENEMIES,   effect = xi.effect.GEO_ATTACK_DOWN,         targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_FRAILTY]    = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WIND.ENEMIES,    effect = xi.effect.GEO_DEFENSE_DOWN,        targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_FADE]       = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.FIRE.ENEMIES,    effect = xi.effect.GEO_MAGIC_ATK_DOWN,      targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_MALAISE]    = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.THUNDER.ENEMIES, effect = xi.effect.GEO_MAGIC_DEF_DOWN,      targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_SLIP]       = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.EARTH.ENEMIES,   effect = xi.effect.GEO_ACCURACY_DOWN,       targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_TORPOR]     = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.ICE.ENEMIES,     effect = xi.effect.GEO_EVASION_DOWN,        targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_VEX]        = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.LIGHT.ENEMIES,   effect = xi.effect.GEO_MAGIC_ACC_DOWN,      targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_LANGUOR]    = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.DARK.ENEMIES,    effect = xi.effect.GEO_MAGIC_EVASION_DOWN,  targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_SLOW]       = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.EARTH.ENEMIES,   effect = xi.effect.GEO_SLOW,                targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_PARALYSIS]  = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.ICE.ENEMIES,     effect = xi.effect.GEO_PARALYSIS,           targetType = xi.auraTarget.ENEMIES },
    [xi.magic.spell.INDI_GRAVITY]    = { visualEffect = xi.job_utils.geomancer.indiVisualEffect.WIND.ENEMIES,    effect = xi.effect.GEO_WEIGHT,              targetType = xi.auraTarget.ENEMIES },
}

xi.job_utils.geomancer.potencyData =
{
    [xi.effect.GEO_REGEN]               = { divisor =  20.00, minPotency = 1.0, maxPotency = 30.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_POISON]              = { divisor =  20.00, minPotency = 1.0, maxPotency = 30.0, geoModMultiplier = 3.0 },
    [xi.effect.GEO_REFRESH]             = { divisor = 150.00, minPotency = 1.0, maxPotency =  6.0, geoModMultiplier = 1.0 },
    [xi.effect.GEO_STR_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_DEX_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_VIT_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_AGI_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_INT_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_MND_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_CHR_BOOST]           = { divisor =  36.00, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0 },
    [xi.effect.GEO_ATTACK_BOOST]        = { divisor =  25.93, minPotency = 4.6, maxPotency = 34.7, geoModMultiplier = 2.7 },
    [xi.effect.GEO_DEFENSE_BOOST]       = { divisor =  22.61, minPotency = 9.7, maxPotency = 39.8, geoModMultiplier = 4.6 },
    [xi.effect.GEO_MAGIC_ATK_BOOST]     = { divisor =  60.00, minPotency = 3.0, maxPotency = 15.0, geoModMultiplier = 3.0 },
    [xi.effect.GEO_MAGIC_DEF_BOOST]     = { divisor =  45.00, minPotency = 5.0, maxPotency = 20.0, geoModMultiplier = 4.0 },
    [xi.effect.GEO_ACCURACY_BOOST]      = { divisor =  18.00, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0 },
    [xi.effect.GEO_EVASION_BOOST]       = { divisor =  13.84, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 5.0 },
    [xi.effect.GEO_MAGIC_ACC_BOOST]     = { divisor =  18.00, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0 },
    [xi.effect.GEO_MAGIC_EVASION_BOOST] = { divisor =  13.84, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 6.0 },
    [xi.effect.GEO_ATTACK_DOWN]         = { divisor =  36.00, minPotency = 4.6, maxPotency = 25.0, geoModMultiplier = 4.6 },
    [xi.effect.GEO_DEFENSE_DOWN]        = { divisor =  60.81, minPotency = 2.7, maxPotency = 14.8, geoModMultiplier = 2.7 },
    [xi.effect.GEO_MAGIC_ATK_DOWN]      = { divisor =  45.00, minPotency = 5.0, maxPotency = 20.0, geoModMultiplier = 4.0 },
    [xi.effect.GEO_MAGIC_DEF_DOWN]      = { divisor =  60.00, minPotency = 3.0, maxPotency = 15.0, geoModMultiplier = 3.0 },
    [xi.effect.GEO_ACCURACY_DOWN]       = { divisor =  13.84, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 6.0 },
    [xi.effect.GEO_EVASION_DOWN]        = { divisor =  18.00, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0 },
    [xi.effect.GEO_MAGIC_ACC_DOWN]      = { divisor =  13.84, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 6.0 },
    [xi.effect.GEO_MAGIC_EVASION_DOWN]  = { divisor =  18.00, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0 },
    [xi.effect.GEO_SLOW]                = { divisor =  60.4,  minPotency = 0.9, maxPotency = 14.9, geoModMultiplier = 0.5 },
    [xi.effect.GEO_PARALYSIS]           = { divisor =  60.00, minPotency = 1.0, maxPotency = 15.0, geoModMultiplier = 1.0 },
    [xi.effect.GEO_WEIGHT]              = { divisor =  45.22, minPotency = 3.9, maxPotency = 19.9, geoModMultiplier = 1.1 },
    [xi.effect.GEO_HASTE]               = { divisor =  30.1,  minPotency = 2.4, maxPotency = 29.9, geoModMultiplier = 1.1 },
}

local function getLuopan(player)
    local pet = player:getPet()

    if pet and pet:getPetID() == xi.petId.LUOPAN then
        return pet
    end

    return nil
end

local function hasLuopan(player)
    return getLuopan(player) and true or false
end

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.geomancer.geoOnAbilityCheck = function(player, target, ability)
    if hasLuopan(player) then
        return 0, 0
    end

    if ability == xi.jobAbility.LIFE_CYCLE then
        if player:getHP() <= 2 then
            return xi.msg.basic.UNABLE_TO_USE_JA
        end
    end

    return xi.msg.basic.REQUIRE_LUOPAN, 0
end

xi.job_utils.geomancer.geoOnLifeCycleAbilityCheck = function(player, target, ability)
    if not hasLuopan(player) then
        return xi.msg.basic.REQUIRE_LUOPAN, 0
    end

    if player:getHP() <= 2 then
        return xi.msg.basic.UNABLE_TO_USE_JA
    end

    return 0, 0
end

-----------------------------------
-- GEO/INDI Potency Function
-----------------------------------
local function getEffectPotency(player, effect)
    -- Note: only one 'Geomancy +' item takes effect so highest value on a single item wins.
    -- Potency from a skill level perspective caps out once your combined hand bell skill and geomancy skill reaches 900.
    local geoSkill      = player:getSkillLevel(xi.skill.GEOMANCY)
    local handbellSkill = player:getSkillLevel(xi.skill.HANDBELL)
    local geomancyMod   = 0

    if player:getObjType() ~= xi.objType.PC then
        geoSkill      = player:getMod(xi.mod.GEOMANCY_SKILL)
        geomancyMod   = player:getMod(xi.mod.GEOMANCY_BONUS)
    else
        geomancyMod = player:getMaxGearMod(xi.mod.GEOMANCY_BONUS)
    end

    if
        player:getEquipID(xi.slot.RANGED) == 0 or
        player:getWeaponSkillType(xi.slot.RANGED) ~= xi.skill.HANDBELL
    then
        handbellSkill = 0
    end

    local combinedSkillLevel = utils.clamp(handbellSkill + geoSkill, 0, 900)
    local divisor            = xi.job_utils.geomancer.potencyData[effect].divisor
    local minPotency         = xi.job_utils.geomancer.potencyData[effect].minPotency
    local maxPotency         = xi.job_utils.geomancer.potencyData[effect].maxPotency
    local geoModMultiplier   = xi.job_utils.geomancer.potencyData[effect].geoModMultiplier
    -- simple linear regression between min and max potency, utlizing the pre-defined divisor
    local potency            = utils.clamp(minPotency + math.floor(combinedSkillLevel / divisor), minPotency, maxPotency)

    if geomancyMod > 0 and not player:hasStatusEffect(xi.effect.ENTRUST) then
        -- Geomancy bonus is a mod value * the multiplier then added to the final potency of the effect
        potency = potency + (geomancyMod * geoModMultiplier)
    end

    -- Boost potency calculations for Haste/Slow into the no-longer-human-readable-format
    if effect == xi.effect.GEO_HASTE or effect == xi.effect.GEO_SLOW then
        potency = potency * 100
    end

    -- at this point, potency should be an integer mod value
    return math.floor(potency)
end

-----------------------------------
-- Check for Widened Compass
-- Apply mod as needed
-----------------------------------
local function windenedCompassCheck(player)
    -- As the extended range does not change on an active indi spell if Widened Compass wears,
    -- we need to set this mod each time we cast an indi spell to affect the aura range,
    -- this is because we cannot delete the mod on onEffectLose or the range will reduce after a tick
    if player:hasStatusEffect(xi.effect.WIDENED_COMPASS) then
        player:setMod(xi.mod.AURA_SIZE, 625)
    else
        player:setMod(xi.mod.AURA_SIZE, 0)
    end
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.geomancer.bolster = function(player, target, ability)
    local bonusTime = player:getMod(xi.mod.BOLSTER_EFFECT)
    player:addStatusEffect(xi.effect.BOLSTER, 0, 3, 240 + bonusTime)
end

xi.job_utils.geomancer.fullCircle = function(player, target, ability)
    local hppRemaining = target:getHPP()
    local mpCost       = player:getLocalVar('MP_COST')
    local fcMerit      = player:getMerit(xi.merit.FULL_CIRCLE_EFFECT)
    local crMerit      = player:getMerit(xi.merit.CURATIVE_RECANTATION)
    local fcMod        = player:getMod(xi.mod.FULL_CIRCLE)
    local crMod        = player:getMod(xi.mod.CURATIVE_RECANTATION)
    local mpMultiplier = 0.5 + (fcMerit / 10) + (fcMod / 10)
    local hpMultiplier = 0.5 + (0.7 * crMerit) + (crMod / 10)
    local mpReturned   = 0
    local hpReturned   = 0

    -- calculate final mp value
    mpReturned = math.floor(mpMultiplier * mpCost * (hppRemaining / 100))

    if crMerit > 0 then
        -- calculate final hp value
        hpReturned = math.floor(hpMultiplier * mpCost * (hppRemaining / 100))
        player:restoreHP(hpReturned)
    end

    player:restoreMP(mpReturned)
    player:despawnPet()
end

xi.job_utils.geomancer.lastingEmanation = function(player, target, ability)
    local hpDrain = target:getMod(xi.mod.REGEN_DOWN)
    target:setMod(xi.mod.REGEN_DOWN, hpDrain - math.floor(target:getMainLvl() / 14))
end

xi.job_utils.geomancer.eclipticAttrition = function(player, target, ability)
    local hpDrain = target:getMod(xi.mod.REGEN_DOWN)
    target:setMod(xi.mod.REGEN_DOWN, hpDrain + math.floor(target:getMainLvl() / 16))

    if player:hasStatusEffect(xi.effect.BOLSTER) then
        return
    end

    local potency = target:getStatusEffect(xi.effect.COLURE_ACTIVE):getSubPower()
    local bonusPotency = 0.25 * potency
    local finalPotency = potency + bonusPotency
    target:getStatusEffect(xi.effect.COLURE_ACTIVE):setSubPower(finalPotency)
end

xi.job_utils.geomancer.collimatedFervor = function(player, target, ability) -- TODO: cardinal direction stuff
end

xi.job_utils.geomancer.lifeCycle = function(player, target, ability)
    local hpAmount    = math.floor(0.25 * player:getHP())
    local hpTransfer = hpAmount

    if player:getMod(xi.mod.LIFE_CYCLE_EFFECT) > 0 then
        hpTransfer = hpAmount * (player:getMod(xi.mod.LIFE_CYCLE_EFFECT) / 10)
    end

    target:restoreHP(hpTransfer)
    player:delHP(hpAmount)
    return hpTransfer
end

xi.job_utils.geomancer.blazeOfGlory = function(player, target, ability)
    player:addStatusEffect(xi.effect.BLAZE_OF_GLORY, 0, 3, 60)
end

xi.job_utils.geomancer.dematerialize = function(player, target, ability)
    target:addStatusEffect(xi.effect.DEMATERIALIZE, 0, 3, 60)
    return xi.effect.DEMATERIALIZE
end

xi.job_utils.geomancer.theugicFocus = function(player, target, ability) -- TODO: cardinal direction stuff
end

xi.job_utils.geomancer.widenedCompass = function(player, target, ability)
    player:addStatusEffect(xi.effect.WIDENED_COMPASS, 0, 3, 60)
end

-----------------------------------
-- Magic Casting Checks
-----------------------------------
xi.job_utils.geomancer.indiOnMagicCastingCheck = function(caster, target, spell)
    -- No checks known as of yet
    return 0
end

xi.job_utils.geomancer.geoOnMagicCastingCheck = function(caster, target, spell)
    if hasLuopan(caster) then
        return xi.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end

-----------------------------------
-- Aura Function
-- duration:   Length of the aura effect, not ticks of the aura's effect
--             0 = does not wear off
-- tickEffect: The effect being granted/imposed by the aura
--             Use xi.effect table: xi.effect.GEO_POISON for example,
--               but doesn't _need_ to be a GEO_ effect)
-- tickPower:  The power of the tick (healing amount, damage amount, etc.)
-- targetType: Target allies or enemies with:
--             xi.auraTarget.ALLIES or xi.auraTarget.ENEMIES
-----------------------------------
xi.job_utils.geomancer.addAura = function(target, duration, tickEffect, tickPower, targetType)
    target:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, 0, 3, duration, tickEffect, tickPower, targetType, xi.effectFlag.AURA)
end

-----------------------------------
-- Indi Spell Function
-----------------------------------
xi.job_utils.geomancer.doIndiSpell = function(caster, target, spell)
    local spellID      = spell:getID()
    local effect       = xi.job_utils.geomancer.indiData[spellID].effect
    local potency      = getEffectPotency(caster, effect)
    local targetType   = xi.job_utils.geomancer.indiData[spellID].targetType
    local visualEffect = xi.job_utils.geomancer.indiData[spellID].visualEffect
    local duration = 180 + caster:getMod(xi.mod.INDI_DURATION)

    -- set a local var to adjust potency values after an ability has worn off
    target:setLocalVar('INDI_POTENCY', potency)

    if target:hasStatusEffect(xi.effect.BOLSTER) then
        potency = potency * 2
    end

    windenedCompassCheck(caster)

    target:addStatusEffectEx(xi.effect.COLURE_ACTIVE, xi.effect.COLURE_ACTIVE, visualEffect, 3, duration, effect, potency, targetType, xi.effectFlag.AURA)

    if caster:hasStatusEffect(xi.effect.ENTRUST) then
        caster:delStatusEffectSilent(xi.effect.ENTRUST)
    end

    return effect
end

-----------------------------------
-- Spawn Luopan Function
-----------------------------------
xi.job_utils.geomancer.spawnLuopan = function(player, target, spell)
    if target then
        xi.pet.spawnPet(player, xi.petId.LUOPAN)
    else
        return
    end

    local luopan       = player:getPet()
    local spellID      = spell:getID()
    local modelID      = xi.job_utils.geomancer.geoData[spellID].luopanModel
    local effect       = xi.job_utils.geomancer.geoData[spellID].effect
    local potency      = getEffectPotency(player, effect)
    local finalPotency = potency
    local targetType   = xi.job_utils.geomancer.geoData[spellID].targetType
    local bolsterValue = 0

    -- set a local var to adjust potency values after an ability has worn off
    luopan:setLocalVar('GEO_POTENCY', potency)

    if player:hasStatusEffect(xi.effect.BLAZE_OF_GLORY) then
        finalPotency = potency + 0.5 * potency
    end

    if player:hasStatusEffect(xi.effect.BOLSTER) then
        finalPotency = potency * 2
    end

    windenedCompassCheck(player)

    -- Attach effect
    xi.job_utils.geomancer.addAura(luopan, 0, effect, finalPotency, targetType)

    -- Save the mp cost for use with Full Circle on the luopan
    player:setLocalVar('MP_COST', spell:getMPCost())

    -- Change the luopans appearance to match the effect
    luopan:setModelId(modelID)

    -- get the job point value of BOLSTER_EFFECT if Bolster is active
    if player:hasStatusEffect(xi.effect.BOLSTER) then
        bolsterValue = player:getJobPointLevel(xi.jp.BOLSTER_EFFECT)
    end

    if player:hasStatusEffect(xi.effect.BLAZE_OF_GLORY) then
        player:delStatusEffect(xi.effect.BLAZE_OF_GLORY)
        luopan:setHP((luopan:getMaxHP() / 2) + (luopan:getMaxHP() * (0.01 * player:getJobPointLevel(xi.jp.BLAZE_OF_GLORY_EFFECT))))
    end

    -- Set HP loss over time
    luopan:addMod(xi.mod.REGEN_DOWN, math.floor(luopan:getMainLvl() / 4) - bolsterValue)

    -- Innate Damage Taken -50%
    luopan:addMod(xi.mod.DMG, -5000)
end

-----------------------------------
-- Ability Effect Gain Adjustments
-----------------------------------
xi.job_utils.geomancer.bolsterOnEffectGain = function(target, effect)
    -- Luopans need to be recast to add this effect to them so we ignore them here
    if target:hasStatusEffect(xi.effect.COLURE_ACTIVE) then
        local indiPotency = target:getLocalVar('INDI_POTENCY')
        target:getStatusEffect(xi.effect.COLURE_ACTIVE):setSubPower(indiPotency * 2)
    end
end

-----------------------------------
-- Ability Effect Wear Adjustments
-----------------------------------
xi.job_utils.geomancer.bolsterOnEffectLose = function(target, effect)
    local bolsterJP = target:getJobPointLevel(xi.jp.BOLSTER_EFFECT)
    local pet       = target:getPet()

    -- Luopan Geo effect
    if pet and pet:getPetID() == xi.petId.LUOPAN then
        local geoPotency     = pet:getLocalVar('GEO_POTENCY')
        local currentPotency = pet:getStatusEffect(xi.effect.COLURE_ACTIVE):getSubPower()
        if currentPotency == geoPotency * 2 then -- will always be this value with Bolster or Blaze of Glory active
            pet:getStatusEffect(xi.effect.COLURE_ACTIVE):setSubPower(geoPotency)
            pet:setMod(xi.mod.REGEN_DOWN, pet:getMod(xi.mod.REGEN_DOWN) + bolsterJP)
        end
    end

    -- Player Indi effect
    if target:hasStatusEffect(xi.effect.COLURE_ACTIVE) then
        local indiPotency = target:getLocalVar('INDI_POTENCY')
        local currentPotency = target:getStatusEffect(xi.effect.COLURE_ACTIVE):getSubPower()
        if currentPotency == indiPotency * 2 then -- will always be this value with Bolster active
            target:getStatusEffect(xi.effect.COLURE_ACTIVE):setSubPower(indiPotency)
        end
    end
end
