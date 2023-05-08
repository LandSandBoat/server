-----------------------------------
-- Astral Flow
-- make existing pet use astral flow skill
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
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

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local pet = mob:getPet()

    skill:setMsg(xi.msg.basic.USES)

    -- no effect if pet is inactive
    if petInactive(pet) then
        return xi.effect.ASTRAL_FLOW
    end

    -- Find proper pet skill
    local petFamily = pet:getFamily()
    local skillId = 0

    if     petFamily == 34 or petFamily == 379 then skillId = 919 -- carbuncle searing light
    elseif petFamily == 36 or petFamily == 381 then skillId = 839 -- fenrir    howling moon
    elseif petFamily == 37 or petFamily == 382 then skillId = 916 -- garuda    aerial blast
    elseif petFamily == 38 or petFamily == 383 then skillId = 913 -- ifrit     inferno
    elseif petFamily == 40 or petFamily == 384 then skillId = 915 -- leviathan tidal wave
    elseif petFamily == 43 or petFamily == 386 then skillId = 918 -- ramuh     judgment bolt
    elseif petFamily == 44 or petFamily == 387 then skillId = 917 -- shiva     diamond dust
    elseif petFamily == 45 or petFamily == 388 then skillId = 914 -- titan     earthen fury
    else
        printf("[astral_flow_pet] received unexpected pet family %i. Defaulted skill to Searing Light.", petFamily)
        skillId = 919 -- searing light
    end

    pet:useMobAbility(skillId)

    return xi.effect.ASTRAL_FLOW
end

return mobskillObject
