-----------------------------------
-- Astral Flow
-- make existing pet use astral flow skill
-----------------------------------
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
    -- must have pet
    if not mob:hasPet() then
        return 1
    end

    local pet = mob:getPet()

    -- pet must be an avatar, and active
    if pet:getEcosystem() ~= 5 or petInactive(pet) then
        return 1
    end

    return 0
end

-- [mobskillId] = { petFamily1, petFamily2, ... }
local petAstralFlowAbility =
{
    [839] = { 36, 381 }, -- Fenrir (Howling Moon)
    [913] = { 38, 383 }, -- Ifrit (Inferno)
    [914] = { 45, 388 }, -- Titan (Earthen Fury)
    [915] = { 40, 384 }, -- Leviathan (Tidal Wave)
    [916] = { 37, 382 }, -- Garuda (Aerial Blast)
    [917] = { 44, 387 }, -- Shiva (Diamond Dust)
    [918] = { 43, 386 }, -- Ramuh (Judgment Bolt)
    [919] = { 34, 379 }, -- Carbuncle (Searing Light)
}

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local pet = mob:getPet()

    skill:setMsg(xi.msg.basic.USES)

    -- no effect if pet is inactive
    if petInactive(pet) then
        return xi.effect.ASTRAL_FLOW
    end

    -- Find proper pet skill
    local petFamily = pet:getFamily()
    local skillId   = 919 -- Default to Searing Light if not found below

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
