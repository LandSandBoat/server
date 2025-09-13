-----------------------------------
-- Pet Global Functions
-----------------------------------
require('scripts/globals/nyzul/pathos')
-----------------------------------
xi = xi or {}
xi.pet = xi.pet or {}

local avatarPetIDs = set{
    xi.petId.CARBUNCLE,
    xi.petId.FENRIR,
    xi.petId.IFRIT,
    xi.petId.TITAN,
    xi.petId.LEVIATHAN,
    xi.petId.GARUDA,
    xi.petId.SHIVA,
    xi.petId.RAMUH,
    xi.petId.DIABOLOS,
    xi.petId.ALEXANDER,
    xi.petId.ODIN,
    xi.petId.ATOMOS,
    xi.petId.CAIT_SITH,
    xi.petId.SIREN,
}

local onMasterDeath = function(mob)
    local pet = mob:getPet()
    if pet ~= nil and pet:isAlive() then
        if not pet:isEngaged() then
            DespawnMob(pet:getID(), 2)
        end
    end
end

local astralOnlySpellIDs = set{
    xi.magic.spell.ODIN,
    xi.magic.spell.ALEXANDER,
}

---@param target CBaseEntity
---@param mob CBaseEntity
---@param skill CMobSkill
---@return number
xi.pet.onMobSkillCheck = function(target, mob, skill)
    -- block mobskill if mob doesn't have an assigned pet or pet is currently spawned
    if mob:getPet() == nil or mob:hasPet() then
        return 1
    end

    return 0
end

---@param caster CBaseEntity
---@param target CBaseEntity
---@param spell CSpell
---@return number
xi.pet.onCastingCheck = function(caster, target, spell)
    local result = 0

    if caster:hasPet() then
        result = xi.msg.basic.ALREADY_HAS_A_PET
    elseif
        astralOnlySpellIDs[spell:getID()] and
        not caster:hasStatusEffect(xi.effect.ASTRAL_FLOW)
    then
        result = xi.msg.basic.MAGIC_MUST_ASTRAL_FLOW
    elseif not caster:canUseMisc(xi.zoneMisc.PET) then
        result = xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif caster:getObjType() == xi.objType.PC then
        result = xi.summon.avatarMiniFightCheck(caster, spell:getID())
    else
        -- non-pc without an attached pet
        if caster:getPet() == nil then
            result = 1
        end
    end

    return result
end

---@param caster CBaseEntity
---@param petID number?
---@param state CSpell|CMobSkill?
---@param target CBaseEntity?
---@return nil
xi.pet.spawnPet = function(caster, petID, state, target)
    caster:spawnPet(petID)

    -- mobs don't emit message when using call beast/wyvern, activate, or summoner spells
    if caster:getObjType() ~= xi.objType.PC and state then
        state:setMsg(xi.msg.basic.NONE)

        if state:getID() == xi.mobSkill.CALL_BEAST then
            -- bst mob pets despawn if not engaged when owner leaves
            caster:addListener('DEATH', 'BEASTMASTER_DEATH', onMasterDeath)
            caster:addListener('DESPAWN', 'BEASTMASTER_DESPAWN', onMasterDeath)
        end
    end

    if avatarPetIDs[petID] then
        local effect = caster:getStatusEffect(xi.effect.AVATARS_FAVOR)
        if effect then
            effect:setPower(1) -- resummon resets effect
            xi.avatarsFavor.applyAvatarsFavorAuraToPet(caster, effect)
            xi.avatarsFavor.applyAvatarsFavorDebuffsToPet(caster)
        end

        if petID == xi.petId.ALEXANDER then
            -- Use Perfect Defense 5 seconds after spawning.
            local pet = caster:getPet()
            if pet then
                pet:timer(5000, function()
                    pet:usePetAbility(xi.jobAbility.PERFECT_DEFENSE, pet)
                end)
            end
        elseif petID == xi.petId.ODIN then
            if target then
                caster:petAttack(target)
            end
        end
    end

    -- Nyzul Isle has Pathos set randomly on floors and is recorded as bits in a localvar of the instance
    if caster:getZoneID() == xi.zone.NYZUL_ISLE then
        xi.nyzul.addPetSpawnPathos(caster)
    end
end
