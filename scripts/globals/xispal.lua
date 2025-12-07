xi = xi or {}
xi.xispal = xi.xispal or {}

xi.xispal.getFollowers = function(player)
    local chocoID  = player:getCharVar('[XISP]chocoID')
    local followers = {}

    if chocoID ~= 0 then
        chocobo = GetMobByID(chocoID)
        if chocobo and chocobo:isSpawned() then
            table.insert(followers, chocobo)
        end
    end

    return followers
end

xi.xispal.resetFollowers = function(player)
    local party = xi.xispal.getFollowers(player)

    for _, member in pairs(party) do
        local pal = GetMobByID(member)

        if pal and pal:isSpawned() then
            pal:setBehavior(bit.band(pal:getBehavior(), bit.bnot(xi.behavior.NO_DESPAWN)))
            DespawnMob(pal:getID())

            if pal:getPet() then
                DespawnMob(pal:getPet():getID())
            end
        end
    end

    player:setCharVar('[XISP]squireID', 0)
    player:setCharVar('[XISP]chocoID',  0)
end

xi.xispal.onMobSpawn = function(pal, player, race, job)
    pal:setRotation(player:getPos().rot + math.random(-5, 5))
    pal:setRoamFlags(xi.roamFlag.SCRIPTED)

    -- Update Model
    pal:timer(400, function(palArg)
        palArg:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
        palArg:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
        palArg:setMobMod(xi.mobMod.NO_DESPAWN, 1)
        palArg:setMobMod(xi.mobMod.ROAM_COOL, 0)
        palArg:setMobMod(xi.mobMod.NO_REST, 1)
    end)
end