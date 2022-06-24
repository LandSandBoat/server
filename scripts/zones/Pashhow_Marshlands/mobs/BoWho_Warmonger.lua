-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Bo'Who Warmonger
-----------------------------------
require("scripts/globals/regimes")
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.LEADER, 2)
end

entity.onMobSpawn = function(mob)
    -- Takes half damage from all attacks
    mob:addMod(xi.mod.DMG,-5000)

    local mobId = mob:getID()
    local x = mob:getXPos()
    local y = mob:getYPos()
    local z = mob:getZPos()
    local r = mob:getRotPos()

    if mob:getMobMod(xi.mobMod.LEADER) > 0 then
        for i = 1, mob:getMobMod(xi.mobMod.LEADER) do
            local followerId = mobId + i
            local follower = GetMobByID(followerId)

            if not follower:isSpawned() then
                local newX = x + math.random(-2, 2)
                local newY = y
                local newZ = z + math.random(-2, 2)

                follower:setSpawn(newX, newY, newZ, r)
                follower:spawn()
                follower:setMobFlags(1153)
            end

            xi.follow.follow(follower, mob)
        end
    end
end

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()
    for i = 1, 2 do
        GetMobByID(mobId+i):updateEnmity(target)
    end
end

entity.onMagicCastingCheck = function(mob, target, spell)
    -- Frequently casts Cure 3 on itself below 50% HP
    if mob:getHPP() < 50 then
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 80)
    else
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 40)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min
    DespawnMob(ID.mob.BOWHO_GUARD1)
    DespawnMob(ID.mob.BOWHO_GUARD2)
end

return entity
