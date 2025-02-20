-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Love
-- !pos 431.522 -0.912 -603.503 33
-----------------------------------
local ID = zones[xi.zone.ALTAIEU]
-----------------------------------
---@type TMobEntity
local entity = {}

local minionGroup =
{
    [0] = 10, -- Qnxzomit
    [1] = 19, -- Qnhpemde
    [2] =  1, -- Ruphuabo
    [3] = 13, -- Qnxzomit
    [4] = 22, -- Qnhpemde
    [5] =  4, -- Ruphuabo
    [6] = 16, -- Qnxzomit
    [7] = 25, -- Qnhpemde
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobEngage = function(mob, target)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setAnimationSub(2)
end

entity.onMobFight = function(mob, target)
    -- reduce regen after nine Xzomits and Hpemdes are killed
    if
        mob:getLocalVar('JoL_Regen_Reduction') == 0 and
        mob:getLocalVar('JoL_Qn_xzomit_Killed') >= 9 and
        mob:getLocalVar('JoL_Qn_hpemde_Killed') >= 9
    then
        mob:setLocalVar('JoL_Regen_Reduction', 1)
        mob:addMod(xi.mod.REGEN, -260)
    end

    -- spawn minions in 2.5 minute intervals
    if os.time() > mob:getLocalVar('pop_pets') then
        mob:setLocalVar('pop_pets', os.time() + 150)

        local spawns = mob:getLocalVar('SPAWNS')
        if spawns < 8 then
            local minionOffset = ID.mob.JAILER_OF_LOVE + minionGroup[spawns]
            SpawnMob(minionOffset + 0):updateEnmity(target)
            SpawnMob(minionOffset + 1):updateEnmity(target)
            SpawnMob(minionOffset + 2):updateEnmity(target)
        else
            -- determine which sharks are currently spawned
            local phuaboUp = {}
            local phuaboDn = {}
            for i = ID.mob.JAILER_OF_LOVE + 1, ID.mob.JAILER_OF_LOVE + 9 do
                local phuabo = GetMobByID(i)

                if phuabo then
                    if phuabo:isAlive() then
                        table.insert(phuaboUp, i)
                    elseif not phuabo:isSpawned() then
                        table.insert(phuaboDn, i)
                    end
                end
            end

            -- how many sharks spawn depends on number currently alive
            -- https://www.bg-wiki.com/bg/Jailer_of_Love
            local numToSpawn = 0
            if #phuaboUp == 2 then
                numToSpawn = 1
            elseif #phuaboUp == 0 or #phuaboUp == 3 then
                numToSpawn = 3
            elseif #phuaboUp == 1 then
                numToSpawn = math.random(1, 3)
            end

            -- spawn sharks
            for i = 1, math.min(numToSpawn, #phuaboDn) do
                SpawnMob(phuaboDn[i]):updateEnmity(target)
            end
        end

        mob:setLocalVar('SPAWNS', spawns + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if math.random(1, 100) <= 25 then -- 25% chance to spawn Absolute Virtue
        SpawnMob(ID.mob.ABSOLUTE_VIRTUE)
    end
end

return entity
