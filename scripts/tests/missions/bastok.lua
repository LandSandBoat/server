describe('Bastok Missions', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()

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
            player:gotoZone(xi.zone.BASTOK_MARKETS)
            player.entities:gotoAndTrigger('Cleades', { eventId = 1000, finishOption = 0 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            -- Go to Zeruhn Mines and speak to Makarim to get Report Keyitem.
            player:gotoZone(xi.zone.ZERUHN_MINES)
            player.entities:gotoAndTrigger('Rasmus', { eventId = 120 }) -- Optional event.
            player.entities:gotoAndTrigger('Makarim', { eventId = 121 })
            player.assert:hasKI(xi.ki.ZERUHN_REPORT)

            -- Hand over the report to Naji in Metalworks.
            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Naji', { eventId = 710 })
            player.assert.no:hasKI(xi.ki.ZERUHN_REPORT)
            player.assert
                :hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
                :hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
        end)
    end)

    describe('A Geological Survey', function()
        it('should complete the mission', function()
            player:setRank(1)
            player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)
            player:completeMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT)

            -- Pick up mission from gate guard
            player:gotoZone(xi.zone.BASTOK_MARKETS)
            player.entities:gotoAndTrigger('Cleades', { eventId = 1001, finishOption = 1 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)

            -- Talk to Cid in Metalworks to get Keyitem Blue Acidity Tester.
            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 503 })
            player.assert:hasKI(xi.ki.BLUE_ACIDITY_TESTER)

            -- Use the tester at one of the geysers in Dangruf Wadi.
            player:gotoZone(xi.zone.DANGRUF_WADI, { x = -133, y = 3, z = 133 })
            player.events:expect({ eventId = 10 })
            player.assert
                .no:hasKI(xi.ki.BLUE_ACIDITY_TESTER)
                :hasKI(xi.ki.RED_ACIDITY_TESTER)

            -- Head back to Cid and give the test results.
            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 504 })
            player.assert.no:hasKI(xi.ki.BLUE_ACIDITY_TESTER)
            player.assert
                :hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
                :hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)
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
            player:gotoZone(xi.zone.BASTOK_MARKETS)
            player.entities:gotoAndTrigger('Cleades', { eventId = 1001, finishOption = 2 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)

            -- Get the items requested.
            player:addItem(xi.item.QUADAV_FETICH_HEAD)
            player:addItem(xi.item.QUADAV_FETICH_TORSO)
            player:addItem(xi.item.QUADAV_FETICH_ARMS)
            player:addItem(xi.item.QUADAV_FETICH_LEGS)

            -- Trade items to complete mission.
            player.actions:tradeNpc('Cleades',
                {
                    xi.item.QUADAV_FETICH_HEAD,
                    xi.item.QUADAV_FETICH_TORSO,
                    xi.item.QUADAV_FETICH_ARMS,
                    xi.item.QUADAV_FETICH_LEGS,
                },
                { eventId = 1008 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            player.assert:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM)
            player.assert:hasNationRank(2)
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
            player:gotoZone(xi.zone.BASTOK_MARKETS)
            player.entities:gotoAndTrigger('Cleades', { eventId = 1001, finishOption = 3 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CRYSTAL_LINE)

            -- Goto Cid in metalworks and gives a crystal
            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 505, finishOption = 0 })

            -- Goto a teleport crag and trade a crystal to get a faded crystal
            player:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            player:addItem(xi.item.FIRE_CRYSTAL)
            player.actions:tradeNpc('Telepoint', { xi.item.FIRE_CRYSTAL })
            player.assert:hasItem(xi.item.FADED_CRYSTAL)

            -- Got a Faded Crystal from a crag now trade it to Cid to get Keyitem C L Reports
            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 502 }) -- optional dialog
            player.actions:tradeNpc('Cid', { xi.item.FADED_CRYSTAL }, { eventId = 506 })
            player.assert:hasKI(xi.ki.C_L_REPORT)

            -- Hand in Report
            player.entities:gotoAndTrigger('Naji', { eventId = 711 }) -- optional dialog
            player.entities:gotoAndTrigger('Ayame', { eventId = 712 })
            player.assert.no:hasKI(xi.ki.C_L_REPORT)
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            player.assert:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CRYSTAL_LINE)
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
            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Malduc', { eventId = 1001, finishOption = 4 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WADING_BEASTS)

            -- Trade a Lizard Egg to Alois
            player:addItem(xi.item.LIZARD_EGG)
            player.actions:tradeNpc('Alois', { xi.item.LIZARD_EGG }, { eventId = 372 })
            player.assert:hasMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.NONE)
            player.assert:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WADING_BEASTS)
        end)
    end)
end)
