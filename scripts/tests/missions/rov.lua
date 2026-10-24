describe('Rhapsodies of Vana\'diel', function()
    ---@type CClientEntityPair
    local player

    --
    -- Setup
    --

    before_each(function()
        player = xi.test.world:spawnPlayer()
        player:setLevel(99)

        -- Mission conflicts
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
    end)

    --
    -- Missions
    --

    describe('1-1 - Rhapsodies of Vana\'diel', function()
        local rovEntryZones =
        {
            ['Bastok Markets']       = xi.zone.BASTOK_MARKETS,
            ['Bastok Mines']         = xi.zone.BASTOK_MINES,
            ['Northern San d\'Oria'] = xi.zone.NORTHERN_SAN_DORIA,
            ['Port Bastok']          = xi.zone.PORT_BASTOK,
            ['Port San d\'Oria']     = xi.zone.PORT_SAN_DORIA,
            ['Port Windurst']        = xi.zone.PORT_WINDURST,
            ['Southern San d\'Oria'] = xi.zone.SOUTHERN_SAN_DORIA,
            ['Windurst Walls']       = xi.zone.WINDURST_WALLS,
            ['Windurst Waters']      = xi.zone.WINDURST_WATERS,
            ['Windurst Woods']       = xi.zone.WINDURST_WOODS,
        }

        local missionBody = function(zoneId)
            player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)

            player:gotoZone(zoneId)

            -- TODO: We should be checking for the outcome where the player has asked to view
            -- the cutscene later, and so doesn't complete it now.
            player.events:expect({ eventId = 30035 })

            player.assert:hasMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        end

        for zoneName, zoneId in pairs(rovEntryZones) do
            it(fmt('get intro CS upon entering {}', zoneName), function()
                missionBody(zoneId)
            end)
        end
    end)

    describe('1-18 - Ring My Bell', function()
        before_each(function()
            player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RING_MY_BELL)
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
            player:gotoZone(xi.zone.NORG)
        end)

        it('is blocked during Dawn before The Chains Fall Free', function()
            xi.mission.setVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Status', 7)

            player.entities:gotoAndTrigger('_700', { eventId = 283 })

            player.assert:hasMission(xi.mission.log_id.ROV, xi.mission.id.rov.RING_MY_BELL)
        end)

        it('plays once The Chains Fall Free has been seen', function()
            xi.mission.setVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Status', 8)

            player.entities:gotoAndTrigger('_700', { eventId = 284 })

            player.assert:hasMission(xi.mission.log_id.ROV, xi.mission.id.rov.SPIRITS_AWOKEN)
        end)
    end)
end)
