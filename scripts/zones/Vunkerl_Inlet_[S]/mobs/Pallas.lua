-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas
-- Note: https://www.youtube.com/watch?v=UyW5XffUXJQ
--       TODO any immunities? seems to be none
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local pets =
{
    ID.mob.PALLAS + 1,
    ID.mob.PALLAS + 2,
    ID.mob.PALLAS + 3,
}

local callPetParams =
{
    inactiveTime = 3000,
    dieWithOwner = true,
    maxSpawns    = 1,
}

entity.phList =
{
    [ID.mob.PALLAS - 9] = ID.mob.PALLAS,
    [ID.mob.PALLAS - 4] = ID.mob.PALLAS,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Pallass_Tiger')
end

entity.onMobSpawn = function(mob)
    -- Do not use call_beast
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('petTimer') < GetSystemTime() and
        xi.mob.callPets(mob, pets, callPetParams)
    then
        mob:setLocalVar('petTimer', GetSystemTime() + 60) -- resummons a tiger every 60s
    end

    -- check if all pets are alive. If so, tap the petTimer variable
    local allPetsAlive = true
    for _, petId in ipairs(pets) do
        local pet = GetMobByID(petId)
        if pet and pet:isDead() then
            allPetsAlive = false
        end
    end

    if allPetsAlive then
        -- Summons another pet 60s after a pet dies when they're all alive
        mob:setLocalVar('petTimer', GetSystemTime() + 60)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Manually apply Familiar to all pets except first one
    if skill:getID() == xi.mobSkill.FAMILIAR_1 then
        for _, petId in ipairs(pets) do
            local pet = GetMobByID(petId)
            if
                pet and
                pet ~= mob:getPet() and -- base familiar mobskill buffs this one
                pet:isAlive()
            then
                xi.pet.applyFamiliarBuffs(mob, pet)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 489)
end

return entity
