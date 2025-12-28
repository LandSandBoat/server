-----------------------------------
-- Area: Sacrarium
--  Mob: Old Professor Mariselle
-----------------------------------
local ID = zones[xi.zone.SACRARIUM]
local professorTables = require('scripts/zones/Sacrarium/globals')
-----------------------------------
---@type TMobEntity
local entity = {}

local pets =
{
    ID.mob.OLD_PROFESSOR_MARISELLE + 1,
    ID.mob.OLD_PROFESSOR_MARISELLE + 2
}

local callPetParams =
{
    maxSpawns    = 1,
    inactiveTime = 3000,
    dieWithOwner = true
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setCarefulPathing(true)

    for i = 0, 5 do
        if GetNPCByID(ID.npc.QM_MARISELLE_OFFSET + i):getLocalVar('hasProfessorMariselle') == 1 then
            mob:setLocalVar('spawnLocation', i)
        end
    end
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:setLocalVar('petTimer', currentTime + 10)
    mob:setLocalVar('teleportTime', currentTime + math.random(30, 180))
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()
    if
        currentTime > mob:getLocalVar('petTimer') and
        xi.mob.callPets(mob, pets, callPetParams)
    then
        mob:setLocalVar('petTimer', currentTime + 10)
    end

    local teleportTime = mob:getLocalVar('teleportTime')
    if
        currentTime > teleportTime and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        local profLocation     = mob:getLocalVar('spawnLocation')
        local shufflePositions = utils.shuffle(professorTables.locations[profLocation])
        -- Teleport Mariselle and his pets to a new location
        utils.mobTeleport(mob, 2000, shufflePositions[1])

        for i = 1, #pets do
            local pet = GetMobByID(pets[i])
            if pet and pet:isSpawned() then
                utils.mobTeleport(pet, 2000, shufflePositions[i + 1])
                pet:setLocalVar('teleported',  1)
            end
        end

        mob:setLocalVar('teleportTime', currentTime + math.random(30, 180))
    end
end

entity.onMobSpellChoose = function(mob)
    local spellList =
    {
        xi.magic.spell.ABSORB_INT,
        xi.magic.spell.BLIND,
        xi.magic.spell.DRAIN,
        xi.magic.spell.SLEEP_II,
        xi.magic.spell.SLEEPGA_II,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar('teleportTime', 0)
end

entity.onMobDespawn = function(mob)
    -- Randomize Old Prof. Mariselle's spawn location
    local nextSpawn = math.random(0, 5)
    for i = 0, 5 do
        local value = i == nextSpawn and 1 or 0
        GetNPCByID(ID.npc.QM_MARISELLE_OFFSET + i):setLocalVar('hasProfessorMariselle', value)
    end
end

return entity
