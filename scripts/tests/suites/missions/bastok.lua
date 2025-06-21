describe('Bastok Missions', function()
    local client, player

    before_each(function()
        client, player = xi.test.world:spawnPlayer()

        player:setNation(xi.nation.BASTOK)

        -- SOA first cutscene conflicts
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)
        local missionStatus = player:getMissionStatus(xi.mission.log_id.SOA)
        missionStatus = utils.mask.setBit(missionStatus, 0, true)
        missionStatus = utils.mask.setBit(missionStatus, 1, true)
        player:setMissionStatus(xi.mission.log_id.SOA, missionStatus)
        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)
    end)

    describe('The Zeruhn Report', function()
        it('should complete the mission', function()
            player:setRank(1)

            -- Pick up mission from gate guard.
            client:gotoZone(xi.zone.BASTOK_MARKETS)
            client:gotoAndTriggerEntity('Cleades', { eventId = 1000, finishOption = 0 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            -- Go to Zeruhn Mines and speak to Makarim to get Report Keyitem.
            client:gotoZone(xi.zone.ZERUHN_MINES)
            client:gotoAndTriggerEntity('Rasmus', { eventId = 120 }) -- Optional event.
            client:gotoAndTriggerEntity('Makarim', { eventId = 121 })
            assert.player(player).has.ki(xi.ki.ZERUHN_REPORT)

            -- Hand over the report to Naji in Metalworks.
            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Naji', { eventId = 710 })
            assert.player(player).no.ki(xi.ki.ZERUHN_REPORT)
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            assert.is_true(player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT))
        end)
    end)

    describe('A Geological Survey', function()
        it('should complete the mission', function()
            player:setRank(1)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)

            -- Pick up mission from gate guard
            client:gotoZone(xi.zone.BASTOK_MARKETS)
            client:gotoAndTriggerEntity('Cleades', { eventId = 1001, finishOption = 1 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)

            -- Talk to Cid in Metalworks to get Keyitem Blue Acidity Tester.
            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 503 })
            assert.player(player).has.ki(xi.ki.BLUE_ACIDITY_TESTER)

            -- Use the tester at one of the geysers in Dangruf Wadi.
            client:gotoZone(xi.zone.DANGRUF_WADI, { x = -133, y = 3, z = 133 })
            xi.test.world:skipTime(10)
            xi.test.world:tick()
            client:expectEvent({ eventId = 10 })
            assert.player(player).no.ki(xi.ki.BLUE_ACIDITY_TESTER)
            assert.player(player).has.ki(xi.ki.RED_ACIDITY_TESTER)

            -- Head back to Cid and give the test results.
            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 504 })
            assert.player(player).no.ki(xi.ki.BLUE_ACIDITY_TESTER)
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            assert(player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY))
        end)
    end)

    describe('Fetichism', function()
        it('should complete the mission', function()
            player:setRank(1)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)

            -- Pick up mission from gate guard
            client:gotoZone(xi.zone.BASTOK_MARKETS)
            client:gotoAndTriggerEntity('Cleades', { eventId = 1001, finishOption = 2 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)

            -- Get the items requested.
            player:addItem(xi.item.QUADAV_FETICH_HEAD)
            player:addItem(xi.item.QUADAV_FETICH_TORSO)
            player:addItem(xi.item.QUADAV_FETICH_ARMS)
            player:addItem(xi.item.QUADAV_FETICH_LEGS)

            -- Trade items to complete mission.
            client:tradeNpc('Cleades',
                {
                    xi.item.QUADAV_FETICH_HEAD,
                    xi.item.QUADAV_FETICH_TORSO,
                    xi.item.QUADAV_FETICH_ARMS,
                    xi.item.QUADAV_FETICH_LEGS,
                },
                { eventId = 1008 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            assert(player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM))
            assert.player(player).has.nationRank(2)
        end)
    end)

    describe('The Crystal Line', function()
        it('should complete the mission', function()
            player:setRank(2)
            player:setRankPoints(10000)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)

            -- Pick up mission from gate guard
            client:gotoZone(xi.zone.BASTOK_MARKETS)
            client:gotoAndTriggerEntity('Cleades', { eventId = 1001, finishOption = 3 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CRYSTAL_LINE)

            -- Goto Cid in metalworks and gives a crystal
            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 505, finishOption = 0 })

            -- Goto a teleport crag and trade a crystal to get a faded crystal
            client:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            player:addItem(xi.item.FIRE_CRYSTAL)
            client:tradeNpc('Telepoint', { xi.item.FIRE_CRYSTAL })
            assert(player:hasItem(xi.item.FADED_CRYSTAL))

            -- Got a Faded Crystal from a crag now trade it to Cid to get Keyitem C L Reports
            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 502 }) -- optional dialog
            client:tradeNpc('Cid', { xi.item.FADED_CRYSTAL }, { eventId = 506 })
            assert.player(player).has.ki(xi.ki.C_L_REPORT)

            -- Hand in Report
            client:gotoAndTriggerEntity('Naji', { eventId = 711 }) -- optional dialog
            client:gotoAndTriggerEntity('Ayame', { eventId = 712 })
            assert.player(player).no.ki(xi.ki.C_L_REPORT)
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            assert(player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CRYSTAL_LINE))
        end)
    end)

    describe('Wading Beasts', function()
        it('should complete the mission', function()
            player:setRank(2)
            player:setRankPoints(10000)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)

            -- Pick up mission from gate guard
            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Malduc', { eventId = 1001, finishOption = 4 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WADING_BEASTS)

            -- Trade a Lizard Egg to Alois
            player:addItem(xi.item.LIZARD_EGG)
            client:tradeNpc('Alois', { xi.item.LIZARD_EGG }, { eventId = 372 })
            assert.player(player).has.mission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            assert(player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WADING_BEASTS))
        end)
    end)
end)
