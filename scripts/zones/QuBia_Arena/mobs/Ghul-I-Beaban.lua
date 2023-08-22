-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ghul-I-Beaban
-- BCNM: Undying Promise
-----------------------------------
-----------------------------------

local entityFlags = { 2, 4, 6, 6 }
local spawnPoints =
{
    [17621113] = { -400.000, -202.000,  400.000, 190 },
    [17621114] = { -400.000, -202.000,  400.000, 190 },
    [17621116] = { 0,        -2,        0,       190 },
    [17621117] = { 0,        -2,        0,       190 },
    [17621119] = { 400,      197,       -400,    190 },
    [17621120] = { 400,      197,       -400,    190 },
}

local entity = {}

entity.onMobSpawn = function(mb)
    -- First spawn, set size flags
    if mb:getBattlefield() == nil then
        mb:setMobFlags(2)
    end

    mb:addListener("DEATH", "GHUL_DEATH", function(mob, player)
        local id = mob:getID()
        local battlefield = mob:getBattlefield()
        local reraise = tonumber(battlefield:getLocalVar("reraise"))

        if reraise >= 5 then -- All mobs have been killed, need to spawn loot
            battlefield:setLocalVar("lootSpawned", 0)
            local firstMob = GetMobByID(id)
            local secondMob = GetMobByID(id - 1)

            if firstMob ~= nil then
                local sp = spawnPoints[firstMob:getID()]
                firstMob:setSpawn(sp[1], sp[2], sp[3], sp[4])
            end

            if secondMob ~= nil then
                local sp = spawnPoints[secondMob:getID()]
                secondMob:setSpawn(sp[1], sp[2], sp[3], sp[4])
            end
        else
            -- Pick the next mob to spawn
            -- This will pick the BLM mob for the last two
            -- On retail, these mobs actually alternate spawning for instance 113 -> 114 -> 113 -> 114
            -- Our association of mob skills is wrong to do that here
            -- so we have to use these in a ghetto
            -- If you swap back and forth as intended, the transition/animation
            -- is much smoother (like retail), this should be migrated as soon as we have
            -- as solution to this issue.
            local nextID = id
            if reraise >= 3 and nextID % 2 ~= 0 then
                nextID = id + 1
            end

            -- Fade out in 50% the time
            mob:timer(2500, function(targ)
                targ:setStatus(xi.status.DISAPPEAR)
            end)

            local target = GetMobByID(nextID)
            if target ~= nil then
                battlefield:setLocalVar("prevMobID", id)
                target:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                target:timer(3000, function(targ)
                    local bf = targ:getBattlefield()
                    local prevMobID = tonumber(bf:getLocalVar("prevMobID"))
                    local rr = tonumber(bf:getLocalVar("reraise"))

                    -- Hide the previous mob
                    local m = GetMobByID(prevMobID)
                    if m ~= nil then
                        m:setStatus(xi.status.DISAPPEAR)
                    end

                    -- Size is based on how many times I've spawned
                    targ:setMobFlags(entityFlags[reraise])
                    -- Scale the mob's stats with the respawn counter
                    targ:setHP(targ:getMaxHP() * (1 - (0.25 * rr)))
                    targ:setMod(xi.mod.ATT, 25 * rr)
                    targ:resetAI()
                    -- Spawn the mob
                    targ:spawn()

                    -- Find battlefield targets
                    -- On retail, the mob can default to any of the players active
                    -- in the arena. Add everyone to the enmity table
                    local players = bf:getPlayers()
                    for k, v in pairs(players) do
                        -- Add the player's pet to the enmity table
                        local pet = v:getPet()
                        if pet ~= nil and pet:isAlive() then
                            targ:updateEnmity(pet)
                        end

                        -- add the player to the enmity table
                        targ:updateEnmity(v)
                    end

                    -- Add VE/CE for the killer only
                    targ:addEnmity(player, 5, 5)
                end)

                battlefield:setLocalVar("reraise", reraise + 1)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
