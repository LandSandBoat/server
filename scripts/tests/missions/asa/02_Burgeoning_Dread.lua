describe('ASA M2 - Burgeoning Dread', function()
    ---@type CClientEntityPair
    local player

    local kits = set{
        xi.item.ENFEEBLEMENT_KIT_OF_POISON,
        xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS,
        xi.item.ENFEEBLEMENT_KIT_OF_SLEEP,
        xi.item.ENFEEBLEMENT_KIT_OF_SILENCE,
    }

    local function startFrom(zoneId)
        player = xi.test.world:spawnPlayer({ zone = zoneId, level = 10 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        if player:isInEvent() then
            player.events:finish()
        end
    end

    local function expectKitPicked(eventId)
        player.events:expect({ eventId = eventId, updates = { 0 } })
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
        assert(kits[player:getCharVar('Mission[11][2]Option')], 'Expected an enfeeblement kit to be picked')
    end

    it('completes on leaving the Woods for East Sarutabaruta', function()
        startFrom(xi.zone.WINDURST_WOODS)
        player:gotoZone(xi.zone.EAST_SARUTABARUTA)
        expectKitPicked(71)
    end)

    it('completes on leaving the Waters for West Sarutabaruta', function()
        startFrom(xi.zone.WINDURST_WATERS)
        player:gotoZone(xi.zone.WEST_SARUTABARUTA)
        expectKitPicked(62)
    end)

    it('completes on leaving Port Windurst for West Sarutabaruta', function()
        startFrom(xi.zone.PORT_WINDURST)
        player:gotoZone(xi.zone.WEST_SARUTABARUTA)
        expectKitPicked(63)
    end)

    it('waits when East Sarutabaruta is entered from elsewhere', function()
        startFrom(xi.zone.TAHRONGI_CANYON)
        player:gotoZone(xi.zone.EAST_SARUTABARUTA)

        player.events:expectNotInEvent()
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
    end)
end)
