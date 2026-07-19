describe('Spawn Handler', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    describe('basic respawns', function()
        it('respawns a killed mob after its timer expires', function()
            local mob = player.entities:moveTo('Forest_Funguar')
            player:claimAndKillMob(mob)
            xi.test.world:skipTime(305)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('does not respawn a mob before its timer expires', function()
            local mob = player.entities:moveTo('Forest_Funguar')
            player:claimAndKillMob(mob)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert.no:isSpawned()
        end)

        it('respawns after deaggro with 60 second timer', function()
            local mob = player.entities:moveTo('River_Crab')
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
            player:gotoZone(xi.zone.YUGHOTT_GROTTO)
            xi.test.world:setVanaTime(18, 0)

            local mob = player.entities:moveTo('Grotto_Bats')
            mob:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            mob.assert:isSpawned()
        end)

        it('blocks evening mobs during day', function()
            player:gotoZone(xi.zone.YUGHOTT_GROTTO)
            xi.test.world:setVanaTime(12, 0)

            local mob = player.entities:moveTo('Grotto_Bats')
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
            local mob = player.entities:moveTo('Forest_Funguar')
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

            -- Advance hour by hour until the window closes and the natural despawn fires.
            local despawned = false
            for _ = 1, 24 do
                xi.test.world:tick(xi.tick.VANA_HOUR)
                xi.test.world:skipTime(1)
                xi.test.world:tickEntity(xolotl)
                if not xolotl:isSpawned() then
                    despawned = true
                    break
                end
            end

            assert(despawned, 'Xolotl did not despawn after its window closed')

            -- Next night it should spawn
            xi.test.world:setVanaTime(22, 0)
            xi.test.world:tick(xi.tick.SPAWN)

            xolotl.assert:isSpawned()
        end)
    end)

    describe('scripted spawns', function()
        it('respawns Simurgh after kill within respawn window', function()
            player:gotoZone(xi.zone.ROLANBERRY_FIELDS)
            local ID = zones[xi.zone.ROLANBERRY_FIELDS]
            local simurgh = player.entities:get(ID.mob.SIMURGH)

            -- Initial spawn
            xi.test.world:skipTime(7200)
            xi.test.world:tick(xi.tick.SPAWN)
            simurgh.assert:isSpawned()

            player:claimAndKillMob(simurgh)

            -- Skip 2 hours again for respawn
            xi.test.world:skipTime(7200)
            xi.test.world:tick(xi.tick.SPAWN)

            simurgh.assert:isSpawned()
        end)

        it('King Arthro spawns when all Knight Crabs killed and blocks their respawn', function()
            player:gotoZone(xi.zone.JUGNER_FOREST)
            local ID = zones[xi.zone.JUGNER_FOREST]
            local kingArthro = player.entities:get(ID.mob.KING_ARTHRO)

            -- Gather all 10 Knight Crabs and wait for initial spawn
            local knightCrabs = {}
            for offset = 1, 10 do
                knightCrabs[offset] = player.entities:get(ID.mob.KING_ARTHRO - offset)
            end

            xi.test.world:skipTime(12000)
            xi.test.world:tick(xi.tick.SPAWN)

            for _, crab in ipairs(knightCrabs) do
                crab.assert:isSpawned()
            end

            -- Kill all 10 Knight Crabs
            for _, crab in ipairs(knightCrabs) do
                player:claimAndKillMob(crab)
            end

            -- King Arthro should spawn
            xi.test.world:tick()
            kingArthro.assert:isSpawned()

            -- Let KA roam for some time - Knight Crabs should NOT respawn
            xi.test.world:skipTime(3600)
            xi.test.world:tick(xi.tick.SPAWN)
            for _, crab in ipairs(knightCrabs) do
                crab.assert.no:isSpawned()
            end

            -- Kill King Arthro
            player:claimAndKillMob(kingArthro)

            -- Skip past max respawn window (24h 10m)
            xi.test.world:skipTime(87000)
            xi.test.world:tick(xi.tick.SPAWN)

            -- Knight Crabs should now be respawned
            for _, crab in ipairs(knightCrabs) do
                crab.assert:isSpawned()
            end
        end)
    end)

    -- Per-mob spawn windows: spawnHour/despawnHour on mob_spawn_points.
    describe('per-mob spawn windows', function()
        -- Carpenters' Landing slot 3: two Bulldog Bats, 20:00-06:00, nothing else in the slot.
        local batSlot = 3
        -- West Ronfaure slot 3: Ding Bats (18:00-04:00) sharing with a Wild Rabbit that has no window.
        local sharedSlot = 3

        local function isBat(mob)
            return string.find(mob:getName(), 'Bat') ~= nil
        end

        local function anyBatUp(slot)
            for _, mob in ipairs(slot) do
                if isBat(mob) and mob:isSpawned() then
                    return true
                end
            end

            return false
        end

        -- Despawn the slot and let the wave re-roll it under the current time.
        local function reroll(slot)
            for _, mob in ipairs(slot) do
                mob:despawn()
            end

            for _ = 1, 20 do
                xi.test.world:tick(xi.tick.SPAWN)
            end
        end

        it('spawns a bat inside its window', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            xi.test.world:setVanaTime(22, 0)

            local slot = xi.test.world:getSpawnSlot(xi.zone.CARPENTERS_LANDING, batSlot)
            reroll(slot)

            assert(anyBatUp(slot), 'no bat spawned in window')
        end)

        it('does not spawn a bat outside its window', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            xi.test.world:setVanaTime(12, 0)

            local slot = xi.test.world:getSpawnSlot(xi.zone.CARPENTERS_LANDING, batSlot)
            reroll(slot)

            assert(not anyBatUp(slot), 'bat spawned outside its window')
        end)

        it('handles a window that wraps past midnight', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            xi.test.world:setVanaTime(2, 0) -- inside 20:00-06:00

            local slot = xi.test.world:getSpawnSlot(xi.zone.CARPENTERS_LANDING, batSlot)
            reroll(slot)

            assert(anyBatUp(slot), 'bat did not spawn after midnight')
        end)

        it('despawns a bat when its window closes', function()
            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            xi.test.world:setVanaTime(22, 0)

            local slot = xi.test.world:getSpawnSlot(xi.zone.CARPENTERS_LANDING, batSlot)
            reroll(slot)
            assert(anyBatUp(slot), 'no bat up before closing the window')

            -- Advance hour by hour; onGameHour despawns the bat once its window closes.
            local despawned = false
            for _ = 1, 24 do
                xi.test.world:tick(xi.tick.VANA_HOUR)
                xi.test.world:skipTime(1)
                for _, mob in ipairs(slot) do
                    xi.test.world:tickEntity(mob)
                end

                if not anyBatUp(slot) then
                    despawned = true
                    break
                end
            end

            assert(despawned, 'bat still up after its window closed')
        end)

        it('blocks the bat but keeps its slot-mate during the day', function()
            xi.test.world:setVanaTime(12, 0)

            local slot = xi.test.world:getSpawnSlot(xi.zone.WEST_RONFAURE, sharedSlot)
            reroll(slot)

            local mateUp = false
            for _, mob in ipairs(slot) do
                if isBat(mob) then
                    assert(not mob:isSpawned(), 'bat spawned during the day')
                else
                    mateUp = mateUp or mob:isSpawned()
                end
            end

            assert(mateUp, 'slot sat empty during the day')
        end)

        it('lets the bat win its shared slot at night', function()
            xi.test.world:setVanaTime(22, 0)

            local slot = xi.test.world:getSpawnSlot(xi.zone.WEST_RONFAURE, sharedSlot)

            -- Bat and slot-mate are both eligible at night, so re-roll until the bat wins.
            local won = false
            for _ = 1, 30 do
                reroll(slot)
                if anyBatUp(slot) then
                    won = true
                    break
                end
            end

            assert(won, 'bat never won its shared slot at night')
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
