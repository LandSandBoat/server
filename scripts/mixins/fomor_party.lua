-----------------------------------
-- Fomor Party System
-- Handles Fomor mob parties of two types:
-- Patrol Parties: Leader with followers that path together
-- Guard Parties: Stationary mobs that have shared respawn behavior
-----------------------------------
require('scripts/globals/follow')
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.fomorParty = xi.mix.fomorParty or {}

-----------------------------------
-- Party Definitions by Zone
-----------------------------------
local lufaiseID   = zones[xi.zone.LUFAISE_MEADOWS]
local misareauxID = zones[xi.zone.MISAREAUX_COAST]
local phomiunaID  = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
local sacrariumID = zones[xi.zone.SACRARIUM]

local zoneParties =
{
    [xi.zone.LUFAISE_MEADOWS] =
    {
        patrol =
        {
            { leader = lufaiseID.mob.FOMOR_NINJA[1], followers = 1 },
        },

        guard =
        {
            -- Bluefell Falls Guards (Only one group spawns at a time)
            { members = { lufaiseID.mob.FOMOR_PALADIN[1],     lufaiseID.mob.FOMOR_DRAGOON[1],  lufaiseID.mob.FOMOR_DARK_KNIGHT[1], lufaiseID.mob.FOMOR_BLACK_MAGE[1] } },
            { members = { lufaiseID.mob.FOMOR_BARD[1],        lufaiseID.mob.FOMOR_RANGER[1],   lufaiseID.mob.FOMOR_DARK_KNIGHT[2], lufaiseID.mob.FOMOR_SUMMONER[1] } },
            { members = { lufaiseID.mob.FOMOR_BEASTMASTER[1], lufaiseID.mob.FOMOR_SAMURAI[2],  lufaiseID.mob.FOMOR_DARK_KNIGHT[3], lufaiseID.mob.FOMOR_MONK[1] } },
            -- Campfire Guards
            { members = { lufaiseID.mob.FOMOR_SAMURAI[3],     lufaiseID.mob.FOMOR_THIEF[2],    lufaiseID.mob.FOMOR_MONK[3],        lufaiseID.mob.FOMOR_NINJA[2] } },
            -- Outpost Guards
            { members = { lufaiseID.mob.FOMOR_THIEF[1],       lufaiseID.mob.FOMOR_RANGER[2],   lufaiseID.mob.FOMOR_RANGER[3] } },
            { members = { lufaiseID.mob.FOMOR_WARRIOR[1],     lufaiseID.mob.FOMOR_SUMMONER[2], lufaiseID.mob.FOMOR_BEASTMASTER[2] } },
        }
    },

    [xi.zone.MISAREAUX_COAST] =
    {
        patrol =
        {
            { leader = misareauxID.mob.FOMOR_RED_MAGE[1],    followers = 1 },
            { leader = misareauxID.mob.FOMOR_DRAGOON[1],     followers = 3 },
            { leader = misareauxID.mob.FOMOR_MONK[2],        followers = 1 },
            { leader = misareauxID.mob.FOMOR_RANGER[1],      followers = 1 },
            { leader = misareauxID.mob.FOMOR_DARK_KNIGHT[1], followers = 1 },
            { leader = misareauxID.mob.FOMOR_PALADIN[1],     followers = 1 },
        },

        guard =
        {
            -- Outpost Guards
            { members = { misareauxID.mob.FOMOR_MONK[1],        misareauxID.mob.FOMOR_SAMURAI[1],     misareauxID.mob.FOMOR_WARRIOR[1], misareauxID.mob.FOMOR_THIEF[1] } },
            -- Campfire Guards (Only one group spawns at a time)
            { members = { misareauxID.mob.FOMOR_PALADIN[2],     misareauxID.mob.FOMOR_DARK_KNIGHT[2], misareauxID.mob.FOMOR_THIEF[2],   misareauxID.mob.FOMOR_RANGER[3] } },
            { members = { misareauxID.mob.FOMOR_PALADIN[3],     misareauxID.mob.FOMOR_SUMMONER[1],    misareauxID.mob.FOMOR_MONK[3] } },
            { members = { misareauxID.mob.FOMOR_PALADIN[4],     misareauxID.mob.FOMOR_NINJA[2] } },
        }
    },

    [xi.zone.PHOMIUNA_AQUEDUCTS] =
    {
        patrol =
        {
            -- Upstairs NE Room
            { leader = phomiunaID.mob.FOMOR_RANGER[3],     followers = 1 },
            { leader = phomiunaID.mob.FOMOR_BARD[3],       followers = 1 },
            { leader = phomiunaID.mob.FOMOR_RED_MAGE[4],   followers = 1 },
            { leader = phomiunaID.mob.FOMOR_MONK[5],       followers = 1 },
            -- Upstairs SE Room
            { leader = phomiunaID.mob.FOMOR_RANGER[5],     followers = 1 },
            { leader = phomiunaID.mob.FOMOR_PALADIN[4],    followers = 1 },
            { leader = phomiunaID.mob.FOMOR_RED_MAGE[2],   followers = 1 },
            { leader = phomiunaID.mob.FOMOR_BLACK_MAGE[4], followers = 1 },
            -- Upstairs SW Room
            { leader = phomiunaID.mob.FOMOR_BARD[4],       followers = 1 },
            { leader = phomiunaID.mob.FOMOR_THIEF[4],      followers = 1 },
            { leader = phomiunaID.mob.FOMOR_WARRIOR[5],    followers = 1 },
            { leader = phomiunaID.mob.FOMOR_RANGER[8],     followers = 1 },
            -- Upstairs NW Room
            { leader = phomiunaID.mob.FOMOR_BARD[6],       followers = 1 },
            { leader = phomiunaID.mob.FOMOR_THIEF[6],      followers = 1 },
            { leader = phomiunaID.mob.FOMOR_WARRIOR[3],    followers = 1 },
            { leader = phomiunaID.mob.FOMOR_SAMURAI[4],    followers = 1 },
            -- Downstairs L-7 Party
            { leader = phomiunaID.mob.FOMOR_WARRIOR[1],    followers = 2 },
            -- Downstairs I-7 Party
            { leader = phomiunaID.mob.FOMOR_DRAGOON[1],    followers = 2 },
        },

        guard =
        {
            -- Tres Duendes Room
            { members = { phomiunaID.mob.FOMOR_SAMURAI[1], phomiunaID.mob.FOMOR_NINJA[2], phomiunaID.mob.FOMOR_RANGER[1], phomiunaID.mob.FOMOR_DARK_KNIGHT[1] } },
            -- H-8 Ladder
            { members = { phomiunaID.mob.FOMOR_PALADIN[2], phomiunaID.mob.FOMOR_SAMURAI[2], phomiunaID.mob.FOMOR_RED_MAGE[1] } },
            -- C-8 Ladder
            { members = { phomiunaID.mob.FOMOR_BLACK_MAGE[2], phomiunaID.mob.FOMOR_WARRIOR[2], phomiunaID.mob.FOMOR_DARK_KNIGHT[3] } },
        }
    },

    [xi.zone.SACRARIUM] =
    {
        patrol =
        {
            { leader = sacrariumID.mob.FOMOR_WARRIOR[5], followers = 1 },
            { leader = sacrariumID.mob.FOMOR_BARD[6],    followers = 3 },
        },

        guard =
        {
            -- H-11 Classroom
            { members = { sacrariumID.mob.FOMOR_BARD[5] } },
            { members = { sacrariumID.mob.FOMOR_MONK[4],       sacrariumID.mob.FOMOR_SAMURAI[4], sacrariumID.mob.FOMOR_NINJA[4] } },
            { members = { sacrariumID.mob.FOMOR_BLACK_MAGE[4], sacrariumID.mob.FOMOR_RANGER[7],  sacrariumID.mob.FOMOR_RED_MAGE[4] } },
        }
    }
}

-----------------------------------
-- Party Definition Helpers
-----------------------------------
local function getFomorParty(mobID, parties)
    if not parties then
        return nil, nil
    end

    if parties.patrol then
        for _, party in ipairs(parties.patrol) do
            if
                party.leader and
                party.followers and
                mobID >= party.leader and
                mobID <= party.leader + party.followers
            then
                return party, 'patrol'
            end
        end
    end

    if parties.guard then
        for _, party in ipairs(parties.guard) do
            if party.members then
                for _, memberID in ipairs(party.members) do
                    if memberID == mobID then
                        return party, 'guard'
                    end
                end
            end
        end
    end

    return nil, nil
end

local function getPartyLeader(party)
    if party then
        if party.leader then
            return party.leader
        elseif party.members and #party.members > 0 then
            return party.members[1]
        end
    end

    return nil
end

-----------------------------------
-- Set up party behavior on spawn
-- Handles superlinking, guard/patrol behavior, and following
-----------------------------------
xi.mix.fomorParty.onPartySpawn = function(mob)
    local parties = zoneParties[mob:getZoneID()]
    local mobID = mob:getID()
    local party, behavior = getFomorParty(mobID, parties)

    if not party then
        return
    end

    local leaderID = getPartyLeader(party)
    if leaderID then
        mob:setMobMod(xi.mobMod.SUPERLINK, leaderID)
    end

    -- Allow followers to respawn (respawn blocked on death until leader respawns)
    if
        behavior == 'patrol' and
        mobID == leaderID and
        party.followers
    then
        mob:setMobMod(xi.mobMod.LEADER, party.followers)

        -- Spawn followers properly on server start
        -- Otherwise allow them to respawn normally
        for i = 1, party.followers do
            local followerID = leaderID + i
            local follower = GetMobByID(followerID)

            if follower then
                local respawnTime = follower:getRespawnTime()

                if respawnTime ~= 0 then
                    DisallowRespawn(followerID, false)
                end
            end
        end
    end

    -- Follower spawning logic for patrol parties
    -- Track distance to leader and start following
    if
        behavior == 'patrol' and
        leaderID and
        mobID > leaderID and
        party.followers
    then
        local distance = mobID - leaderID
        mob:setMobMod(xi.mobMod.LEADER, -distance)

        local leader = GetMobByID(leaderID)
        if leader then
            xi.follow.follow(mob, leader)
        end
    end

    -- Guard party: stationary groups that coordinate deaths
    if behavior == 'guard' and party.members then
        mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
        mob:setMobMod(xi.mobMod.ROAM_RESET_FACING, 1)
        mob:setRoamFlags(xi.roamFlag.SCRIPTED)
    end
end

-----------------------------------
-- Handle roaming behavior and follower cleanup
-----------------------------------
xi.mix.fomorParty.onPartyRoam = function(mob)
    local parties = zoneParties[mob:getZoneID()]
    local mobID = mob:getID()
    local party, behavior = getFomorParty(mobID, parties)

    if not party then
        return
    end

    -- Patrol party logic
    -- Followers despawn if leader is not spawned
    if behavior == 'patrol' then
        local leaderID = getPartyLeader(party)

        if leaderID and mobID ~= leaderID then
            local leader = GetMobByID(leaderID)

            -- If leader is not spawned, despawn this follower
            if leader and not leader:isSpawned() then
                DespawnMob(mobID)
                return
            end
        end
    end

    -- Guard mobs should return to spawn position and maintain spawn rotation
    if behavior == 'guard' and party.members then
        local spawnPos = mob:getSpawnPos()
        local pos = mob:getPos()

        -- If not at spawn position, path back to it
        if spawnPos.x ~= pos.x or spawnPos.z ~= pos.z then
            mob:pathThrough({ spawnPos.x, spawnPos.y, spawnPos.z })
        end

        return
    end
end

-----------------------------------
-- Handle party member death
-- Prevents members from respawning independently
-----------------------------------
xi.mix.fomorParty.onPartyDeath = function(mob)
    local parties = zoneParties[mob:getZoneID()]
    local mobID = mob:getID()
    local party, behavior = getFomorParty(mobID, parties)

    if not party then
        return
    end

    -- Patrol party respawn
    -- Disallow respawn unless leader of party
    if behavior == 'patrol' then
        local leaderID = getPartyLeader(party)
        if leaderID and mobID ~= leaderID then
            DisallowRespawn(mobID, true)
        end

        -- Guard party respawn
    elseif behavior == 'guard' and party.members then
        -- Check if all other party members are dead
        local allDead = true
        for _, memberID in ipairs(party.members) do
            if memberID and memberID ~= mobID then
                local member = GetMobByID(memberID)
                if member and member:isAlive() then
                    allDead = false
                    break
                end
            end
        end

        -- Last member of the party died - sync all members to this mob's respawn time
        if allDead then
            local respawnTime = mob:getRespawnTime()
            for _, memberID in ipairs(party.members) do
                local member = GetMobByID(memberID)
                if member then
                    member:setRespawnTime(respawnTime)
                    DisallowRespawn(memberID, false)
                end
            end

        -- Some members are still alive, don't allow respawn
        else
            DisallowRespawn(mobID, true)
        end
    end
end

g_mixins.fomor_party = function(mob)
end

return g_mixins.fomor_party
