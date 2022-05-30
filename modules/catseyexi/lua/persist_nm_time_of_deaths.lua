-----------------------------------
-- Persists NM time of deaths to the database. They must be added to the list here
-- to get this extra behaviour.
-- This is useful if you don't want players rushing to NM spawns after a server
-- restart or a crash (or trying to force crashes/restarts to get NM pops)
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("persist_nm_time_of_deaths")

-- NOTE: These names are as they are as filenames.
-- Example: Behemoth's Dominion => Behemoths_Dominion
-- Example: King Behemoth       => King_Behemoth
-- { zone name, mob name, function to generate respawn time}
-- Format:
local nms_to_persist =
{
    { "Behemoths_Dominion", "Behemoth", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Dragons_Aery", "Fafnir", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Valley_of_Sorrows", "Adamantoise", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Caedarva_Mire", "Khimaira", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Rolanberry_Fields", "Simurgh", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Qulun_Dome", "Diamond_Quadav", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Monastic_Cavern", "Orcish_Overlord", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Castle_Oztroja", "Yagudo_High_Priest", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Labyrinth_of_Onzozo", "Lord_of_Onzozo", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
	{ "Ro_Maeve", "Shikigami_Weapon", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows	
}

-- NOTE: At the time we iterate over these entries, the Lua zone and mob objects won't be ready,
--     : so we deal with everything as strings for now.
for _, entry in pairs(nms_to_persist) do
    local zone_name = entry[1]
    local mob_name = entry[2]
    local var_name = "[Respawn]" .. mob_name
    local respawn_func = entry[3]

    m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobDespawn", zone_name, mob_name),
    function(mob)
        super(mob)

        local respawn = respawn_func()
        mob:setRespawnTime(respawn)
        SetServerVariable(var_name, (os.time() + respawn))
        print(string.format("Writing respawn time to server vars: %s %i", mob:getName(), respawn))
    end)

    m:addOverride(string.format("xi.zones.%s.Zone.onInitialize", zone_name),
    function(zone)
        super(zone)

        local mob = zone:queryEntitiesByName(mob_name)[1]
        local respawn = GetServerVariable(var_name)
        print(string.format("Getting respawn time from server vars: %s %i", mob:getName(), respawn))

        if os.time() < respawn then
            UpdateNMSpawnPoint(mob:getID())
            mob:setRespawnTime(respawn - os.time())
        else
            SpawnMob(mob:getID())
        end
    end)
end

return m
