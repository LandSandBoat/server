-----------------------------------
-- Persists NM time of deaths to the database. They must be added to the list here
-- to get this extra behaviour.
-- This is useful if you don't want players rushing to NM spawns after a server
-- restart or a crash (or trying to force crashes/restarts to get NM pops)
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('persist_nm_time_of_deaths')

-- NOTE: These names are as they are as filenames.
-- Example: Behemoth's Dominion => Behemoths_Dominion
-- Example: King Behemoth       => King_Behemoth
-- { zone name, mob name, function to generate respawn time}
-- Format:
local nmsToPersist =
{
    -- 21 - 24 hours with half hour windows
    {
        'Behemoths_Dominion',
        'Behemoth',
        function()
            return 75600 + math.random(0, 6) * 1800
        end
    },
}

-- NOTE: At the time we iterate over these entries, the Lua zone and mob objects won't be ready,
--     : so we deal with everything as strings for now.
for _, entry in pairs(nmsToPersist) do
    local zoneName    = entry[1]
    local mobName     = entry[2]
    local varName     = '[Respawn]' .. mobName
    local respawnFunc = entry[3]

    m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneName, mobName),
    function(mob)
        super(mob)

        local respawn = respawnFunc()
        mob:setRespawnTime(respawn)
        SetServerVariable(varName, (os.time() + respawn))
        print(string.format('Writing respawn time to server vars: %s %i', mob:getName(), respawn))
    end)

    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName),
    function(zone)
        super(zone)

        local mob = zone:queryEntitiesByName(mobName)[1]
        local respawn = GetServerVariable(varName)
        print(string.format('Getting respawn time from server vars: %s %i', mob:getName(), respawn))

        if os.time() < respawn then
            UpdateNMSpawnPoint(mob:getID())
            mob:setRespawnTime(respawn - os.time())
        else
            SpawnMob(mob:getID())
        end
    end)
end

return m
