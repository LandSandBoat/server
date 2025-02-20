-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
local gardenGlobal = require('scripts/zones/The_Garden_of_RuHmet/globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
end

entity.onMobSpawn = function(mob)
    -- Change animation to open
    mob:setAnimationSub(2)
end

entity.onMobFight = function(mob)
    -- Forms: 0 = Closed  1 = Closed  2 = Open 3 = Closed
    local randomTime = math.random(45, 180)
    local changeTime = mob:getLocalVar('changeTime')

    if mob:getBattleTime() - changeTime > randomTime then
        -- Change close to open.
        if mob:getAnimationSub() == 1 then
            mob:setAnimationSub(2)
        else -- Change from open to close
            mob:setAnimationSub(1)
        end

        mob:setLocalVar('changeTime', mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FAITH):setPos(unpack(gardenGlobal.qmPosFaithTable[math.random(1, 5)]))
end

return entity
