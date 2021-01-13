-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    -- Change animation to open
    mob:setAnimationSub(2)
end

entity.onMobFight = function(mob)
    -- Forms: 0 = Closed  1 = Closed  2 = Open 3 = Closed
    local randomTime = math.random(45, 180)
    local changeTime = mob:getLocalVar("changeTime")

    if mob:getBattleTime() - changeTime > randomTime then
        -- Change close to open.
        if (mob:getAnimationSub() == 1) then
            mob:setAnimationSub(2)
        else -- Change from open to close
            mob:setAnimationSub(1)
        end
        mob:setLocalVar("changeTime", mob:getBattleTime())
    end
end

entity.onMobDeath = function(mob)
end

function onMobDespawn(mob)
    -- Move QM to random location
    local pos = math.random(1, 5)
    GetNPCByID(ID.npc.JAILER_OF_FAITH_QM):setPos(ID.npc.JAILER_OF_FAITH_QM_POS[pos][1], ID.npc.JAILER_OF_FAITH_QM_POS[pos][2], ID.npc.JAILER_OF_FAITH_QM_POS[pos][3])
end

return entity
