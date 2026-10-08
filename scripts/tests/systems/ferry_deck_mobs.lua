describe('Ferry deck mobs', function()
    local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
    local deckMobIds =
    {
        ID.mob.SEA_CRAB[1],
        ID.mob.SEA_CRAB[2],
        ID.mob.SEA_PUGIL[2],
        ID.mob.SEA_PUGIL[3],
        ID.mob.SEA_MONK[2],
        ID.mob.SEA_HORROR,
        ID.mob.PHANTOM,
        ID.mob.THUNDER_ELEMENTAL,
        ID.mob.WATER_ELEMENTAL,
    }

    ---@type CClientEntityPair
    local player
    local zone
    local now
    local roll
    local turns
    local pick
    local calls
    local spawnCalls
    local despawnCalls
    local deckMobs

    before_each(function()
        now      = 1000000
        roll     = 100
        turns    = 4
        pick     = 1
        calls    = {}
        deckMobs = {}

        stub('GetSystemTime', function()
            return now
        end)

        -- Every roll is pinned. The percentage rolls, the fade turns and the slot pick all come from the test.
        stub('math.randomInt', function(minimum, maximum)
            table.insert(calls, { minimum, maximum })

            if minimum == 1 and maximum == 100 then
                return roll
            elseif minimum == 3 and maximum == 9 then
                return turns
            end

            return math.max(minimum, math.min(pick, maximum))
        end)

        xi.test.world:setVanaTime(12, 0)

        player = xi.test.world:spawnPlayer()
        player:gotoZone(xi.zone.SHIP_BOUND_FOR_SELBINA)
        zone = GetZone(xi.zone.SHIP_BOUND_FOR_SELBINA)
        assert(zone, 'Ship bound for Selbina is not loaded')
        player:setWeather(xi.weather.SUNSHINE)

        for _, mobId in ipairs(deckMobIds) do
            local mob = player.entities:get(mobId)
            assert(mob, 'deck mob is not loaded')
            mob:despawn()
            table.insert(deckMobs, mob)
        end

        -- Zones tick on their own, so pin the next roll one minute out.
        zone:setLocalVar('[ferry]nextRoll', now + 60)
        calls = {}

        spawnCalls   = spy('SpawnMob')
        despawnCalls = spy('DespawnMob')
    end)

    after_each(function()
        if player:getPet() then
            player:despawnPet()
        end

        for _, mob in ipairs(deckMobs) do
            mob:despawn()
        end

        if zone then
            zone:setLocalVar('[ferry]nextRoll', 0)
        end
    end)

    it('rolls once a minute, skips two rolls after a boarding and gets harder as the deck fills', function()
        roll = 30
        now  = now + 59
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(0)

        now = now + 1
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(1)
        assert(zone:getLocalVar('[ferry]nextRoll') == now + 180)
        assert(calls[1][1] == 1 and calls[1][2] == 100, 'the minute roll did not run first')
        assert(calls[2][1] == 1 and calls[2][2] == 6, 'the pick did not cover exactly the six hidden daytime slots')
        despawnCalls:calledWith(ID.mob.SEA_CRAB[1], 280)

        -- The next two rolls are skipped.
        roll = 1
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        now = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(1)

        -- With one mob up a 21 misses and a 20 boards. The boarded slot has left the pick.
        roll = 21
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(1)
        assert(zone:getLocalVar('[ferry]nextRoll') == now + 60)

        calls = {}
        roll  = 20
        now   = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(2)
        assert(calls[2][2] == 5, 'a boarded slot stayed in the pick')

        -- With two up only an 8 boards. With three up nothing does.
        roll = 9
        now  = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(2)

        roll = 8
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(3)

        roll = 1
        now  = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(3)
    end)

    it('does not board on a miss or catch up on missed minutes', function()
        roll = 31
        now  = now + 600
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(0)
        assert(zone:getLocalVar('[ferry]nextRoll') == now + 60)

        roll = 30
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        spawnCalls:called(0)
    end)

    it('treats Sea Horror as an ordinary slot that can board twice in one ride', function()
        roll = 30
        pick = 6
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        local seaHorror = player.entities:get(ID.mob.SEA_HORROR)
        assert(seaHorror and seaHorror:isSpawned(), 'Sea Horror was not picked')
        despawnCalls:calledWith(ID.mob.SEA_HORROR, 280)

        -- skipTime advances the mob clock. The stubbed roll clock stays fixed.
        seaHorror:clearPath()
        xi.test.world:skipTime(275)
        xi.test.world:tickEntity(seaHorror)
        seaHorror.assert:isSpawned()

        xi.test.world:skipTime(10)
        xi.test.world:tickEntity(seaHorror)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(seaHorror)
        seaHorror.assert.no:isSpawned()

        xi.test.world:skipTime(360)
        xi.test.world:tick(xi.tick.SPAWN)
        xi.test.world:tickEntity(seaHorror)
        seaHorror.assert.no:isSpawned()
        spawnCalls:called(1)

        now = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        seaHorror.assert:isSpawned()
        spawnCalls:called(2)
    end)

    it('lets Phantom into the roll only at night and leaves its fade to the spawn window', function()
        roll = 30
        pick = 7
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        local phantom = player.entities:get(ID.mob.PHANTOM)
        assert(phantom, 'Phantom is not loaded')
        phantom.assert.no:isSpawned()
        assert(calls[2][2] == 6, 'Phantom joined the daytime pick')

        xi.test.world:setVanaTime(21, 0)
        calls = {}
        roll  = 20
        now   = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        assert(calls[2][2] == 6, 'the night pick did not add Phantom to the five hidden slots')
        phantom.assert:isSpawned()
        despawnCalls:called(1)
    end)

    it('fades a night slot at 04:00 without giving it a daytime lifetime', function()
        xi.test.world:setVanaTime(20, 0)
        roll = 30
        pick = 7
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        local phantom = player.entities:get(ID.mob.PHANTOM)
        assert(phantom, 'Phantom is not loaded')
        phantom.assert:isSpawned()
        despawnCalls:called(0)

        xi.test.world:setVanaTime(3, 0)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(phantom)
        phantom.assert:isSpawned()

        -- The hourly tick closes the spawn window; setting Vana time alone does not run that hook.
        xi.test.world:tick(xi.tick.VANA_HOUR)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(phantom)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(phantom)
        phantom.assert.no:isSpawned()

        now = now + 180
        calls = {}
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        phantom.assert.no:isSpawned()
        assert(calls[2][2] == 6, 'Phantom stayed in the pick after 04:00')
    end)

    it('keeps a killed deck mob down until another winning roll boards it', function()
        roll = 30
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        local seaCrab = player.entities:get(ID.mob.SEA_CRAB[1])
        assert(seaCrab, 'Sea Crab is not loaded')
        seaCrab.assert:isSpawned()
        player:claimAndKillMob(seaCrab)
        seaCrab.assert.no:isSpawned()

        roll = 100
        xi.test.world:skipTime(360)
        xi.test.world:tick(xi.tick.SPAWN)
        xi.test.world:tickEntity(seaCrab)
        seaCrab.assert.no:isSpawned()
        spawnCalls:called(1)

        now = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        seaCrab.assert.no:isSpawned()
        spawnCalls:called(1)

        roll = 30
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        seaCrab.assert:isSpawned()
        spawnCalls:called(2)
    end)

    it('boards every daytime deck slot on all six routes', function()
        local shipSlots =
        {
            { 'SEA_CRAB', 1 },
            { 'SEA_CRAB', 2 },
            { 'SEA_PUGIL', 2 },
            { 'SEA_PUGIL', 3 },
            { 'SEA_MONK', 2 },
            { 'SEA_HORROR' },
        }
        local openSeaSlots =
        {
            { 'GUGRU_CRAB', 1 },
            { 'GUGRU_CRAB', 2 },
            { 'OCEAN_JAGIL', 1 },
            { 'OCEAN_JAGIL', 2 },
            { 'OCEAN_KRAKEN' },
        }
        local silverSeaSlots =
        {
            { 'APKALLU', 1 },
            { 'APKALLU', 2 },
            { 'BIGCLAW', 1 },
            { 'BIGCLAW', 2 },
            { 'CYAN_DEEP_PUGIL' },
            { 'KULSHEDRA' },
        }
        local routes =
        {
            { xi.zone.SHIP_BOUND_FOR_SELBINA, 'Ship_bound_for_Selbina', shipSlots },
            { xi.zone.SHIP_BOUND_FOR_MHAURA, 'Ship_bound_for_Mhaura', shipSlots },
            { xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI, 'Open_sea_route_to_Al_Zahbi', openSeaSlots },
            { xi.zone.OPEN_SEA_ROUTE_TO_MHAURA, 'Open_sea_route_to_Mhaura', openSeaSlots },
            { xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI, 'Silver_Sea_route_to_Al_Zahbi', silverSeaSlots },
            { xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU, 'Silver_Sea_route_to_Nashmau', silverSeaSlots },
        }

        for _, route in ipairs(routes) do
            roll = 100
            player:gotoZone(route[1])
            zone = GetZone(route[1])
            assert(zone, 'ferry zone is not loaded')
            player:setWeather(xi.weather.SUNSHINE)
            zone:setLocalVar('[ferry]nextRoll', now + 60)

            local mobs = {}
            for _, slot in ipairs(route[3]) do
                local mobId = zones[route[1]].mob[slot[1]]
                if slot[2] then
                    mobId = mobId[slot[2]]
                end

                local mob = player.entities:get(mobId)
                assert(mob, 'daytime deck slot is not loaded')
                mob:despawn()
                table.insert(mobs, mob)
                table.insert(deckMobs, mob)
            end

            spawnCalls:clear()
            for index, mob in ipairs(mobs) do
                roll  = 30
                pick  = index
                now   = now + 180
                calls = {}
                xi.zones[route[2]].Zone.onZoneTick(zone)
                mob.assert:isSpawned()
                spawnCalls:called(index)
                assert(spawnCalls.calls[index].args[1] == mob:getID(), 'route boarded a different slot')
                assert(calls[2][2] == #mobs, 'route included an unexpected daytime slot')
                mob:despawn()
            end

            zone:setLocalVar('[ferry]nextRoll', now + 60)
        end
    end)

    it('emerges ordinary Apkallu at the opposite rail and keeps them on the ferry after surfacing', function()
        roll = 100
        player:gotoZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)

        local almighty = GetMobByID(zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI].mob.ALMIGHTY_APKALLU)
        assert(almighty, 'Almighty Apkallu is not loaded')
        local almightySpawn = almighty:getSpawnPos()
        local routes =
        {
            { xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI, 'Silver_Sea_route_to_Al_Zahbi' },
            { xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU, 'Silver_Sea_route_to_Nashmau' },
        }

        for _, route in ipairs(routes) do
            roll = 100
            player:gotoZone(route[1])
            zone = GetZone(route[1])
            assert(zone, 'Silver Sea route is not loaded')
            player:setWeather(xi.weather.SUNSHINE)
            zone:setLocalVar('[ferry]nextRoll', now + 60)

            for index, mobId in ipairs(zones[route[1]].mob.APKALLU) do
                local mob = player.entities:get(mobId)
                assert(mob, 'ordinary Apkallu is not loaded')
                mob:despawn()
                table.insert(deckMobs, mob)

                for _ = 1, 2 do
                    roll = 30
                    pick = index
                    now  = now + 180
                    xi.zones[route[2]].Zone.onZoneTick(zone)
                    mob.assert:isSpawned()

                    local position = mob:getPos()
                    assert(position.x > 0 and almightySpawn.x < 0, 'ordinary Apkallu did not emerge opposite Almighty Apkallu')
                    assert(math.abs(position.x + almightySpawn.x) <= 0.001, 'ordinary Apkallu moved away from its emergence point during spawn')
                    assert(math.abs(position.y - almightySpawn.y) <= 0.001, 'ordinary Apkallu moved off its emergence height during spawn')
                    assert(math.abs(position.z - almightySpawn.z) <= 0.001, 'ordinary Apkallu moved along the rail during spawn')

                    local movedAfterSurfacing = false
                    for _, step in ipairs({ { 0, 6, true, true }, { 7, 6, true, true }, { 1, 5, false, true }, { 16, 5, false, true }, { 225, 5, false, false } }) do
                        for _ = 1, step[1] do
                            xi.test.world:tick(xi.tick.ZONE)
                            mob.assert:isSpawned()

                            local currentPosition = mob:getPos()
                            local moved =
                                math.abs(currentPosition.x - position.x) > 0.001 or
                                math.abs(currentPosition.y - position.y) > 0.001 or
                                math.abs(currentPosition.z - position.z) > 0.001

                            if step[4] then
                                assert(not moved, 'ordinary Apkallu slid during its emergence animation')
                                assert(mob:getAnimationSub() == step[2] and mob:getUntargetable() == step[3], 'ordinary Apkallu changed its emergence state during the boarding wait')
                            elseif moved then
                                movedAfterSurfacing = true
                            end
                        end

                        mob.assert:isSpawned()
                        assert(mob:getAnimationSub() == step[2], 'ordinary Apkallu changed its emergence pose at the wrong time')
                        assert(mob:getUntargetable() == step[3], 'ordinary Apkallu has the wrong emergence targetability')

                        player.packets:clear()
                        player:sendEntityUpdateToPlayer(mob, xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_HP)
                        local found = false
                        for _, packet in ipairs(player.packets:getIncoming()) do
                            if
                                packet.type == 0x00E and
                                packet.data[0x04] + packet.data[0x05] * 256 + packet.data[0x06] * 65536 + packet.data[0x07] * 16777216 == mobId
                            then
                                assert((bit.band(packet.data[0x2B], xi.nameVis.HIDE_NAME) ~= 0) == step[3], 'ordinary Apkallu has the wrong emergence name visibility')
                                found = true
                            end
                        end

                        assert(found, 'ordinary Apkallu name visibility packet was not sent')
                    end

                    assert(movedAfterSurfacing, 'ordinary Apkallu never resumed movement after surfacing')
                    mob:despawn()
                end
            end
        end

        roll = 100
        player:gotoZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)
        zone = GetZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)
        assert(zone, 'Silver Sea route to Al Zahbi is not loaded')
        zone:setLocalVar('[ferry]nextRoll', now + 60)

        almighty = player.entities:get(zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI].mob.ALMIGHTY_APKALLU)
        assert(almighty, 'Almighty Apkallu is not loaded')
        almighty:despawn()
        table.insert(deckMobs, almighty)
        SpawnMob(almighty:getID())
        assert(almighty:getAnimationSub() == 6 and almighty:getUntargetable(), 'Almighty Apkallu did not start hidden and untargetable')
        local almightyPosition = almighty:getPos()
        assert(math.abs(almightyPosition.x - almightySpawn.x) <= 0.001, 'Almighty Apkallu moved away from its emergence point during spawn')
        assert(math.abs(almightyPosition.y - almightySpawn.y) <= 0.001, 'Almighty Apkallu moved off its emergence height during spawn')
        assert(math.abs(almightyPosition.z - almightySpawn.z) <= 0.001, 'Almighty Apkallu moved along the rail during spawn')

        for tick = 1, 24 do
            xi.test.world:tick(xi.tick.ZONE)
            local currentPosition = almighty:getPos()
            assert(math.abs(currentPosition.x - almightyPosition.x) <= 0.001, 'Almighty Apkallu slid during its emergence animation')
            assert(math.abs(currentPosition.y - almightyPosition.y) <= 0.001, 'Almighty Apkallu changed height during its emergence animation')
            assert(math.abs(currentPosition.z - almightyPosition.z) <= 0.001, 'Almighty Apkallu moved along the rail during its emergence animation')

            if tick < 8 then
                assert(almighty:getAnimationSub() == 6 and almighty:getUntargetable(), 'Almighty Apkallu surfaced before three seconds')
            else
                assert(almighty:getAnimationSub() == 5 and not almighty:getUntargetable(), 'Almighty Apkallu did not remain surfaced during the boarding wait')
            end
        end

        local almightyMoved = false
        for _ = 1, 225 do
            xi.test.world:tick(xi.tick.ZONE)
            almighty.assert:isSpawned()
            local currentPosition = almighty:getPos()
            if
                math.abs(currentPosition.x - almightyPosition.x) > 0.001 or
                math.abs(currentPosition.y - almightyPosition.y) > 0.001 or
                math.abs(currentPosition.z - almightyPosition.z) > 0.001
            then
                almightyMoved = true
            end
        end

        assert(almightyMoved, 'Almighty Apkallu never resumed movement after its boarding wait')
        almighty:despawn()

        local apkallu = player.entities:get(zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI].mob.APKALLU[1])
        assert(apkallu, 'ordinary Apkallu is not loaded')
        SpawnMob(apkallu:getID())
        DespawnMob(apkallu:getID())
        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(apkallu)
        assert(not apkallu:isAlive(), 'interrupted Apkallu emergence remained alive')
        assert(apkallu:getAnimationSub() == 6 and apkallu:getUntargetable(), 'interrupted Apkallu emergence surfaced during its fade')
    end)

    it('lets combat interrupt the ordinary Apkallu boarding wait after surfacing', function()
        roll = 100
        player:gotoZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)
        player:setUnkillable(true)
        player:setHP(player:getMaxHP())
        zone = GetZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)
        assert(zone, 'Silver Sea route to Al Zahbi is not loaded')
        zone:setLocalVar('[ferry]nextRoll', now + 60)

        local apkallu = player.entities:get(zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI].mob.APKALLU[1])
        assert(apkallu, 'ordinary Apkallu is not loaded')
        apkallu:despawn()
        table.insert(deckMobs, apkallu)
        SpawnMob(apkallu:getID())
        apkallu.assert:isSpawned()
        local position = apkallu:getPos()

        for _ = 1, 8 do
            xi.test.world:tick(xi.tick.ZONE)
        end

        assert(apkallu:isAlive() and player:isAlive(), 'boarding combat fixture is not alive')
        assert(apkallu:getAnimationSub() == 5 and not apkallu:getUntargetable(), 'ordinary Apkallu did not surface before the combat check')
        local currentPosition = apkallu:getPos()
        assert(math.abs(currentPosition.x - position.x) <= 0.001, 'ordinary Apkallu left the rail before the combat check')
        assert(math.abs(currentPosition.y - position.y) <= 0.001, 'ordinary Apkallu changed height before the combat check')
        assert(math.abs(currentPosition.z - position.z) <= 0.001, 'ordinary Apkallu moved along the rail before the combat check')

        player.entities:moveTo(apkallu)
        apkallu:addEnmity(player, 100, 100)
        xi.test.world:tickEntity(apkallu)
        assert(apkallu:isAlive() and player:isAlive(), 'boarding combat fixture died before engagement')
        assert(apkallu:isEngaged(), 'ordinary Apkallu could not engage during its boarding wait')
        local target = apkallu:getTarget()
        assert(target and target:getID() == player:getID(), 'ordinary Apkallu engaged the wrong boarding passenger')
    end)

    it('boards elementals only under their weather when the lottery misses and fades them when it changes', function()
        roll = 30
        now  = now + 60
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        local waterElemental   = player.entities:get(ID.mob.WATER_ELEMENTAL)
        local thunderElemental = player.entities:get(ID.mob.THUNDER_ELEMENTAL)
        assert(waterElemental and thunderElemental, 'elementals are not loaded')
        waterElemental.assert.no:isSpawned()
        thunderElemental.assert.no:isSpawned()
        spawnCalls:called(1)

        -- The lottery takes the roll when it hits.
        player:setWeather(xi.weather.RAIN)
        roll = 20
        now  = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        waterElemental.assert.no:isSpawned()
        spawnCalls:called(2)

        -- With two up the lottery misses a 25 and the elemental takes the roll.
        roll = 25
        now  = now + 180
        xi.zones.Ship_bound_for_Selbina.Zone.onZoneTick(zone)
        waterElemental.assert:isSpawned()
        thunderElemental.assert.no:isSpawned()
        despawnCalls:called(2)

        player:setWeather(xi.weather.SUNSHINE)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(waterElemental)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(waterElemental)
        waterElemental.assert.no:isSpawned()
    end)

    local voyageRoutes =
    {
        { xi.zone.SHIP_BOUND_FOR_SELBINA, 'Ship_bound_for_Selbina', 'SEA_CRAB', 1 },
        { xi.zone.SHIP_BOUND_FOR_MHAURA, 'Ship_bound_for_Mhaura', 'SEA_CRAB', 1 },
        { xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI, 'Open_sea_route_to_Al_Zahbi', 'GUGRU_CRAB', 1 },
        { xi.zone.OPEN_SEA_ROUTE_TO_MHAURA, 'Open_sea_route_to_Mhaura', 'GUGRU_CRAB', 1 },
        { xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI, 'Silver_Sea_route_to_Al_Zahbi', 'BIGCLAW', 1 },
        { xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU, 'Silver_Sea_route_to_Nashmau', 'BIGCLAW', 1 },
        { xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES, 'Ship_bound_for_Selbina_Pirates', 'SHIP_WIGHT' },
        { xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES, 'Ship_bound_for_Mhaura_Pirates', 'SHIP_WIGHT' },
    }

    for _, route in ipairs(voyageRoutes) do
        it('clears every mob after disembarking from ' .. route[2], function()
            player:gotoZone(route[1])
            player:setUnkillable(true)
            player:setHP(player:getMaxHP())
            zone = GetZone(route[1])
            assert(zone, 'ferry zone is not loaded')
            zone:setLocalVar('[ferry]nextRoll', now + 180)
            zone:setLocalVar('nmCanSpawn', 0)

            local mobs = {}
            for _, entity in pairs(zone:getMobs()) do
                local mob = player.entities:get(entity:getID())
                assert(mob, 'ferry mob is not loaded')
                mob:despawn()
                SpawnMob(mob:getID())
                mob.assert:isSpawned()
                table.insert(mobs, mob)
                table.insert(deckMobs, mob)
            end

            assert(#mobs > 2, 'ferry population fixture is incomplete')
            local engagedId = zones[route[1]].mob[route[3]]
            if route[4] then
                engagedId = engagedId[route[4]]
            end

            local engaged = player.entities:get(engagedId)
            assert(engaged, 'ferry combat fixture is not loaded')
            local corpse = mobs[1]
            if corpse:getID() == engagedId then
                corpse = mobs[2]
            end

            corpse:setHP(0)
            xi.test.world:tickEntity(corpse)
            assert(not corpse:isAlive() and corpse:isSpawned(), 'ferry corpse fixture did not remain visible')

            player.entities:moveTo(engaged)
            engaged:addEnmity(player, 100, 100)
            xi.test.world:tickEntity(engaged)
            assert(engaged:isEngaged(), 'ferry combat fixture did not engage')

            local npcStates = {}
            for _, npc in pairs(zone:getNPCs()) do
                npcStates[npc:getID()] = npc:getStatus()
            end

            player:gotoZone(xi.zone.GM_HOME)
            assert(#zone:getPlayers() == 0, 'ferry still has a passenger')
            despawnCalls:clear()
            xi.zones[route[2]].Zone.onTransportVoyageEnd(zone)
            despawnCalls:called(#mobs)
            assert(zone:getLocalVar('[ferry]nextRoll') == now + 180, 'voyage cleanup reset the deck roll clock')

            xi.test.world:skipTime(4)
            for _, mob in ipairs(mobs) do
                xi.test.world:tickEntity(mob)
                mob.assert.no:isSpawned()
                assert(mob:getRespawnTime() == 0, 'departed mob kept a pending respawn')
            end

            -- A duplicate empty callback has no mob left to fade.
            despawnCalls:clear()
            xi.zones[route[2]].Zone.onTransportVoyageEnd(zone)
            despawnCalls:called(0)

            for _, npc in pairs(zone:getNPCs()) do
                assert(npc:getStatus() == npcStates[npc:getID()], 'voyage cleanup changed a ferry NPC')
            end
        end)
    end

    it('clears combat mobs at voyage end while an event keeps a passenger aboard', function()
        player:setUnkillable(true)
        player:setHP(player:getMaxHP())
        local monk   = player.entities:get(ID.mob.SEA_MONK[2])
        local horror = player.entities:get(ID.mob.SEA_HORROR)
        assert(monk and horror, 'ferry combat mobs are not loaded')
        SpawnMob(monk:getID())
        SpawnMob(horror:getID())
        monk.assert:isSpawned()
        horror.assert:isSpawned()

        player.entities:moveTo(monk)
        monk:addEnmity(player, 100, 100)
        xi.test.world:tickEntity(monk)
        assert(monk:isEngaged(), 'ferry mob did not engage the passenger')

        -- An active event makes DisembarkAll skip this passenger until the client finishes it.
        player:startEvent(255)
        assert(player:isInEvent(), 'passenger did not enter the arrival event')
        assert(monk:isEngaged(), 'arrival event cleared the combat fixture')
        assert(#zone:getPlayers() == 1, 'passenger left before voyage cleanup')
        xi.zones.Ship_bound_for_Selbina.Zone.onTransportVoyageEnd(zone)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(monk)
        xi.test.world:tickEntity(horror)
        monk.assert.no:isSpawned()
        horror.assert.no:isSpawned()
        assert(player:isInEvent() and player:getZoneID() == xi.zone.SHIP_BOUND_FOR_SELBINA, 'cleanup displaced the waiting passenger')
        assert(#zone:getPlayers() == 1, 'cleanup removed the waiting passenger')

        SpawnMob(monk:getID())
        monk.assert:isSpawned()
        assert(monk:isAlive(), 'voyage cleanup prevented a later fresh spawn')
        assert(next(monk:getEnmityList()) == nil, 'fresh spawn retained the ended voyage hate')
        player:release()
    end)

    it('detaches a charmed ferry mob when an arrival event keeps its owner aboard', function()
        player:setUnkillable(true)
        player:setHP(player:getMaxHP())
        local crab = player.entities:get(ID.mob.SEA_CRAB[1])
        assert(crab, 'ordinary Sea Crab is not loaded')
        SpawnMob(crab:getID())
        crab.assert:isSpawned()
        assert(crab:getMobMod(xi.mobMod.CHARMABLE) == 1, 'ordinary Sea Crab is not charmable')
        player.entities:moveTo(crab)
        player:charm(crab, 600)
        assert(crab:isCharmed(), 'Sea Crab did not enter the native charm lifecycle')
        local pet    = player:getPet()
        local master = crab:getMaster()
        assert(pet and pet:getID() == crab:getID(), 'charmed Sea Crab was not attached to its owner')
        assert(master and master:getID() == player:getID(), 'charmed Sea Crab has the wrong master')
        assert(crab:getAllegiance() == xi.allegiance.PLAYER, 'charmed Sea Crab did not become a player ally')

        player:startEvent(255)
        assert(player:isInEvent() and #zone:getPlayers() == 1, 'charmed mob owner did not remain aboard in the arrival event')
        xi.zones.Ship_bound_for_Selbina.Zone.onTransportVoyageEnd(zone)
        xi.test.world:skipTime(4)
        xi.test.world:tickEntity(crab)
        crab.assert.no:isSpawned()
        assert(player:isInEvent() and player:getZoneID() == xi.zone.SHIP_BOUND_FOR_SELBINA, 'cleanup displaced the charmed mob owner')
        assert(player:getPet() == nil, 'voyage cleanup left a hidden charmed mob attached to its owner')
        assert(not crab:isCharmed(), 'voyage cleanup retained the old charm state')
        assert(crab:getMaster() == nil, 'voyage cleanup retained the old master')
        assert(crab:getAllegiance() == xi.allegiance.MOB, 'voyage cleanup retained the old player allegiance')

        SpawnMob(crab:getID())
        crab.assert:isSpawned()
        assert(crab:isAlive() and not crab:isCharmed(), 'fresh Sea Crab life remained charmed')
        assert(crab:getMaster() == nil and player:getPet() == nil, 'fresh Sea Crab life restored the old pet links')
        assert(crab:getAllegiance() == xi.allegiance.MOB, 'fresh Sea Crab life retained player allegiance')
        player:release()
    end)

    it('cancels a hidden NM respawn and permits a later voyage to schedule it again', function()
        player:gotoZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)
        zone = GetZone(xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI)
        assert(zone, 'Silver Sea route to Al Zahbi is not loaded')
        zone:setLocalVar('[ferry]nextRoll', now + 180)

        local almighty = player.entities:get(zones[xi.zone.SILVER_SEA_ROUTE_TO_AL_ZAHBI].mob.ALMIGHTY_APKALLU)
        assert(almighty, 'Almighty Apkallu is not loaded')
        almighty:despawn()
        table.insert(deckMobs, almighty)
        almighty:setRespawnTime(300)
        assert(almighty:getRespawnTime() > 0, 'hidden NM did not receive a pending respawn')

        player:gotoZone(xi.zone.GM_HOME)
        xi.zones.Silver_Sea_route_to_Al_Zahbi.Zone.onTransportVoyageEnd(zone)
        assert(almighty:getRespawnTime() == 0, 'voyage cleanup left the hidden NM scheduled')
        xi.test.world:skipTime(360)
        xi.test.world:tick(xi.tick.SPAWN)
        almighty.assert.no:isSpawned()

        almighty:setRespawnTime(1)
        xi.test.world:tick(xi.tick.SPAWN)
        almighty.assert:isSpawned()
        assert(almighty:isAlive(), 'later NM schedule did not begin a fresh life')
    end)

    local pirateRoutes =
    {
        { xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES, 'Ship_bound_for_Selbina_Pirates', 'BLACKBEARD' },
        { xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES, 'Ship_bound_for_Mhaura_Pirates', 'SILVERHOOK' },
    }

    for _, route in ipairs(pirateRoutes) do
        it('closes the pirate NM lottery before forced despawn on ' .. route[2], function()
            player:gotoZone(route[1])
            zone = GetZone(route[1])
            assert(zone, 'pirate ferry is not loaded')
            zone:setLocalVar('nmCanSpawn', 0)
            local wight = player.entities:get(zones[route[1]].mob.SHIP_WIGHT)
            local nm    = player.entities:get(zones[route[1]].mob[route[3]])
            assert(wight and nm, 'pirate NM pair is not loaded')
            wight:despawn()
            nm:despawn()
            nm:setRespawnTime(0)
            table.insert(deckMobs, wight)
            table.insert(deckMobs, nm)
            SpawnMob(wight:getID())
            wight.assert:isSpawned()
            zone:setLocalVar('nmCanSpawn', 1)
            roll = 1

            player:gotoZone(xi.zone.GM_HOME)
            xi.zones[route[2]].Zone.onTransportVoyageEnd(zone)
            assert(zone:getLocalVar('nmCanSpawn') == 0, 'pirate NM lottery stayed open during voyage cleanup')
            xi.test.world:skipTime(4)
            xi.test.world:tickEntity(wight)
            wight.assert.no:isSpawned()
            assert(nm:getRespawnTime() == 0, 'forced Wight despawn scheduled the pirate NM')
            xi.test.world:tick(xi.tick.SPAWN)
            nm.assert.no:isSpawned()
            wight.assert.no:isSpawned()

            -- A new ride can explicitly rearm the Wight after the old ride is cleared.
            wight:setRespawnTime(1)
            xi.test.world:tick(xi.tick.SPAWN)
            wight.assert:isSpawned()
        end)
    end
end)
