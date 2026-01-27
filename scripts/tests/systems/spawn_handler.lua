describe('Spawn Handler', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    describe('basic respawns', function()
        it('respawns a killed mob after its timer expires', function()
            local mob = player.entities:moveTo('Wild_Rabbit')
            player:claimAndKillMob(mob)
            xi.test.world:skipTime(65)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('does not respawn a mob before its timer expires', function()
            local mob = player.entities:moveTo('Wild_Rabbit')
            player:claimAndKillMob(mob)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()
        end)

        it('respawns after deaggro with 60 second timer', function()
            local mob = player.entities:moveTo('Wild_Sheep')
            mob:setPos(mob:getXPos() + 200, mob:getYPos(), mob:getZPos())
            mob:disengage()

            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(mob)
            end

            mob.assert.no:isSpawned()

            xi.test.world:skipTime(65)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)
    end)

    describe('spawn slots', function()
        it('spawns exactly one mob from a slot', function()
            player:gotoZone(xi.zone.GHELSBA_OUTPOST)
            local mobs = xi.test.world:getSpawnSlot(xi.zone.GHELSBA_OUTPOST, 1)
            local mob1 = mobs[1]
            local mob2 = mobs[2]

            mob1:despawn()
            mob2:despawn()
            mob1:setRespawnTime(1)
            mob2:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)

            assert(mob1:isSpawned() ~= mob2:isSpawned(), 'expected only one mob to be spawned from slot')
        end)

        it('respawns same mob after deaggro', function()
            player:gotoZone(xi.zone.GHELSBA_OUTPOST)
            local mobs  = xi.test.world:getSpawnSlot(xi.zone.GHELSBA_OUTPOST, 1)
            local mob1  = mobs[1]
            local mob2  = mobs[2]

            local mob   = mob1:isSpawned() and mob1 or mob2
            local other = mob == mob1 and mob2 or mob1

            for _ = 1, 5 do
                mob:setPos(mob:getXPos() + 200, mob:getYPos(), mob:getZPos())
                mob:disengage()

                for _ = 1, 10 do
                    xi.test.world:skipTime(5)
                    xi.test.world:tickEntity(mob)
                end

                mob.assert.no:isSpawned()

                xi.test.world:skipTime(65)
                xi.test.world:tick(xi.tick.SPAWN)
                mob.assert:isSpawned()
                other.assert.no:isSpawned()
            end
        end)
    end)

    describe('time-based spawns', function()
        it('spawns night mobs during night', function()
            player:gotoZone(xi.zone.ATTOHWA_CHASM)
            xi.test.world:setVanaTime(22, 0)

            local mob = player.entities:moveTo('Arch_Corse')
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('blocks night mobs during day', function()
            player:gotoZone(xi.zone.ATTOHWA_CHASM)
            xi.test.world:setVanaTime(12, 0)

            local mob = player.entities:moveTo('Arch_Corse')
            mob:despawn()
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()
        end)

        it('spawns evening mobs during evening', function()
            xi.test.world:setVanaTime(18, 0)

            local mob = player.entities:moveTo('Ding_Bats')
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('blocks evening mobs during day', function()
            xi.test.world:setVanaTime(12, 0)

            local mob = player.entities:moveTo('Ding_Bats')
            mob:despawn()
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()
        end)
    end)

    describe('weather-based spawns', function()
        it('spawns elementals when weather matches', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            player:setWeather(xi.weather.THUNDER)

            local mob = player.entities:moveTo('Thunder_Elemental')
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('blocks elementals when weather does not match', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            player:setWeather(xi.weather.NONE)

            local mob = player.entities:moveTo('Thunder_Elemental')
            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(mob)
            end

            mob.assert.no:isSpawned()

            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()
        end)

        it('spawns fog mobs during fog', function()
            player:setWeather(xi.weather.FOG)

            local mob = player.entities:moveTo('Bomb')
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('blocks fog mobs without fog', function()
            player:setWeather(xi.weather.NONE)

            local mob = player.entities:moveTo('Bomb')
            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(mob)
            end

            mob.assert.no:isSpawned()

            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()
        end)
    end)

    describe('weather change despawns', function()
        it('despawns elementals when weather changes', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            player:setWeather(xi.weather.THUNDER)

            local mob = player.entities:moveTo('Thunder_Elemental')
            mob:respawn()
            xi.test.world:tick()

            player:setWeather(xi.weather.NONE)
            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(mob)
            end

            mob.assert.no:isSpawned()
        end)

        it('despawns fog mobs when fog ends', function()
            player:setWeather(xi.weather.FOG)

            local mob = player.entities:moveTo('Bomb')
            mob:respawn()
            xi.test.world:tick()

            player:setWeather(xi.weather.NONE)
            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(mob)
            end

            mob.assert.no:isSpawned()
        end)
    end)

    describe('spawn wave window', function()
        it('only spawns mobs within the 15 second window', function()
            local mob = player.entities:moveTo('Wild_Rabbit')
            mob:setRespawnTime(50)
            mob:despawn()

            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()

            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)
    end)

    -- Xolotl in Attohwa Chasm: night spawn with 21-24 hour respawn timer
    describe('timed night spawns', function()
        it('does not respawn killed Xolotl on next night', function()
            player:gotoZone(xi.zone.ATTOHWA_CHASM)
            xi.test.world:setVanaTime(22, 0)

            local ID = zones[xi.zone.ATTOHWA_CHASM]
            local xolotl = player.entities:get(ID.mob.XOLOTL)
            xolotl:respawn()
            xi.test.world:tick()

            player:claimAndKillMob(xolotl)

            -- Skip to next night (about 24 vana hours)
            xi.test.world:setVanaTime(22, 0)
            xi.test.world:tick(xi.tick.SPAWN)

            xolotl.assert.no:isSpawned()
        end)

        it('respawns Xolotl after natural despawn at dawn', function()
            player:gotoZone(xi.zone.ATTOHWA_CHASM)
            xi.test.world:setVanaTime(22, 0)

            local ID = zones[xi.zone.ATTOHWA_CHASM]
            local xolotl = player.entities:get(ID.mob.XOLOTL)
            xolotl:respawn()
            xi.test.world:tick()

            xolotl.assert:isSpawned()

            -- Move to dawn (4:00) - should trigger natural despawn
            xi.test.world:setVanaTime(4, 0)
            xi.test.world:tick(xi.tick.TIME)
            for _ = 1, 10 do
                xi.test.world:skipTime(5)
                xi.test.world:tickEntity(xolotl)
            end

            xolotl.assert.no:isSpawned()

            -- Next night it should spawn
            xi.test.world:setVanaTime(22, 0)
            xolotl:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)

            xolotl.assert:isSpawned()
        end)
    end)

    -- Nunyenunc NM and Carrion Crow PH in West Sarutabaruta
    describe('placeholder to NM', function()
        it('spawns NM when lottery succeeds', function()
            player:gotoZone(xi.zone.WEST_SARUTABARUTA)
            local ID = zones[xi.zone.WEST_SARUTABARUTA]
            local nm = player.entities:get(ID.mob.NUNYENUNC)
            local ph = player.entities:get(ID.mob.NUNYENUNC - 1)

            for _ = 1, 100 do
                if nm:isSpawned() then
                    break
                end

                player:claimAndKillMob(ph)
                xi.test.world:skipTime(305)
                xi.test.world:tick(xi.tick.SPAWN)
            end

            nm.assert:isSpawned()
        end)

        it('respawns placeholder when NM dies', function()
            player:gotoZone(xi.zone.WEST_SARUTABARUTA)
            local ID = zones[xi.zone.WEST_SARUTABARUTA]
            local nm = player.entities:get(ID.mob.NUNYENUNC)
            local ph = player.entities:get(ID.mob.NUNYENUNC - 1)

            for _ = 1, 100 do
                if nm:isSpawned() then
                    break
                end

                player:claimAndKillMob(ph)
                xi.test.world:skipTime(305)
                xi.test.world:tick(xi.tick.SPAWN)
            end

            player:claimAndKillMob(nm)
            xi.test.world:skipTime(305)
            xi.test.world:tick(xi.tick.SPAWN)
            ph.assert:isSpawned()
        end)
    end)
end)
