-----------------------------------
-- Geomancer Job Utilities
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/spell_data")
require("scripts/globals/msg")
require("scripts/globals/pets")
require("scripts/globals/weaponskills")
require("scripts/globals/jobpoints")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.geomancer = xi.job_utils.geomancer or {}
-----------------------------------

local loupanModels =
{
    fire    = 2850,
    ice     = 2851,
    wind    = 2852,
    earth   = 2853,
    thunder = 2854,
    water   = 2855,
    light   = 2856,
    dark    = 2865,
}

local geoData =
{
    [xi.magic.spell.GEO_REGEN]      = {luopanModel = loupanModels.light,   effect = xi.effect.GEO_REGEN,               targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_POISON]     = {luopanModel = loupanModels.water,   effect = xi.effect.GEO_POISON,              targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_REFRESH]    = {luopanModel = loupanModels.light,   effect = xi.effect.GEO_REFRESH,             targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_HASTE]      = {luopanModel = loupanModels.wind,    effect = xi.effect.GEO_HASTE,               targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_STR]        = {luopanModel = loupanModels.fire,    effect = xi.effect.GEO_STR_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_DEX]        = {luopanModel = loupanModels.thunder, effect = xi.effect.GEO_DEX_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_VIT]        = {luopanModel = loupanModels.earth,   effect = xi.effect.GEO_VIT_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_AGI]        = {luopanModel = loupanModels.wind,    effect = xi.effect.GEO_AGI_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_INT]        = {luopanModel = loupanModels.ice,     effect = xi.effect.GEO_INT_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_MND]        = {luopanModel = loupanModels.water,   effect = xi.effect.GEO_MND_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_CHR]        = {luopanModel = loupanModels.light,   effect = xi.effect.GEO_CHR_BOOST,           targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_FURY]       = {luopanModel = loupanModels.fire,    effect = xi.effect.GEO_ATTACK_BOOST,        targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_BARRIER]    = {luopanModel = loupanModels.earth,   effect = xi.effect.GEO_DEFENSE_BOOST,       targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_ACUMEN]     = {luopanModel = loupanModels.ice,     effect = xi.effect.GEO_MAGIC_ATK_BOOST,     targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_FEND]       = {luopanModel = loupanModels.water,   effect = xi.effect.GEO_MAGIC_DEF_BOOST,     targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_PRECISION]  = {luopanModel = loupanModels.thunder, effect = xi.effect.GEO_ACCURACY_BOOST,      targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_VOIDANCE]   = {luopanModel = loupanModels.wind,    effect = xi.effect.GEO_EVASION_BOOST,       targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_FOCUS]      = {luopanModel = loupanModels.dark,    effect = xi.effect.GEO_MAGIC_ACC_BOOST,     targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_ATTUNEMENT] = {luopanModel = loupanModels.light,   effect = xi.effect.GEO_MAGIC_EVASION_BOOST, targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.GEO_WILT]       = {luopanModel = loupanModels.water,   effect = xi.effect.GEO_ATTACK_DOWN,         targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_FRAILTY]    = {luopanModel = loupanModels.wind,    effect = xi.effect.GEO_DEFENSE_DOWN,        targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_FADE]       = {luopanModel = loupanModels.fire,    effect = xi.effect.GEO_MAGIC_ATK_DOWN,      targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_MALAISE]    = {luopanModel = loupanModels.thunder, effect = xi.effect.GEO_MAGIC_DEF_DOWN,      targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_SLIP]       = {luopanModel = loupanModels.earth,   effect = xi.effect.GEO_ACCURACY_DOWN,       targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_TORPOR]     = {luopanModel = loupanModels.ice,     effect = xi.effect.GEO_EVASION_DOWN,        targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_VEX]        = {luopanModel = loupanModels.light,   effect = xi.effect.GEO_MAGIC_ACC_DOWN,      targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_LANGUOR]    = {luopanModel = loupanModels.dark,    effect = xi.effect.GEO_MAGIC_EVASION_DOWN,  targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_SLOW]       = {luopanModel = loupanModels.earth,   effect = xi.effect.GEO_SLOW,                targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_PARALYSIS]  = {luopanModel = loupanModels.ice,     effect = xi.effect.GEO_PARALYSIS,           targetType = xi.auraTarget.ENEMIES},
    [xi.magic.spell.GEO_GRAVITY]    = {luopanModel = loupanModels.wind,    effect = xi.effect.GEO_WEIGHT,              targetType = xi.auraTarget.ENEMIES},
}

local indiData =
{
    [xi.magic.spell.INDI_REGEN]  = {effect = xi.effect.GEO_REGEN,               targetType = xi.auraTarget.ALLIES },
    [xi.magic.spell.INDI_POISON] = {effect = xi.effect.GEO_POISON,              targetType = xi.auraTarget.ENEMIES},
}


local potencyData =
{
    [xi.effect.GEO_REGEN]               = {divisor =  20, minPotency = 1.0, maxPotency = 30.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_POISON]              = {divisor =  20, minPotency = 1.0, maxPotency = 30.0, geoModMultiplier = 3.0},
    [xi.effect.GEO_REFRESH]             = {divisor = 120, minPotency = 1.0, maxPotency =  6.0, geoModMultiplier = 1.0},
    [xi.effect.GEO_STR_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_DEX_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_VIT_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_AGI_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_INT_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_MND_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_CHR_BOOST]           = {divisor =  37, minPotency = 1.0, maxPotency = 25.0, geoModMultiplier = 2.0},
    [xi.effect.GEO_ATTACK_BOOST]        = {divisor =  30, minPotency = 4.6, maxPotency = 34.7, geoModMultiplier = 2.7},
    [xi.effect.GEO_DEFENSE_BOOST]       = {divisor =  30, minPotency = 9.7, maxPotency = 39.8, geoModMultiplier = 4.6},
    [xi.effect.GEO_MAGIC_ATK_BOOST]     = {divisor =  75, minPotency = 3.0, maxPotency = 15.0, geoModMultiplier = 3.0},
    [xi.effect.GEO_MAGIC_DEF_BOOST]     = {divisor =  60, minPotency = 5.0, maxPotency = 20.0, geoModMultiplier = 4.0},
    [xi.effect.GEO_ACCURACY_BOOST]      = {divisor =  18, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0},
    [xi.effect.GEO_EVASION_BOOST]       = {divisor =  14, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 5.0},
    [xi.effect.GEO_MAGIC_ACC_BOOST]     = {divisor =  18, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0},
    [xi.effect.GEO_MAGIC_EVASION_BOOST] = {divisor =  14, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 6.0},
    [xi.effect.GEO_ATTACK_DOWN]         = {divisor =  44, minPotency = 4.6, maxPotency = 25.0, geoModMultiplier = 4.6},
    [xi.effect.GEO_DEFENSE_DOWN]        = {divisor =  74, minPotency = 2.7, maxPotency = 14.8, geoModMultiplier = 2.7},
    [xi.effect.GEO_MAGIC_ATK_DOWN]      = {divisor =  60, minPotency = 5.0, maxPotency = 20.0, geoModMultiplier = 4.0},
    [xi.effect.GEO_MAGIC_DEF_DOWN]      = {divisor =  75, minPotency = 3.0, maxPotency = 15.0, geoModMultiplier = 3.0},
    [xi.effect.GEO_ACCURACY_DOWN]       = {divisor =  14, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 6.0},
    [xi.effect.GEO_EVASION_DOWN]        = {divisor =  18, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0},
    [xi.effect.GEO_MAGIC_ACC_DOWN]      = {divisor =  14, minPotency = 1.0, maxPotency = 65.0, geoModMultiplier = 6.0},
    [xi.effect.GEO_MAGIC_EVASION_DOWN]  = {divisor =  18, minPotency = 1.0, maxPotency = 50.0, geoModMultiplier = 5.0},
    [xi.effect.GEO_SLOW]                = {divisor =  64, minPotency = 0.9, maxPotency = 14.9, geoModMultiplier = 0.5},
    [xi.effect.GEO_PARALYSIS]           = {divisor =  64, minPotency = 1.0, maxPotency = 15.0, geoModMultiplier = 1.0},
    [xi.effect.GEO_WEIGHT]              = {divisor =  56, minPotency = 3.9, maxPotency = 19.9, geoModMultiplier = 1.1},
    [xi.effect.GEO_HASTE]               = {divisor =  30, minPotency = 2.4, maxPotency = 29.9, geoModMultiplier = 1.1},
}

xi.job_utils.geomancer.geoOnAbilityCheck = function(player, target, ability)
    if player:getPetID() == xi.pet.id.LUOPAN then
        return 0,0
    end
    return xi.msg.basic.REQUIRE_LUOPAN, 0
end

xi.job_utils.geomancer.indiOnMagicCastingCheck = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.COLURE_ACTIVE) then
        local effect = target:getStatusEffect(xi.effect.COLURE_ACTIVE)
        caster:PrintToPlayer(string.format("aura effect: (%i)", indiData[spell:getID()].effect), 15)
        if effect:getSubType() == indiData[spell:getID()].effect then
            return xi.msg.basic.EFFECT_ALREADY_ACTIVE
        end
    end
    return 0
end

xi.job_utils.geomancer.geoOnMagicCastingCheck = function(caster, target, spell)
    if caster:getPetID() == xi.pet.id.LUOPAN then
        return xi.msg.basic.LUOPAN_ALREADY_PLACED
    elseif not caster:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    else
        return 0
    end
end

local function getEffectPotency(player, effect)
    -- Note: only one "Geomancy +" item takes effect so highest value on a single item wins.
    -- Potency from a skill level perspective caps out once your combined hand bell skill and geomancy skill reaches 900.
    -- Anything over that is unneeded and adds nothing
    local geoSkill      = player:getSkillLevel(xi.skill.GEOMANCY)
    local handbellSkill = player:getSkillLevel(xi.skill.HANDBELL)
    local geomancyMod   = player:getEquippedItemsMaxModValue(xi.mod.GEOMANCY_BONUS) --getMod(xi.mod.GEOMANCY_BONUS)

    if  player:getEquipID(xi.slot.RANGED) == 0 or player:getWeaponSkillType(xi.slot.RANGED) ~= xi.skill.HANDBELL then
        handbellSkill = 0
    end

    player:PrintToPlayer(string.format("Geo Skill: (%i), Handbell Skill: (%i), Geomancy Mod: (%i)",geoSkill, handbellSkill, geomancyMod), 15)

    local combinedSkillLevel = utils.clamp(handbellSkill + geoSkill, 0, 900)
    local divisor            = potencyData[effect].divisor
    local minPotency         = potencyData[effect].minPotency
    local maxPotency         = potencyData[effect].maxPotency
    local potency            = utils.clamp(combinedSkillLevel / divisor, minPotency, maxPotency)

    if geomancyMod > 0 then
        -- Geomancy bonus is a mod value * the multiplier then added to the final potency of the effect
        potency = potency + (geomancyMod * potencyData[effect].geoModMultiplier)
    end

    return math.floor(potency)
end

-----------------------------------
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

xi.job_utils.geomancer.doIndiSpell = function(caster, target, spell)
    local spellID      = spell:getID()
    local effect       = indiData[spellID].effect
    local potency      = getEffectPotency(caster, effect)
    local targetType   = indiData[spellID].targetType
    local duration = 180 -- TODO: add mod for duration

    xi.job_utils.geomancer.addAura(target, duration, effect, potency, targetType)
    caster:PrintToPlayer(string.format("Potency: (%i)", potency), 15)
    return xi.effect.COLURE_ACTIVE
end


xi.job_utils.geomancer.spawnLuopan = function(player, target, spell)
    if target then
        xi.pet.spawnPet(player, xi.pet.id.LUOPAN)
    else
        return
    end

    local luopan     = player:getPet()
    local spellID    = spell:getID()
    local modelID    = geoData[spellID].luopanModel
    local effect     = geoData[spellID].effect
    local potency    = getEffectPotency(player, effect)
    local targetType = geoData[spellID].targetType

    player:PrintToPlayer(string.format("Potency: (%i)", potency), 15)

    -- Attach effect
    xi.job_utils.geomancer.addAura(luopan, 0, effect, potency, targetType)

    -- Save the mp cost for use with Full Circle on the luopan
    luopan:setLocalVar("MP_COST", spell:getMPCost())

    -- Change the luopans appearance to match the effect
    -- TODO: This is should be the element of the spell being cast added as an offset
    -- on top of a base model ID in core.
    luopan:setModelId(modelID)

    -- Set HP loss over time
    luopan:addMod(xi.mod.REGEN_DOWN, luopan:getMainLvl() / 4)

    -- Innate Damage Taken -50%
    luopan:addMod(xi.mod.DMG, -5000)
end
