-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Zoraal Ja's Pkuucha
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("whenToPopZoraal", math.random(20, 50))
    mob:setLocalVar("hasPoppedZoraal", 0)
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar("hasPoppedZoraal", 0)
    if GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):isSpawned() then
        DespawnMob(ID.mob.PERCIPIENT_ZORAAL_JA)
    end
end

entity.onMobRoam = function(mob)
    mob:setLocalVar("hasPoppedZoraal", 0)
    if GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):isSpawned() then
        DespawnMob(ID.mob.PERCIPIENT_ZORAAL_JA)
    end
end

entity.onMobFight = function(mob, target)
    if
        mob:getHPP() <= mob:getLocalVar("whenToPopZoraal") and
        not GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):isSpawned() and
        mob:getLocalVar("hasPoppedZoraal") == 0
    then
        GetMobByID(ID.mob.PERCIPIENT_ZORAAL_JA):setSpawn(mob:getXPos() + math.random(-2, 2), mob:getYPos(), mob:getZPos() + math.random(-2, 2))
        SpawnMob(ID.mob.PERCIPIENT_ZORAAL_JA):updateEnmity(target)
        mob:setHP(mob:getMaxHP())
        mob:setUnkillable(true)
        mob:setLocalVar("hasPoppedZoraal", 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 447)
end

return entity
