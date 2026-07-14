-----------------------------------
-- Area: LaLoff Amphitheater
--  Mob: Ark Angel MR
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local callPetParams =
{
    inactiveTime = 1000,
}

local function spawnArkAngelPet(mob)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local pet = mob:getPet()

    if pet and pet:isAlive() then
        return
    end

    local battlefieldId    = battlefield:getID()
    local battlefieldArea  = battlefield:getArea()
    local content          = xi.battlefield.contents[battlefieldId]
    local selectedPetGroup = math.randomInt(2, 3) -- 2 = Tiger, 3 = Mandragora
    local petId            = content.groups[selectedPetGroup]['mobIds'][battlefieldArea][1]
    pet                    = GetMobByID(petId)

    if xi.mob.callPets(mob, petId, callPetParams) then
        pet = GetMobByID(petId)
        if pet then
            mob:setPet(pet)
            battlefield:insertEntity(pet:getTargID(), false, true)

            pet:addListener('DEATH', 'AAMR_PET_DEATH_' .. petId, function(petArg)
                local petBattlefield = petArg:getBattlefield()
                petBattlefield:setLocalVar('petRespawnMR', GetSystemTime() + 30)
            end)
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)
    mob:addMod(xi.mod.REGAIN, 90)
    mob:addMod(xi.mod.REGEN, 12)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    xi.mix.jobSpecial.config(mob,
    {
        specials =
        {
            { id = xi.mobSkill.PERFECT_DODGE_1 },
        },
    })
end

entity.onMobEngage = function(mob, target)
    spawnArkAngelPet(mob)
end

entity.onMobFight = function(mob, target)
    if mob:getLocalVar('Charm') == 0 and mob:getHPP() < 50 then
        mob:useMobAbility(xi.mobSkill.CHARM)
        mob:setLocalVar('Charm', 1)
    end

    local battlefield = mob:getBattlefield()
    if battlefield then
        local respawnTime = battlefield:getLocalVar('petRespawnMR')
        local pet = mob:getPet()

        if pet and pet:isAlive() then
            return
        end

        if
            respawnTime ~= 0 and
            respawnTime <= GetSystemTime()
        then
            battlefield:setLocalVar('petRespawnMR', 0)
            spawnArkAngelPet(mob)
        end
    end
end

return entity
