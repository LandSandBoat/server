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
    [839] = { 36, 381 }, -- Fenrir (Howling Moon)
    [848] = { 38, 383 }, -- Ifrit (Inferno)
    [857] = { 45, 388 }, -- Titan (Earthen Fury)
    [866] = { 40, 384 }, -- Leviathan (Tidal Wave)
    [875] = { 37, 382 }, -- Garuda (Aerial Blast)
    [884] = { 44, 387 }, -- Shiva (Diamond Dust)
    [893] = { 43, 386 }, -- Ramuh (Judgment Bolt)
    [912] = { 34, 379 }, -- Carbuncle (Searing Light)
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
    local skillId   = 912 -- Default to Searing Light if not found below

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
