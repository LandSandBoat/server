-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Lesser Colibri
-- Note: Place holder Zoraal Ja's Pkuucha
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

local zoraalPHTable =
{
    [ID.mob.ZORAAL_JAS_PKUUCHA - 6] = ID.mob.ZORAAL_JA_S_PKUUCHA, -- 181.000 -18.000 -63.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 5] = ID.mob.ZORAAL_JA_S_PKUUCHA, -- 181.000 -19.000 -77.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 4] = ID.mob.ZORAAL_JA_S_PKUUCHA, -- 195.000 -18.000 -95.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 3] = ID.mob.ZORAAL_JA_S_PKUUCHA, -- 220.000 -19.000 -80.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 2] = ID.mob.ZORAAL_JA_S_PKUUCHA, -- 219.000 -18.000 -59.000
    [ID.mob.ZORAAL_JAS_PKUUCHA - 1] = ID.mob.ZORAAL_JA_S_PKUUCHA, -- 203.000 -16.000 -74.000
}

local zoraalSpawnPoints =
{
    { x = 193.000, y = -18.000, z = -65.000 },
    { x = 221.000, y = -19.000, z = -75.000 },
    { x = 207.000, y = -16.000, z = -77.000 },
    { x = 181.000, y = -18.000, z = -42.000 },
    { x = 170.000, y = -18.000, z = -21.000 },
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    params.spawnPoints = zoraalSpawnPoints
    xi.mob.phOnDespawn(mob, zoraalPHTable, 5, 1800, params) -- 30 minutes
end

return entity
