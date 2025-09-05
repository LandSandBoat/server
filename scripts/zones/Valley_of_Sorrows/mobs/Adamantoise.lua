-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Adamantoise
-----------------------------------
local ID = zones[xi.zone.VALLEY_OF_SORROWS]
mixins =
{
    require('scripts/mixins/rage'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points are for era hnm spawns
entity.spawnPoints =
{
    { x =   3.000, y = -0.416, z =   8.000 },
    { x = -41.571, y =  0.042, z = -35.142 },
    { x =   5.864, y = -0.190, z = -29.660 },
    { x = -26.068, y = -0.038, z =  23.504 },
    { x =  -9.116, y = -0.071, z = -29.449 },
    { x =  14.996, y =  0.657, z =  31.093 },
    { x = -33.512, y =  0.140, z =  26.365 },
    { x = -47.618, y =  0.018, z = -29.171 },
    { x = -16.484, y =  0.093, z =  23.930 },
    { x =  -2.061, y =  0.385, z =  11.890 },
    { x =  15.896, y =  0.496, z =   6.045 },
    { x =   6.573, y = -0.026, z =   5.809 },
    { x = -21.673, y =  0.786, z = -45.105 },
    { x = -24.746, y =  0.125, z =  10.983 },
    { x =  23.045, y = -0.375, z =  18.410 },
    { x = -12.040, y =  0.327, z =  -5.008 },
    { x =  -1.446, y =  0.543, z =  13.472 },
    { x = -11.380, y =  0.116, z =   8.869 },
    { x =   4.485, y = -0.196, z = -44.631 },
    { x =  17.881, y =  0.752, z =  -2.229 },
    { x =   6.001, y =  0.478, z =  30.221 },
    { x =  -8.214, y =  0.233, z =   6.407 },
    { x = -29.303, y =  0.332, z = -41.083 },
    { x = -14.385, y =  0.048, z = -18.790 },
    { x =  -9.626, y =  0.161, z =  24.267 },
    { x =   1.119, y =  0.687, z =  14.916 },
    { x =  -2.042, y =  0.994, z =  19.894 },
    { x = -22.561, y =  0.208, z = -34.151 },
    { x =  -5.911, y =  0.282, z =   9.178 },
    { x = -21.178, y =  0.580, z =  -5.789 },
    { x =  -8.614, y =  0.119, z = -45.060 },
    { x =  -3.119, y = -0.251, z = -47.303 },
    { x = -15.110, y =  0.707, z =  40.673 },
    { x = -46.076, y =  0.895, z = -19.828 },
    { x =   4.758, y =  0.325, z = -10.139 },
    { x =   5.260, y =  0.292, z =  -8.671 },
    { x =   0.388, y =  0.106, z = -33.867 },
    { x = -28.618, y = -0.011, z = -13.328 },
    { x =  29.220, y =  0.143, z =  17.957 },
    { x = -35.488, y =  0.024, z =  37.351 },
    { x =  26.502, y =  0.375, z =   8.628 },
    { x = -34.571, y =  0.124, z = -30.934 },
    { x = -19.823, y =  0.990, z =  -3.804 },
    { x = -37.850, y =  0.512, z = -13.164 },
    { x =  -2.782, y =  0.333, z =  29.323 },
    { x = -40.693, y =  0.097, z =   8.104 },
    { x =  -8.348, y = -0.023, z =  30.394 },
    { x =   1.502, y =  0.946, z = -21.061 },
    { x = -16.271, y = -0.361, z =  31.262 },
    { x = -24.813, y = -0.148, z = -14.807 }
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMod(xi.mod.DMGMAGIC, -3500)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 36) -- 108 total weapon damage
    mob:setMod(xi.mod.DEF, 4112)
    mob:setMod(xi.mod.ATT, 450)

    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TORTOISE_TORTURER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
