-----------------------------------
-- Avatars Favor helper
-----------------------------------
require("scripts/globals/pets")
require("scripts/globals/status")
require("scripts/settings/main")
-----------------------------------

xi = xi or {}
xi.avatarsFavor = xi.avatarsFavor or {}

xi.avatarsFavor.skill186Index = 6 -- 187 taken from wiki talk page
xi.avatarsFavor.skillDefaultIndex = 9
xi.avatarsFavor.skill317Index = 10

-- Avatar Favor buffs scale per tock (~9 seconds) to a max value based on current summoning skill
-- Index 1 is the initial value
-- Index 6 is the value for the low skill tier
-- Index 9 is the value for ~level 75, up to 317 skill
-- Index 10 is the value for having 318 or more skill
-- This can be extended for servers who are higher than 75 cap by adding additional values to the "arrays" and new skill tier logic (and Siren)
local avatarsFavorEffect =
{
    [xi.pet.id.CARBUNCLE] = -- Regen
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 14},
        effect = xi.effect.CARBUNCLES_FAVOR
    },
    [xi.pet.id.FENRIR] = -- Magic Eva
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = xi.effect.FENRIRS_FAVOR
    },
    [xi.pet.id.IFRIT] = -- Double Attack
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 15},
        effect = xi.effect.IFRITS_FAVOR
    },
    [xi.pet.id.TITAN] = -- Defense
    {
        scaling = {25, 28, 31, 35, 39, 43, 47, 52, 57, 62},
        effect = xi.effect.TITANS_FAVOR
    },
    [xi.pet.id.LEVIATHAN] = -- Magic Accuracy
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = xi.effect.LEVIATHANS_FAVOR
    },
    [xi.pet.id.GARUDA] = -- Evasion
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = xi.effect.GARUDAS_FAVOR
    },
    [xi.pet.id.SHIVA] = -- Magic Attack
    {
        scaling = {1, 2, 3, 4, 5, 7, 9, 12, 15, 18},
        effect = xi.effect.SHIVAS_FAVOR
    },
    [xi.pet.id.RAMUH] = -- Potency (Critical Hit+%)
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 15},
        effect = xi.effect.RAMUHS_FAVOR
    },
    [xi.pet.id.DIABOLOS] = -- Refresh
    {
        scaling = {1, 1, 1, 2, 2, 2, 3, 3, 3, 4},
        effect = xi.effect.DIABOLOSS_FAVOR
    },
    [xi.pet.id.CAIT_SITH] = -- Magic Defense
    {
        scaling = {1, 2, 3, 4, 5, 6, 8, 10, 12, 15},
        effect = xi.effect.CAIT_SITHS_FAVOR
    },
}

-------------------------------------------
-- Given a :getPetID petID (Not a getMobID)
-- Returns if Avatars Favor should be applied
-- This equates to is the pet not nil and should have avatars favor effect
-- Does not account for Siren
-------------------------------------------
local shouldAvatarsFavorBeApplied = function(petId)
    local shouldApply = false

    if petId and petId >= xi.pet.id.CARBUNCLE and petId <= xi.pet.id.DIABOLOS then
        shouldApply = true
    end

    if petId and petId == xi.pet.id.CAIT_SITH then
        shouldApply = true
    end

    return shouldApply
end

local removeAvatarsFavorDebuffsFromPet = function(target)
    local petId = target:getPetID()
    if  -- Different pet states for in and out of retail / eras
        shouldAvatarsFavorBeApplied(petId) and
        xi.settings.ENABLE_SOA == 1
    then
        local pet = target:getPet()
        pet:addMod(xi.mod.MATT, 20)
        pet:addMod(xi.mod.ATTP, 20)
        pet:addMod(xi.mod.ACC, 10)
        pet:addMod(xi.mod.DEFP, 10)
    end
end

xi.avatarsFavor.applyAvatarsFavorAuraToPet = function(target, effect)
    local petId = target:getPetID()
    if shouldAvatarsFavorBeApplied(petId) then
        local power = avatarsFavorEffect[petId].scaling[effect:getPower()]
        local avatarEffect = avatarsFavorEffect[petId].effect

        --Useful debug message
        --printf("Power %d, Effect %d", effect:getPower(), power)

        target:getPet():addStatusEffectEx(avatarEffect, avatarEffect, 6, 3, 15, avatarEffect, power, xi.auraTarget.ALLIES, bit.bor(xi.effectFlag.NO_LOSS_MESSAGE, xi.effectFlag.AURA))
    end
end

xi.avatarsFavor.removeAvatarsFavorAuraFromPet = function(target)
    local petId = target:getPetID()
    if shouldAvatarsFavorBeApplied(petId) then
        local pet = target:getPet()
        if pet:hasStatusEffect(avatarsFavorEffect[petId].effect) then
            pet:delStatusEffect(avatarsFavorEffect[petId].effect)
        end
        removeAvatarsFavorDebuffsFromPet(target)
    end
end

xi.avatarsFavor.applyAvatarsFavorDebuffsToPet = function(target)
    local petId = target:getPetID()
    if  -- Different pet states for in and out of retail / eras
        shouldAvatarsFavorBeApplied(petId) and
        xi.settings.ENABLE_SOA == 1
    then
        local pet = target:getPet()
        pet:delMod(xi.mod.MATT, 20) -- Other than MATT most of these values are myth and guesses from multiple sources
        pet:delMod(xi.mod.ATTP, 20)
        pet:delMod(xi.mod.ACC, 10)
        pet:delMod(xi.mod.DEFP, 10)
    end
end



