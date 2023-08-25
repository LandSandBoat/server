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

    if pet:getID() == mob:getID() then
        return 1
    end

    -- pet must be an avatar, and active
    if pet:getEcosystem() ~= 5 or petInactive(pet) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local pet = mob:getPet()

    skill:setMsg(xi.msg.basic.USES)

    -- no effect if pet is inactive
    if petInactive(pet) then
        return xi.effect.ASTRAL_FLOW
    end

    -- Find proper pet skill
    local petFamily = pet:getFamily()
    local modelId   = pet:getModelId()
    local skillId = 0

    if     petFamily == 45 or petFamily == 388 or modelId == 794 then -- 794
        skillId = 914 -- titan     earthen fury
    elseif petFamily == 44 or petFamily == 387 or modelId == 797 then -- 797
        skillId = 917 -- shiva     diamond dust
    elseif petFamily == 43 or petFamily == 386 or modelId == 798 then -- 798
        skillId = 918 -- ramuh     judgment bolt
    elseif petFamily == 40 or petFamily == 384 or modelId == 795 then -- 795
        skillId = 915 -- leviathan tidal wave
    elseif petFamily == 38 or petFamily == 383 or modelId == 793 then -- 793
        skillId = 913 -- ifrit     inferno
    elseif petFamily == 37 or petFamily == 382 or modelId == 796 then -- 796
        skillId = 916 -- garuda    aerial blast
    elseif petFamily == 36 or petFamily == 381 or modelId == 792 then -- 792
        skillId = 839 -- fenrir    howling moon
    elseif petFamily == 34 or petFamily == 379 or modelId == 791 then -- 791
        skillId = 919 -- carbuncle searing light
    else
        printf("[astral_flow_pet] received unexpected pet family %i. Defaulted skill to Searing Light.", petFamily)
        skillId = 919 -- searing light
    end

    pet:useMobAbility(skillId)

    return xi.effect.ASTRAL_FLOW
end

return mobskillObject
