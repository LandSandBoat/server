-----------------------------------
-- Area: Meriphataud Mountains (119)
--   NM: Coo Keja the Unseen
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

-- TODO: Implement better pathing systems for guards to follow master

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIJIN_GAKURE, hpp = math.random(10, 15) },
        },
    })

    -- Takes half damage from all attacks
    mob:addMod(xi.mod.DMG, -5000)

    -- May spawn in a party with two other Orcs
    if math.random(1, 2) == 1 then
        GetMobByID(ID.mob.COO_KEJA_THE_UNSEEN + 1):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
        GetMobByID(ID.mob.COO_KEJA_THE_UNSEEN + 2):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
        SpawnMob(ID.mob.COO_KEJA_THE_UNSEEN + 1)
        SpawnMob(ID.mob.COO_KEJA_THE_UNSEEN + 2)
    end
end

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()
    for i = 1, 2 do
        local guardID = GetMobByID(mobId + i)
        guardID:updateEnmity(target)
    end
end

entity.onMobRoam = function(mob)
    local mobId = mob:getID()

    for i = 1, 2 do
        local guard = GetMobByID(mobId + i)
        if guard:isSpawned() and guard:getID() == mobId + 1 then
            guard:pathTo(mob:getXPos() + 1, mob:getYPos() + 3, mob:getZPos() + 0.15)
        elseif guard:isSpawned() and guard:getID() == mobId + 2 then
            guard:pathTo(mob:getXPos() + 3, mob:getYPos() + 5, mob:getZPos() + 0.15)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
    DespawnMob(ID.mob.COO_KEJA_THE_UNSEEN + 1)
    DespawnMob(ID.mob.COO_KEJA_THE_UNSEEN + 2)
end

return entity
