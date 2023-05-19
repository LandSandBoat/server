-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Meww the Turtlerider
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/regimes")
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
-----------------------------------
local entity = {}

-- TODO: Implement better pathing systems for guards to follow master

entity.onMobSpawn = function(mob)
    -- Takes half damage from all attacks
    mob:addMod(xi.mod.DMG, -5000)
    mob:setMod(xi.mod.REGEN, 25)

    -- May spawn in a party with two other Sahagin
    if math.random(1, 2) == 1 then
        GetMobByID(ID.mob.MEWW_THE_TURTLERIDER + 1):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
        GetMobByID(ID.mob.MEWW_THE_TURTLERIDER + 2):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
        SpawnMob(ID.mob.MEWW_THE_TURTLERIDER + 1)
        SpawnMob(ID.mob.MEWW_THE_TURTLERIDER + 2)
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
    xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
    DespawnMob(ID.mob.MEWW_THE_TURTLERIDER + 1)
    DespawnMob(ID.mob.MEWW_THE_TURTLERIDER + 2)
end

return entity
