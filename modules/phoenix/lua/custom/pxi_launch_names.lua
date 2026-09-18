-----------------------------------
-- Extra starter mobs have their own names, respawn after 15 seconds, and keep the original loot.
-- They only drop items if the credited killer gets combat EXP.
-- Enable or remove together with phoenix/data/launch_starter_zones in modules/init.txt.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('pxi_launch_names')

-- The first mob type uses offsets 824-923 in each zone. The second uses 924-1023.
local starterZones =
{
    [xi.zone.WEST_RONFAURE    ] = { name = 'West_Ronfaure',     mobs = { { 'Wild_Rabbit',     'Field Rabbit'    }, { 'Tunnel_Worm', 'Burrowing Worm' } } },
    [xi.zone.EAST_RONFAURE    ] = { name = 'East_Ronfaure',     mobs = { { 'Wild_Rabbit',     'Field Rabbit'    }, { 'Tunnel_Worm', 'Burrowing Worm' } } },
    [xi.zone.NORTH_GUSTABERG  ] = { name = 'North_Gustaberg',   mobs = { { 'Huge_Hornet',     'Large Hornet'    }, { 'Tunnel_Worm', 'Burrowing Worm' } } },
    [xi.zone.SOUTH_GUSTABERG  ] = { name = 'South_Gustaberg',   mobs = { { 'Huge_Hornet',     'Large Hornet'    }, { 'Tunnel_Worm', 'Burrowing Worm' } } },
    [xi.zone.WEST_SARUTABARUTA] = { name = 'West_Sarutabaruta', mobs = { { 'Tiny_Mandragora', 'Baby Mandragora' }, { 'Bumblebee',   'Fuzzy Bumblebee' } } },
    [xi.zone.EAST_SARUTABARUTA] = { name = 'East_Sarutabaruta', mobs = { { 'Tiny_Mandragora', 'Baby Mandragora' }, { 'Bumblebee',   'Fuzzy Bumblebee' } } },
}

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
    super(player, firstLogin, zoning)

    player:removeListener('PXI_LAUNCH_EXP')
    if not starterZones[player:getZoneID()] then
        return
    end

    player:addListener('EXPERIENCE_POINTS', 'PXI_LAUNCH_EXP', function(playerArg, mob, exp)
        if not mob or not mob:isMob() or exp <= 0 then
            return
        end

        local offset = mob:getID() % 0x1000
        if
            not starterZones[mob:getZoneID()] or
            offset < 824 or
            offset > 1023 or
            mob:getLocalVar('[PXI]LaunchKiller') ~= playerArg:getID()
        then
            return
        end

        -- Combat EXP is awarded before the engine rolls item drops.
        mob:setMobMod(xi.mobMod.NO_DROPS, 0)
    end)
end)

for _, zoneData in pairs(starterZones) do
    for index, mobData in ipairs(zoneData.mobs) do
        local firstOffset = 824 + (index - 1) * 100

        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobSpawn', zoneData.name, mobData[1]), function(mob)
            super(mob)

            local offset = mob:getID() % 0x1000
            if offset < firstOffset or offset >= firstOffset + 100 then
                return
            end

            -- Worms can roam at zero speed. Keep the extra worms where they spawn.
            if mobData[1] == 'Tunnel_Worm' then
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            end

            mob:renameEntity(mobData[2], true)
            mob:setRespawnTime(0)
            -- Keep a 12-second corpse delay plus the engine's three-second fade.
            mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 3)
            mob:setMobMod(xi.mobMod.NO_DROPS, 1)
            mob:setLocalVar('[PXI]LaunchKiller', 0)
        end)

        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDeath', zoneData.name, mobData[1]), function(mob, player, optParams)
            super(mob, player, optParams)

            local offset = mob:getID() % 0x1000
            if
                offset < firstOffset or
                offset >= firstOffset + 100 or
                not optParams.isKiller or
                not player
            then
                return
            end

            mob:setLocalVar('[PXI]LaunchKiller', player:getID())
        end)

        m:addOverride(string.format('xi.zones.%s.mobs.%s.onMobDespawn', zoneData.name, mobData[1]), function(mob)
            super(mob)

            local offset = mob:getID() % 0x1000
            if offset < firstOffset or offset >= firstOffset + 100 or mob:getHP() > 0 then
                return
            end

            -- Let the despawn state finish before spawning again.
            mob:timer(1, function(mobArg)
                if not mobArg:isSpawned() then
                    mobArg:spawn()
                end
            end)
        end)
    end
end
