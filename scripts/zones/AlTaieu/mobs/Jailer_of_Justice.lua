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
    -- Don't lose TP from charm 2hr
    if skill:getID() == xi.mobSkill.FAMILIAR_1 then -- Manually apply Familiar to all pets except first one
        local mobId = mob:getID()
        for i = 2, 6 do
            local pet = GetMobByID(mobId + i)
            if pet then
                local hasFamiliar = pet:getLocalVar('hasFamiliar')
                if
                    pet:isSpawned() and
                    hasFamiliar == 0
                then
                    -- Boost pet HP and stats by 10%
                    local boost = math.floor(pet:getMaxHP() * 0.10)
                    pet:setLocalVar('hasFamiliar', 1)
                    pet:setMaxHP(pet:getMaxHP() + boost)
                    pet:setHP(pet:getHP() + boost)
                    pet:updateHealth()

                    -- Boost stats by 10%
                    pet:addMod(xi.mod.ATTP, 10)
                    pet:addMod(xi.mod.ACC, mob:getMod(xi.mod.ACC) * 0.10)
                    pet:addMod(xi.mod.EVA, mob:getMod(xi.mod.EVA) * 0.10)
                    pet:addMod(xi.mod.DEFP, 10)
                end
            end
        end
    end
end

return entity
