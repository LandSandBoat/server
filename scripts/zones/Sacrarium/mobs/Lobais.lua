-----------------------------------
-- Area: Sacrarium
--   NM: Lobais
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local callPetParams =
{
    dieWithOwner = true,
    superLink = true,
    inactiveTime = 3000, -- 3 second cast time
    maxSpawns = 1,
}

local spells =
{
    xi.magic.spell.FIRE_II,
    xi.magic.spell.BLIZZARD_II,
    xi.magic.spell.STONE_II,
    xi.magic.spell.THUNDER_II,
    xi.magic.spell.WATER_II,
    xi.magic.spell.AEROGA,
    xi.magic.spell.SLEEPGA,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Fomors_Elemental_Lobais')
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 2)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 11)
    mob:setLocalVar('petSummonTime', GetSystemTime() + math.randomInt(10, 15))
    mob:setLocalVar('spellCastTime', GetSystemTime())
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()

    -- Resummon the elemental if it is down and the timer has elapsed.
    local pet = mob:getPet()
    if
        (not pet or not pet:isAlive()) and
        currentTime >= mob:getLocalVar('petSummonTime')
    then
        xi.mob.callPets(mob, mob:getID() + 1, callPetParams)
    end

    -- Manual cast: castSpell bypasses the engine rule blocking a SMN-main mob from casting while
    -- a pet is out, so Lobais nukes with the elemental up like it does on retail.
    if
        currentTime >= mob:getLocalVar('spellCastTime') and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:castSpell(spells[math.randomInt(1, #spells)], target)
        mob:setLocalVar('spellCastTime', currentTime + math.randomInt(30, 45))
    end
end

return entity
