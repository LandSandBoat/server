-----------------------------------
-- Pet Global Functions
-----------------------------------
require('scripts/globals/nyzul/pathos')
-----------------------------------
xi = xi or {}
xi.pet = xi.pet or {}

local avatarPetIDs = set
{
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

local astralOnlySpellIDs = set
{
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

-- TODO should charmed entities lose their buffs when they become uncharmed?
xi.pet.applyFamiliarBuffs = function(owner, pet)
    if
        not owner or
        not pet or
        not pet:isAlive() or
        pet:getLocalVar('hasFamiliarBuffs') ~= 0
    then
        return
    end

    pet:setLocalVar('hasFamiliarBuffs', 1)

    local familiarBonus = owner:getMod(xi.mod.FAMILIAR_BONUS)
    if
        owner:isPC() and
        pet:isCharmed()
    then
        -- extends duration by 25m-30m
        local minSeconds = 25 * 60
        local maxSeconds = 30 * 60
        local bonusSeconds = familiarBonus * 60
        pet:extendCharm(minSeconds + bonusSeconds, maxSeconds + bonusSeconds)
    end

    if familiarBonus > 0 then
        pet:addMod(xi.mod.HASTE_ABILITY, familiarBonus * 100)
    end

    local familiarBoost = 10
    local familiarBoostPerc = familiarBoost / 100
    local addedHP = pet:getMaxHP() * familiarBoostPerc
    pet:setMaxHP(pet:getMaxHP() + addedHP) -- technically BASE_HP mod is added back to generate modhp, but close enough
    -- wakes up pets
    pet:addHP(addedHP)

    -- adds % bonuses to the following stats
    -- TODO are these the only stats boosted?
    pet:addMod(xi.mod.ATTP, familiarBoost)
    pet:addMod(xi.mod.RATTP, familiarBoost)
    pet:addMod(xi.mod.DEFP, familiarBoost)
    pet:addMod(xi.mod.ACC, pet:getMod(xi.mod.ACC) * familiarBoostPerc)
    pet:addMod(xi.mod.RACC, pet:getMod(xi.mod.RACC) * familiarBoostPerc)
    pet:addMod(xi.mod.EVA, pet:getMod(xi.mod.EVA) * familiarBoostPerc)

    -- TODO does familiar give some bonus resistance to crowd control? Is it only for mob pets?
    -- Lots of reports of mobs using Familiar and the pet having higher chance to resist bind/sleep/etc
end

-- Assigns a pet to the "mob" parameter by adding "offset" to the mob's ID
-- will bail out if the offset mob's name doesn't match "petName" parameter, as a sanity check for ID shifts or mobs that have multiple job types in the same zone
---@param mob CBaseEntity
---@param offset number
---@param petName string
---@return nil
xi.pet.setMobPet = function(mob, offset, petName)
    if not mob or mob:getObjType() ~= xi.objType.MOB then
        return
    end

    local pet = GetMobByID(mob:getID() + offset)
    if not pet or pet:getName() ~= petName then
        return
    end

    if pet:getMaster() or mob:getPet() then
        return
    end

    -- pet is always spawned by master
    DisallowRespawn(pet:getID(), true)
    if not mob:isSpawned() and pet:isSpawned() then
        DespawnMob(pet:getID(), 2)
    end

    -- link mob and pet for things like call_beast, summon elemental, etc
    mob:setPet(pet)
end
