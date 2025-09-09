-----------------------------------
-- Area: Grauberg [S]
--  Mob: Wivre
-- Note: PH for Vasiliceratops
--       Mutually exclusive spawning of PHs is somewhat complex but re-usable to any number of mobs in the wivreSharedSpawns table
-----------------------------------
local ID = zones[xi.zone.GRAUBERG_S]
-----------------------------------
---@type TMobEntity
local entity = {}

local wivreSharedSpawns =
set{
    ID.mob.VASILICERATOPS - 3,
    ID.mob.VASILICERATOPS - 67,
}

entity.onMobInitialize = function(mob)
    -- despawn normally if not a PH
    if not wivreSharedSpawns[mob:getID()] then
        return
    end

    -- instead of immediately spawning on zone init, enter respawn state and process onMobSpawnCheck to decide when to spawn
    mob:setRespawnTime(1)
end

entity.onMobSpawnCheck = function(mob)
    -- spawn normally if not a PH
    if not wivreSharedSpawns[mob:getID()] then
        return 0
    end

    -- only one of the PHs can be up at a time
    for phId, _ in pairs(wivreSharedSpawns) do
        local phMob = GetMobByID(phId)
        if
            (phMob and phMob:isSpawned()) or
            mob:getLocalVar('blockNextSpawn') == 1
        then
            -- delay this mob from spawning for a full cycle
            mob:setLocalVar('blockNextSpawn', 0)
            return 330
        end
    end

    return 0
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.VASILICERATOPS, 10, 5400) -- 1.5 hour

    -- despawn normally if not a PH
    if not wivreSharedSpawns[mob:getID()] then
        return
    end

    local phChoice, _ = utils.randomEntryIdx(wivreSharedSpawns)
    for phId, _ in pairs(wivreSharedSpawns) do
        local phMob = GetMobByID(phId)
        if phMob then
            -- block next spawn for all except the chosen PH
            -- unless NM was set to spawn by this despawn, then it's a free-for-all on next spawn
            if phChoice ~= phId and mob:getRespawnTime() ~= 0 then
                phMob:setLocalVar('blockNextSpawn', 1)
            else
                phMob:setLocalVar('blockNextSpawn', 0)
            end

            -- do not undo disabled spawn when vasiliceratops is primed
            if phMob:getRespawnTime() ~= 0 then
                -- reset respawn timer to keep all mobs in sync
                phMob:setRespawnTime(330)
            end
        end
    end
end

return entity
