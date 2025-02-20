-----------------------------------
-- Astral Flow
-- make existing pet use astral flow skill
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

local function petInactive(pet)
    return
        pet:hasStatusEffect(xi.effect.LULLABY) or
        pet:hasStatusEffect(xi.effect.STUN) or
        pet:hasStatusEffect(xi.effect.PETRIFICATION) or
        pet:hasStatusEffect(xi.effect.SLEEP_II) or
        pet:hasStatusEffect(xi.effect.SLEEP_I) or
        pet:hasStatusEffect(xi.effect.TERROR)
end

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local pet = mob:getPet()

    -- pet must be an avatar, and active
    if
        not pet or
        pet:getEcosystem() ~= 5 or
        petInactive(pet)
    then
        return 1
    end

    return 0
end

-- [mobskillId] = { petFamily1, petFamily2, ... }
local petAstralFlowAbility =
{
    [xi.mobSkill.HOWLING_MOON_2]  = { 36, 381 }, -- Fenrir (Howling Moon)
    [xi.mobSkill.INFERNO_1]       = { 38, 383 }, -- Ifrit (Inferno)
    [xi.mobSkill.EARTHEN_FURY_1]  = { 45, 388 }, -- Titan (Earthen Fury)
    [xi.mobSkill.TIDAL_WAVE_1]    = { 40, 384 }, -- Leviathan (Tidal Wave)
    [xi.mobSkill.AERIAL_BLAST_1]  = { 37, 382 }, -- Garuda (Aerial Blast)
    [xi.mobSkill.DIAMOND_DUST_1]  = { 44, 387 }, -- Shiva (Diamond Dust)
    [xi.mobSkill.JUDGMENT_BOLT_1] = { 43, 386 }, -- Ramuh (Judgment Bolt)
    [xi.mobSkill.SEARING_LIGHT_1] = { 34, 379 }, -- Carbuncle (Searing Light)
}

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local pet = mob:getPet()
    if not pet then
        return
    end

    skill:setMsg(xi.msg.basic.USES)

    -- no effect if pet is inactive
    if petInactive(pet) then
        return xi.effect.ASTRAL_FLOW
    end

    -- Find proper pet skill
    local petFamily = pet:getFamily()
    local skillId   = xi.mobSkill.SEARING_LIGHT_1 -- Default to Searing Light if not found below

    for mobSkillId, petFamilyList in pairs(petAstralFlowAbility) do
        if utils.contains(petFamily, petFamilyList) then
            skillId = mobSkillId
            break
        end
    end

    pet:useMobAbility(skillId)

    return xi.effect.ASTRAL_FLOW
end

return mobskillObject
