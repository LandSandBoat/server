-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Justice
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local pets =
{
    ID.mob.JAILER_OF_JUSTICE + 1,
    ID.mob.JAILER_OF_JUSTICE + 2,
    ID.mob.JAILER_OF_JUSTICE + 3,
    ID.mob.JAILER_OF_JUSTICE + 4,
    ID.mob.JAILER_OF_JUSTICE + 5,
    ID.mob.JAILER_OF_JUSTICE + 6,
}

local callPetParams =
{
    maxSpawns = 1,
    inactiveTime = 3000,
    dieWithOwner = true
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Qnxzomit')
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
    xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.FAMILIAR, hpp = 50, cooldown = 210 }, }, })
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('petTimer', GetSystemTime() + 30)
    mob:setLocalVar('charmTimer', GetSystemTime() + 150)
end

entity.onMobFight = function(mob, target)
    -- Summons a pet every 30 seconds until 6 are out.
    local petTimer = mob:getLocalVar('petTimer')
    if
        GetSystemTime() > petTimer and
        xi.mob.callPets(mob, pets, callPetParams)
    then
        mob:setLocalVar('petTimer', GetSystemTime() + 30)
    end

    -- Uses Charm every 2 1/2 minutes.
    local charmTimer = mob:getLocalVar('charmTimer')
    if GetSystemTime() > charmTimer then
        mob:setLocalVar('charmTimer', GetSystemTime() + 150)
        mob:useMobAbility(xi.mobSkill.CHARM)
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

return entity
