-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Hrungnir (Einherjar)
-- Notes: 2 copies are spawned.
-- Both must be defeated within 60 seconds of each other.
-- If not, the dead copy gets respawned with full HP.
-- Both use regular Golem TP moves but their Ice Break/Thunder Break look like regular attacks.
-- First ID uses Ice Break, second uses Thunder Break.
-- Unverified/Unimplemented:
--  - Some TP moves may cause Petrify
--  - Some TP moves may reset hate
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
local main  = zones[xi.zone.HAZHALM_TESTING_GROUNDS].mob.HRUNGNIR
local clone = zones[xi.zone.HAZHALM_TESTING_GROUNDS].mob.HRUNGNIR_CLONE
-----------------------------------
---@type TMobEntity
local entity = {}

local function spawnOther(mob)
    local chamberData = xi.einherjar.getChamber(mob:getLocalVar('[ein]chamber'))
    local other = GetMobByID(mob:getID() == main and clone or main)
    if other then
        other:setSpawn(mob:getXPos() + 1, mob:getYPos(), mob:getZPos(), mob:getRotPos())
        if chamberData then
            xi.einherjar.spawnMob(other, 2, chamberData)
        else -- fallback for testing with no einherjar context
            other:spawn()
        end

        mob:setLocalVar('otherToD', 0)
    end
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('otherToD', 0)
    -- Main only: Spawn clone
    -- Slight delay to wait for the Einherjar local vars to be setup
    if mob:getID() == main then
        mob:timer(100, spawnOther)
    end
end

entity.onMobFight = function(mob, target)
    -- Repop Other every 60 seconds if Current is up and Other is not.
    local other = GetMobByID(mob:getID() == main and clone or main)

    if
        other and
        not other:isSpawned() and
        os.time() > mob:getLocalVar('otherToD') + 60
    then
        spawnOther(mob)
        other:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local other = GetMobByID(mob:getID() == main and clone or main)
    if other and other:isAlive() then
        other:setLocalVar('otherToD', os.time())
    end
end

return entity
