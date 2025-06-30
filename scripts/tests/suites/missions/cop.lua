describe('Chains of Promathia Missions', function()
    local client, player

    before_each(function()
        client, player = xi.test.world:spawnPlayer()
        player:setLevel(99)

        -- Mission conflicts
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
    end)

    describe('1-0 Ancient Flames Beckon', function()
        it("should progress through Lower Delkfutt's Tower cutscenes and advance to The Rites of Life", function()
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_FLAMES_BECKON)

            -- # COP 0
            -- zone into Lower Delkfutts Tower for a series of CS's
            client:gotoZone(xi.zone.QUFIM_ISLAND)
            client:gotoZone(xi.zone.LOWER_DELKFUTTS_TOWER)
            client:expectEvent({ eventId = 22 })
            client:expectEvent({ eventId = 36 })
            client:expectEvent({ eventId = 37 })
            client:expectEvent({ eventId = 38 })
            client:expectEvent({ eventId = 39 })
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE)
        end)
    end)

    describe('1-1 The Rites of Life', function()
        it('should complete quest with Monberaux and advance to Below the Arks', function()
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE)
            -- This var is set automatically when completing the previous mission
            player:setCharVar(
                string.format('Mission[%d][%d]Status', xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE), 1)

            -- # COP 1
            -- Zone into Upper Jeuno for a CS
            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:expectEvent({ eventId = 2 })

            -- trigger Monberaux for a series of CS's complete quest and get KI
            client:gotoAndTriggerEntity('Monberaux', { eventId = 10 })
            client:expectEvent({ eventId = 206 })
            client:expectEvent({ eventId = 207 })
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)
            assert.player(player).has.ki(xi.ki.MYSTERIOUS_AMULET)
        end)
    end)

    describe('1-2 Below the Arks - Holla', function()
        it('should complete Promyvion Holla and Spire battles to advance to The Mothercrystals', function()
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)

            -- trigger Pherimociel to goto next Prog
            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('Monberaux', { eventId = 9 })

            client:gotoZone(xi.zone.RULUDE_GARDENS)
            client:gotoAndTriggerEntity('High_Wind', { eventId = 33 })
            client:gotoAndTriggerEntity('Rainhard', { eventId = 34 })
            client:gotoAndTriggerEntity('Pherimociel', { eventId = 24 })

            -- optional dialog
            client:gotoAndTriggerEntity('Pherimociel', { eventId = 25 })

            -- entering hall of transference -> Promy Holla
            client:gotoZone(xi.zone.HALL_OF_TRANSFERENCE)
            -- TODO: Not seeing 108 on the capture
            client:expectEvent({ eventId = 108 })
            xi.test.world:loadZone(xi.zone.PROMYVION_HOLLA)
            client:gotoAndTriggerEntity('_0e3', { eventId = 160 })
            -- Is ported to promyvion after event.

            assert.is.equal(xi.zone.PROMYVION_HOLLA, player:getZoneID())
            -- 1st time entering gets a CS
            client:expectEvent({ eventId = 50 })

            -- Spire of Holla, trigger and enter BCNM, winning grants next mission
            client:gotoZone(xi.zone.SPIRE_OF_HOLLA)
            client:enterBcnmViaNpc('_0h0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_HOLLA)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })
            assert.player(player).has.ki(xi.ki.LIGHT_OF_HOLLA)
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
        end)
    end)

    describe('1-3 The Mothercrystals', function()
        it('should complete all three Promyvion battles and unlock teleports', function()
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
            player:addKeyItem(xi.ki.LIGHT_OF_HOLLA)
            --             player:setCharVar()
            --             player:setVar('M[6][3]Prog', 1) -- set at end of last mission

            -- TODO: Optional event not implemented?
            -- client:gotoZone(xi.zone.RULUDE_GARDENS)
            -- client:gotoAndTriggerEntity('Chapi_Galepilai', { eventId = 11 })

            -- entering next promy
            client:gotoZone(xi.zone.KONSCHTAT_HIGHLANDS)
            client:gotoAndTriggerEntity('Shattered_Telepoint')
            client:expectEvent({ eventId = 912 })

            -- CS on entering promy
            client:gotoZone(xi.zone.HALL_OF_TRANSFERENCE)
            client:gotoZone(xi.zone.PROMYVION_DEM)
            client:expectEvent({ eventId = 51 })

            -- Fight at BCNM
            client:gotoZone(xi.zone.SPIRE_OF_DEM)
            client:enterBcnmViaNpc('_0j0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_DEM)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })
            assert.player(player).has.ki(xi.ki.LIGHT_OF_DEM)

            -- going to next promy, cs inside hall of transference
            client:gotoZone(xi.zone.TAHRONGI_CANYON)
            client:gotoAndTriggerEntity('Shattered_Telepoint', { eventId = 913, finishOption = 0 })

            xi.test.world:loadZone(xi.zone.PROMYVION_MEA)

            -- event upon entering hall
            client:expectEvent({ eventId = 155 })

            -- TODO: This whole Promyvion section is a mess
            client:gotoZone(xi.zone.PROMYVION_MEA)

            -- Event upon entering promy
            client:expectEvent({ eventId = 52 })

            -- enter and beat BCNM
            client:gotoZone(xi.zone.SPIRE_OF_MEA)
            client:enterBcnmViaNpc('_0l0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_MEA)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })
            assert.player(player).has.ki(xi.ki.LIGHT_OF_MEA)

            -- check if mission completes
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)

            -- Mission complete check if new teleports work
            client:gotoZone(xi.zone.LUFAISE_MEADOWS)
            -- zone in cs
            client:expectEvent({ eventId = 110 })
            client:gotoAndTriggerEntity('Swirling_Vortex', { eventId = 100 })

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('Swirling_Vortex', { eventId = 554 })

            client:gotoZone(xi.zone.QUFIM_ISLAND)
            client:gotoAndTriggerEntity('Swirling_Vortex', { eventId = 300 })

            client:gotoZone(xi.zone.VALKURM_DUNES)
            client:gotoAndTriggerEntity('Swirling_Vortex', { eventId = 12 })
        end)
    end)

    describe('2-1 An Invitation West', function()
        it('should lose amulet in Lufaise and advance to The Lost City', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)
            player:addKeyItem(xi.ki.MYSTERIOUS_AMULET)

            -- zone in and lose amulet
            client:gotoZone(xi.zone.LUFAISE_MEADOWS)
            client:expectEvent({ eventId = 110 })
            assert.player(player).no.ki(xi.ki.MYSTERIOUS_AMULET)

            -- zone in to gain next mission
            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:expectEvent({ eventId = 101 })

            -- check if mission completes
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
        end)
    end)

    describe('2-2 The Lost City', function()
        it('should complete NPC interactions in Tavnazian Safehold', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('Despachiaire')
            client:expectEvent({ eventId = 102 })

            client:gotoAndTriggerEntity('Liphatte')
            client:expectEvent({ eventId = 301 })

            client:gotoAndTriggerEntity('Justinius')
            client:expectEvent({ eventId = 360 })

            client:gotoAndTriggerEntity('_0q1')
            client:expectEvent({ eventId = 103 })

            -- check if mission completes
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)
        end)
    end)

    describe('2-3 Distant Beliefs', function()
        it('should defeat Minotour in Phomiuna Aqueducts', function()
            -- Sewer door needs this mission explicitly completed to trigger event
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
            player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)

            -- setup mission
            xi.test.world:loadZone(xi.zone.PHOMIUNA_AQUEDUCTS)

            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('Justinius', { eventId = 123 })

            -- TODO: This trigger is not working. Supposed to warp to aqueducts
            -- client:gotoAndTriggerEntity('_0q1', { eventId = 502, finishOption = 1 })
            client:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)

            xi.test.world:skipTime(900)
            xi.test.world:tick()
            client:claimAndKillMob('Minotaur')

            -- TODO: This is the right Wooden_Ladder to trigger but it's not working D:
            -- client:gotoAndTriggerEntity(16888103, { eventId = 35 })
            -- client:gotoAndTriggerEntity('_0r5', { eventId = 36 })

            -- force events
            player:startEvent(35)
            client:expectEvent({ eventId = 35 })
            player:startEvent(36)
            client:expectEvent({ eventId = 36 })

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('Justinius', { eventId = 113 })

            -- check if mission completes
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)
        end)
    end)

    describe('2-4 An Eternal Melody', function()
        it('should complete NPC interactions and obtain Mysterious Amulet', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)

            -- TODO: Unimplemented optional CS?
            -- client:gotoAndTriggerEntity('Calengeard', { eventId = 395 })
            -- client:gotoAndTriggerEntity('Reaugettie', { eventId = 292 })

            client:gotoAndTriggerEntity('Justinius', { eventId = 125 })
            client:gotoAndTriggerEntity('_0qa', { eventId = 104 })
            assert.player(player).has.ki(xi.ki.MYSTERIOUS_AMULET)

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p0', { eventId = 5 })

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD, { x = -5, y = -24, z = 18 })
            xi.test.world:skipTime(1)
            xi.test.world:tick()
            client:expectEvent({ eventId = 105 })

            -- check if mission completes
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end)
    end)

    describe('2-5 Ancient Vows', function()
        it('should complete Monarch Linn BCNM and advance missions', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p2')
            client:expectEvent({ eventId = 6 })

            client:gotoZone(xi.zone.RIVERNE_SITE_A01)
            client:expectEvent({ eventId = 100 })

            -- Upcoming CS will dump us in Gustaberg
            xi.test.world:loadZone(xi.zone.SOUTH_GUSTABERG)

            client:gotoZone(xi.zone.MONARCH_LINN)
            client:enterBcnmViaNpc('SD_Entrance', xi.battlefield.id.ANCIENT_VOWS)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })

            assert.equal(xi.zone.SOUTH_GUSTABERG, player:getZoneID())
            client:expectEvent({ eventId = 906 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
        end)
    end)

    describe('3-1 The Call of the Wyrmking', function()
        it('should complete cutscenes in Bastok and advance mission', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)

            client:gotoZone(xi.zone.SOUTH_GUSTABERG)
            client:expectEvent({ eventId = 906 })

            client:gotoZone(xi.zone.PORT_BASTOK, { x = -100, y = 0, z = -10 })
            client:expectEvent({ eventId = 305 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 845 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
        end)
    end)

    describe('3-2 A Vessel Without a Captain', function()
        it('should complete story progression in Jeuno', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)

            client:gotoZone(xi.zone.LOWER_JEUNO)
            client:gotoAndTriggerEntity('_6tc', { eventId = 86 })

            client:gotoZone(xi.zone.RULUDE_GARDENS)
            -- Unimplemented optional CSs?
            -- client:gotoAndTriggerEntity('Auchefort', { eventId = 6 })
            -- client:gotoAndTriggerEntity('Pherimociel', { eventId = 26 })

            client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            client:expectEvent({ eventId = 65 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)
        end)
    end)

    describe('3-3 The Road Forks', function()
        it("should complete both San d'Oria and Windurst paths", function()
            local carpenterID = zones[xi.zone.CARPENTERS_LANDING]
            local chasmID = zones[xi.zone.ATTOHWA_CHASM]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)

            -- 1st Path
            client:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            client:expectEvent({ event = 14 })
            client:gotoAndTriggerEntity('Arnau', { eventId = 51 })
            client:gotoAndTriggerEntity('Chasalvige', { eventId = 38 })

            client:gotoZone(xi.zone.CARPENTERS_LANDING)
            client:gotoAndTriggerEntity('Guilloud')
            xi.test.world:tick()
            local ivy = client:getEntity(carpenterID.mob.OVERGROWN_IVY)
            assert.is_not_nil(ivy)
            assert(ivy:isSpawned())

            client:claimAndKillMob(ivy)
            xi.test.world:tick()

            client:gotoAndTriggerEntity('Guilloud', { event = 0 })

            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Hinaree', { event = 23 })
            client:gotoAndTriggerEntity('Hinaree', { event = 24 })

            -- 2nd Path
            client:gotoZone(xi.zone.WINDURST_WATERS)
            client:expectEvent({ event = 871 })
            client:gotoAndTriggerEntity('Ohbiru-Dohbiru', { event = 872 })

            client:gotoZone(xi.zone.WINDURST_WALLS)
            client:gotoAndTriggerEntity('Yoran-Oran', { event = 469 })

            client:gotoZone(xi.zone.WINDURST_WATERS)
            client:gotoAndTriggerEntity('Kyume-Romeh', { event = 873 })
            client:gotoAndTriggerEntity('Honoi-Gomoi', { event = 874 })
            assert.player(player).has.ki(xi.ki.CRACKED_MIMEO_MIRROR)

            client:gotoZone(xi.zone.WINDURST_WALLS)
            client:gotoAndTriggerEntity('Yoran-Oran', { eventId = 470 })
            assert.player(player).no.ki(xi.ki.CRACKED_MIMEO_MIRROR)

            client:gotoZone(xi.zone.ATTOHWA_CHASM)
            client:gotoAndTriggerEntity('Loose_Sand')
            xi.test.world:tick()
            local mob2 = client:getEntity(chasmID.mob.LIOUMERE)
            assert(mob2:isSpawned())

            client:claimAndKillMob(mob2)
            xi.test.world:tick()

            client:gotoAndTriggerEntity('Loose_Sand')
            assert.player(player).has.ki(xi.ki.MIMEO_JEWEL)

            client:gotoAndTriggerEntity('Cradle_of_Rebirth', { event = 2 })
            assert.player(player).no.ki(xi.ki.MIMEO_JEWEL)
            assert.player(player).has.ki(xi.ki.MIMEO_FEATHER)
            assert.player(player).has.ki(xi.ki.SECOND_MIMEO_FEATHER)
            assert.player(player).has.ki(xi.ki.THIRD_MIMEO_FEATHER)

            client:gotoZone(xi.zone.WINDURST_WALLS)
            client:gotoAndTriggerEntity('Yoran-Oran', { event = 471 })
            assert.player(player).no.ki(xi.ki.MIMEO_FEATHER)
            assert.player(player).no.ki(xi.ki.SECOND_MIMEO_FEATHER)
            assert.player(player).no.ki(xi.ki.THIRD_MIMEO_FEATHER)

            client:gotoZone(xi.zone.PORT_WINDURST)
            client:gotoAndTriggerEntity('Yujuju', { event = 592 })

            client:gotoZone(xi.zone.WINDURST_WATERS)
            client:gotoAndTriggerEntity('Tosuka-Porika', { event = 875 })

            client:gotoZone(xi.zone.WINDURST_WALLS)
            client:gotoAndTriggerEntity('Yoran-Oran', { event = 472 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { event = 847 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)
        end)
    end)

    describe('3-4 Tending Aged Wounds', function()
        it('should complete story progression in Lower Jeuno', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)

            client:gotoZone(xi.zone.LOWER_JEUNO)
            client:expectEvent({ event = 70 })

            client:gotoAndTriggerEntity('_6tc', { event = 22 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
        end)
    end)

    describe('3-5 Darkness Named', function()
        it('should complete Gray Chip quest and defeat Shrouded Maw BCNM', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)

            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('Monberaux', { event = 82 })

            client:gotoZone(xi.zone.LOWER_JEUNO)
            client:gotoAndTriggerEntity('Ghebi_Damomohe', { event = 54 })
            client:gotoAndTriggerEntity('Ghebi_Damomohe', { event = 53 })

            player:addItem(xi.item.GRAY_CHIP)
            client:tradeNpc('Ghebi_Damomohe', { xi.item.GRAY_CHIP }, { eventId = 52 })
            assert.player(player).has.ki(xi.ki.PSOXJA_PASS)

            client:gotoZone(xi.zone.THE_SHROUDED_MAW)
            client:expectEvent({ event = 2 })

            client:enterBcnmViaNpc('MC_Entrance', xi.battlefield.id.DARKNESS_NAMED)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })

            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('Monberaux', { event = 75 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)
        end)
    end)

    describe('4-1 Sheltering Doubt', function()
        it('should complete story progression in Tavnazian Safehold', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            xi.test.world:tick()
            client:expectEvent({ event = 107 })

            client:gotoAndTriggerEntity('Justinius')
            client:expectEvent({ event = 129 })

            client:gotoAndTriggerEntity('Despachiaire')
            client:expectEvent({ event = 108 })

            client:gotoAndTriggerEntity('Justinius')
            client:expectEvent({ event = 109 })

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p0')
            client:expectEvent({ event = 7 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
        end)
    end)

    describe('4-2 The Savage', function()
        it('should complete Monarch Linn BCNM for Savage battle', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p2', { eventId = 8, finishOption = 1 })

            client:gotoZone(xi.zone.RIVERNE_SITE_B01)

            client:gotoZone(xi.zone.MONARCH_LINN)
            client:enterBcnmViaNpc('SD_Entrance', xi.battlefield.id.SAVAGE)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('Justinius', { eventId = 110 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)
        end)
    end)

    describe('4-3 The Secrets of Worship', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.SACRARIUM]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('_0qa', { eventId = 111 })

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p8', { eventId = 9, finishOption = 1 })

            client:gotoZone(xi.zone.SACRARIUM)
            client:gotoAndTriggerEntity('_0s8', { eventId = 6 })
            SetServerVariable('Old_Prof_Spawn_Location', 3)

            local qm3 = client:getEntity('qm_prof_3')
            qm3:setLocalVar('hasProfessorMariselle', 1)
            client:gotoAndTriggerEntity('qm_prof_3')
            xi.test.world:tick()
            local professor = client:getEntity(ID.mob.OLD_PROFESSOR_MARISELLE)
            assert.is_not_nil(professor)
            assert(professor:isSpawned())

            client:claimAndKillMob(professor)
            xi.test.world:tick()
            client:gotoAndTriggerEntity('qm_prof_3')
            assert.player(player).has.ki(xi.ki.RELIQUIARIUM_KEY)

            client:gotoAndTriggerEntity('_0s8', { eventId = 5 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)
        end)
    end)

    describe('4-4 Slanderous Utterings', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD, { x = 106, y = -40, z = -80 })
            xi.test.world:skipTime(1)
            xi.test.world:tick()
            client:expectEvent({ eventId = 112 })

            client:gotoZone(xi.zone.SEALIONS_DEN)
            client:gotoAndTriggerEntity('_0w0', { eventId = 13 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)
        end)
    end)

    describe('5-1 The Enduring Tumult of War', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.PSOXJA]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)

            client:gotoZone(xi.zone.PORT_BASTOK)
            client:expectEvent({ eventId = 306 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 849 })
            client:gotoAndTriggerEntity('Cid', { eventId = 863 })

            client:gotoZone(xi.zone.PSOXJA, { x = -300, y = 0, z = 0 })
            -- Note: gotoZone isn't well suited for CS that requires careful positioning on zone in yet.
            -- Force event
            player:startEvent(1)
            client:expectEvent({ eventId = 1 })

            client:gotoAndTriggerEntity('_i98')
            local golem = client:getEntity(ID.mob.NUNYUNUWI)
            assert(golem:isSpawned())

            client:claimAndKillMob(golem)

            xi.test.world:loadZone(xi.zone.PROMYVION_VAHZL)
            client:gotoAndTriggerEntity('_i99', { eventId = 2, finishOption = 1 })

            assert.is.equal(xi.zone.PROMYVION_VAHZL, player:getZoneID())
            client:expectEvent({ eventId = 50 })
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
            assert.player(player).has.ki(xi.ki.LIGHT_OF_VAHZL)
        end)
    end)

    describe('5-2 Desires of Emptiness', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.PROMYVION_VAHZL]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)

            client:gotoZone(xi.zone.PROMYVION_VAHZL)

            client:gotoAndTriggerEntity('_0mc')
            local propagator = client:getEntity(ID.mob.PROPAGATOR)
            assert(propagator:isSpawned())
            client:claimAndKillMob(propagator)
            client:gotoAndTriggerEntity('_0mc', { eventId = 51 })

            client:gotoAndTriggerEntity('_0md')
            local policitor = client:getEntity(ID.mob.SOLICITOR)
            assert(policitor:isSpawned())
            client:claimAndKillMob(policitor)
            client:gotoAndTriggerEntity('_0md', { eventId = 52 })

            client:gotoAndTriggerEntity('_0m0')
            local ponderer = client:getEntity(ID.mob.PONDERER)
            assert(ponderer:isSpawned())
            client:claimAndKillMob(ponderer)
            client:gotoAndTriggerEntity('_0m0', { eventId = 53 })

            client:gotoZone(xi.zone.SPIRE_OF_VAHZL)
            client:expectEvent({ eventId = 20 })

            client:enterBcnmViaNpc('_0n0', xi.battlefield.id.DESIRES_OF_EMPTINESS)
            client:killBattlefieldMobs()
            xi.test.world:skipTime(15)
            xi.test.world:tick()
            -- player is sent to Beaucedine Glacier at end of event
            xi.test.world:loadZone(xi.zone.BEAUCEDINE_GLACIER)
            client:expectBcnmWin({ finishOption = 2 })
            client:expectEvent({ eventId = 206 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 850 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
        end)
    end)

    describe('5-3 Three Paths', function()
        it('should complete all three paths successfully', function()
            local upperID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)

            -- Louverance's Path
            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('Despachiaire', { eventId = 118 })

            client:gotoZone(xi.zone.WINDURST_WOODS)
            client:gotoAndTriggerEntity('Perih_Vashai', { eventId = 686 })

            client:gotoZone(xi.zone.BIBIKI_BAY)
            client:gotoAndTriggerEntity('Warmachine', { eventId = 33 })

            client:gotoZone(xi.zone.WINDURST_WALLS)
            client:gotoAndTriggerEntity('Yoran-Oran', { eventId = 481 })

            client:gotoZone(xi.zone.OLDTON_MOVALPOLOS)
            client:expectEvent({ eventId = 1 })

            client:gotoZone(xi.zone.MINE_SHAFT_2716)
            client:enterBcnmViaNpc('_0d0', xi.battlefield.id.CENTURY_OF_HARDSHIP)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 852 })

            client:gotoZone(xi.zone.OLDTON_MOVALPOLOS)
            client:gotoAndTriggerEntity('Tarnotik', { eventId = 34 })

            player:addItem(xi.item.GOLD_KEY)
            client:gotoZone(xi.zone.MINE_SHAFT_2716)
            client:tradeNpc('_0d0', { xi.item.GOLD_KEY }, { eventId = 3 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 853 })

            -- Tenzen's Path
            client:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            client:gotoAndTriggerEntity('qm3', { eventId = 203 })

            client:gotoZone(xi.zone.PSOXJA)
            client:gotoAndTriggerEntity('_09g', { eventId = 3 })

            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('Monberaux', { eventId = 74 })

            client:gotoZone(xi.zone.RULUDE_GARDENS)
            client:gotoAndTriggerEntity('Pherimociel', { eventId = 58 })

            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('Monberaux', { eventId = 6 })

            client:gotoZone(xi.zone.BATALLIA_DOWNS)
            client:gotoAndTriggerEntity('qm4', { eventId = 0 })
            client:gotoAndTriggerEntity('qm4', { eventId = 1 })
            assert.player(player).has.ki(xi.ki.DELKFUTT_RECOGNITION_DEVICE)

            client:gotoZone(xi.zone.LOWER_DELKFUTTS_TOWER)
            client:gotoAndTriggerEntity('_545')
            local idol = client:getEntity(upperID.mob.DISASTER_IDOL)
            assert(idol:isSpawned())
            client:claimAndKillMob(idol)
            xi.test.world:tick()
            client:gotoAndTriggerEntity('_545', { eventId = 25 })
            -- TODO: Are we supposed to lose the KI?
            -- assert.player(player).no.ki(xi.ki.DELKFUTT_RECOGNITION_DEVICE)

            client:gotoZone(xi.zone.PSOXJA)
            -- PsoXja CS conditions suck, force the event
            -- client:gotoZone(xi.zone.PSOXJA, { x = 220, y = -8, z = -282 })
            player:startEvent(4)
            client:expectEvent({ eventId = 4 })

            client:gotoAndTriggerEntity('_09h', { eventId = 5 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 854 })

            -- Ulmia's Path
            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Hinaree', { eventId = 22 })

            client:gotoZone(xi.zone.PORT_SAN_DORIA)
            client:expectEvent({ eventId = 4 })

            client:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Chasalvige', { eventId = 762 })

            client:gotoZone(xi.zone.WINDURST_WATERS)
            client:gotoAndTriggerEntity('Kerutoto', { eventId = 876 })

            client:gotoZone(xi.zone.WINDURST_WALLS)
            client:gotoAndTriggerEntity('Yoran-Oran', { eventId = 473 })

            client:gotoZone(xi.zone.BONEYARD_GULLY)
            client:enterBcnmViaNpc('_081', xi.battlefield.id.HEAD_WIND)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })

            -- TODO: BCNM not working?
            --             client:gotoZone(xi.zone.BEARCLAW_PINNACLE)
            --             client:enterBcnmViaNpc('Wind_Pillar_1', xi.battlefield.id.FLAMES_FOR_THE_DEAD)
            --             client:killBattlefieldMobs()
            --             client:expectBcnmWin({ finishOption = 2 })
            --
            --             client:gotoZone(xi.zone.METALWORKS)
            --             client:gotoAndTriggerEntity('Cid', { eventId = 855 })
            --
            --             assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        end)
    end)

    describe('6-1 For Whom the Verse is Sung', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)

            client:gotoZone(xi.zone.RULUDE_GARDENS)
            client:gotoAndTriggerEntity('Pherimociel', { eventId = 10046 })

            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('_6s1', { eventId = 10011 })

            client:gotoZone(xi.zone.RULUDE_GARDENS)
            xi.test.world:tick()
            client:expectEvent({ eventId = 10047 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)
        end)
    end)

    describe('6-2 A Place to Return', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.MISAREAUX_COAST]
            local mob1 = client:getEntity(ID.mob.PM6_2_MOB_OFFSET)
            local mob2 = client:getEntity(ID.mob.PM6_2_MOB_OFFSET + 1)
            local mob3 = client:getEntity(ID.mob.PM6_2_MOB_OFFSET + 2)

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)

            client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            client:expectEvent({ eventId = 10048 })

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p0')
            assert(mob1:isSpawned())
            client:claimAndKillMob(mob1)
            assert(mob2:isSpawned())
            client:claimAndKillMob(mob2)
            assert(mob3:isSpawned())
            client:claimAndKillMob(mob3)
            xi.test.world:tick()

            client:gotoAndTriggerEntity('_0p0', { eventId = 10 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)
        end)
    end)

    describe('6-3 More Questions Than Answers', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)

            client:gotoZone(xi.zone.RULUDE_GARDENS)
            client:gotoAndTriggerEntity('Pherimociel', { eventId = 10049 })

            client:gotoAndTriggerEntity('_6r9', { eventId = 10050 })

            client:gotoZone(xi.zone.SELBINA)
            client:gotoAndTriggerEntity('Mathilde', { eventId = 10005 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)
        end)
    end)

    describe('6-4 One to be Feared', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)

            -- Optional CS?
            --             client:gotoZone(xi.zone.SELBINA)
            --             client:gotoAndTriggerEntity('Mathilde', { eventId = 173 })
            --             client:gotoAndTriggerEntity('Mathilde', { eventId = 174 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 856 })

            client:gotoZone(xi.zone.SEALIONS_DEN)
            client:expectEvent({ eventId = 15 })

            client:gotoAndTriggerEntity('_0w0', { eventId = 31 })

            -- Event progression not working
            --             client:enterBcnmViaNpc('_0w0', xi.battlefield.id.ONE_TO_BE_FEARED)
            --             client:gotoAndTriggerEntity('Airship_Door', { eventId = 32003, finishOption = 100 })
            --             client:expectEvent({ eventId = 0 })
            --
            --             client:killBattlefieldMobs()         -- Kill mammets
            --             client:expectEvent({ eventId = 10 }) -- Move outside battlfield
            --
            --             -- Click door to enter next phase
            --             client:gotoAndTriggerEntity('Airship_Door', { eventId = 32003, finishOption = 100 })
            --             client:expectEvent({ eventId = 1 })
            --             client:killBattlefieldMobs()         -- Kill Omega
            --             client:expectEvent({ eventId = 11 }) -- Move outside battlfield again
            --
            --             -- Click door to enter next phase
            --             client:gotoAndTriggerEntity('Airship_Door', { eventId = 32003, finishOption = 100 })
            --             client:expectEvent({ eventId = 2 })
            --
            --             client:killBattlefieldMobs() -- Kill Ultima
            --             client:expectBcnmWin({ finishOption = 2 })
            --
            --             client:expectEvent({ eventId = 33 })
            --
            --             assert(player:getZoneID() == xi.zone.LUFAISE_MEADOWS)
            --             client:expectEvent({ eventId = 111 })
            --
            --             assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)
        end)
    end)

    describe('7-1 Chains and Bonds', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)

            client:gotoZone(xi.zone.LUFAISE_MEADOWS)
            xi.test.world:tick()
            client:expectEvent({ eventId = 111 })

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            xi.test.world:tick()
            xi.test.world:skipTime(2)
            client:expectEvent({ eventId = 114 })
            client:gotoAndTriggerEntity('_0q1', { eventId = 116 })

            client:gotoZone(xi.zone.SEALIONS_DEN)
            xi.test.world:tick()
            client:expectEvent({ eventId = 14 })

            client:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            client:gotoAndTriggerEntity('_0qa', { eventId = 115 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)
        end)
    end)

    describe('7-2 Flames in the Darkness', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p2', { eventId = 12 })

            client:gotoZone(xi.zone.SEALIONS_DEN)
            client:gotoAndTriggerEntity('Sueleen', { eventId = 16 })

            client:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            client:expectEvent({ eventId = 10051 })

            client:gotoZone(xi.zone.UPPER_JEUNO)
            client:gotoAndTriggerEntity('_6s1', { eventId = 10012 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
        end)
    end)

    describe('7-3 Fire in the Eyes of Men', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)

            client:gotoZone(xi.zone.MINE_SHAFT_2716)
            client:gotoAndTriggerEntity('_0d0', { eventId = 4 })

            client:gotoZone(xi.zone.METALWORKS)
            client:gotoAndTriggerEntity('Cid', { eventId = 857 })

            xi.test.world:skipTime(86405)
            xi.test.world:tick()

            client:gotoAndTriggerEntity('Cid', { eventId = 890 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)
        end)
    end)

    describe('7-4 Calm Before the Storm', function()
        it('should complete the mission successfully', function()
            local boggelmann = client:getEntity(zones[xi.zone.MISAREAUX_COAST].mob.BOGGELMANN)
            local crypton    = client:getEntity(zones[xi.zone.CARPENTERS_LANDING].mob.CRYPTONBERRY_EXECUTOR)

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)

            client:gotoZone(xi.zone.MISAREAUX_COAST)
            client:gotoAndTriggerEntity('_0p4')
            assert(boggelmann:isSpawned())
            client:claimAndKillMob(boggelmann)
            client:gotoAndTriggerEntity('_0p4', { eventId = 13 })
            assert.player(player).has.ki(xi.ki.VESSEL_OF_LIGHT)

            client:gotoZone(xi.zone.CARPENTERS_LANDING)
            client:gotoAndTriggerEntity('qm_cryptonberries')
            assert(crypton:isSpawned())
            client:claimAndKillMob(crypton)
            player:setLocalVar(
                string.format('Mission[%d][%d]carpentersNm', xi.mission.log_id.COP,
                    xi.mission.id.cop.CALM_BEFORE_THE_STORM),
                15)
            client:gotoAndTriggerEntity('qm_cryptonberries', { eventId = 37 })

            client:gotoZone(xi.zone.BIBIKI_BAY)
            local dalham = client:getEntity('Dalham')
            client:gotoAndTriggerEntity('qm_dalham')
            assert(dalham:isSpawned())
            client:claimAndKillMob(dalham)
            client:gotoAndTriggerEntity('qm_dalham', { eventId = 41 })

            client:gotoZone(xi.zone.METALWORKS)
            --             client:gotoAndTriggerEntity('Cid', { eventId = 891 })
            client:gotoAndTriggerEntity('Cid', { eventId = 892 })
            assert.player(player).has.ki(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE)

            client:gotoZone(xi.zone.SEALIONS_DEN)
            client:gotoAndTriggerEntity('Sueleen', { eventId = 17 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)
        end)
    end)

    describe('7-5 The Warriors Path', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)

            client:gotoZone(xi.zone.SEALIONS_DEN)
            client:gotoAndTriggerEntity('_0w0', { eventId = 32 })
            -- Post BCNM will warp to AlTaieu
            xi.test.world:loadZone(xi.zone.ALTAIEU)

            client:enterBcnmViaNpc('_0w0', xi.battlefield.id.WARRIORS_PATH)
            -- TODO: Tenzen can't be killed and causes this call to fail
            --             client:killBattlefieldMobs()
            --             client:expectBcnmWin({ finishOption = 2 })
            --             client:expectEvent({ eventId = 1 })
            --
            --             assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)
        end)
    end)

    describe('8-1 Garden of Antiquity', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

            client:gotoZone(xi.zone.ALTAIEU)
            client:gotoAndTriggerEntity('_0x0', { eventId = 164 })

            local southMob1 = client:getEntity(16912829)
            local southMob2 = client:getEntity(16912829 + 1)
            local southMob3 = client:getEntity(16912829 + 2)
            client:gotoAndTriggerEntity('_0x1')
            assert(southMob1:isSpawned())
            assert(southMob2:isSpawned())
            assert(southMob3:isSpawned())
            client:claimAndKillMob(southMob1)
            client:claimAndKillMob(southMob2)
            client:claimAndKillMob(southMob3)
            client:gotoAndTriggerEntity('_0x1', { eventId = 161 })

            local westMob1 = client:getEntity(16912832)
            local westMob2 = client:getEntity(16912832 + 1)
            local westMob3 = client:getEntity(16912832 + 2)
            client:gotoAndTriggerEntity('_0x2')
            assert(westMob1:isSpawned())
            assert(westMob2:isSpawned())
            assert(westMob3:isSpawned())
            client:claimAndKillMob(westMob1)
            client:claimAndKillMob(westMob2)
            client:claimAndKillMob(westMob3)
            client:gotoAndTriggerEntity('_0x2', { eventId = 162 })

            local eastMob1 = client:getEntity(16912835)
            local eastMob2 = client:getEntity(16912835 + 1)
            local eastMob3 = client:getEntity(16912835 + 2)
            client:gotoAndTriggerEntity('_0x3')
            assert(eastMob1:isSpawned())
            assert(eastMob2:isSpawned())
            assert(eastMob3:isSpawned())
            client:claimAndKillMob(eastMob1)
            client:claimAndKillMob(eastMob2)
            client:claimAndKillMob(eastMob3)
            client:gotoAndTriggerEntity('_0x3', { eventId = 163 })

            client:gotoAndTriggerEntity('_0x0', { eventId = 100 })

            client:gotoZone(xi.zone.GRAND_PALACE_OF_HUXZOI)
            xi.test.world:tick()
            client:gotoAndTriggerEntity('_iya', { eventId = 1 })
            client:gotoAndTriggerEntity('_iyb', { eventId = 2 })
            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
        end)
    end)

    describe('8-2 A Fate Decided', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)

            client:gotoZone(xi.zone.GRAND_PALACE_OF_HUXZOI)
            client:gotoAndTriggerEntity('_iyq')
            local mob = client:getEntity(ID.mob.IXGHRAH)
            assert.is_not_nil(mob)
            assert(mob:isSpawned())
            client:claimAndKillMob(mob)
            client:gotoAndTriggerEntity('_iyq', { eventId = 3 })

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
        end)
    end)

    describe('8-3 When Angels Fall', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
            player:addKeyItem(xi.ki.BRAND_OF_DAWN)
            player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)

            client:gotoZone(xi.zone.THE_GARDEN_OF_RUHMET)
            xi.test.world:tick()
            client:expectEvent({ eventId = 201 })
            assert.player(player).has.ki(xi.ki.MYSTERIOUS_AMULET_PRISHE)

            -- Hume Ebon Panel
            client:gotoAndTriggerEntity('_iz2', { eventId = 202 })

            -- Eden was missing this event
            client:gotoAndTriggerEntity('_iz2', { eventId = 120, finishOption = 1 })
            assert.player(player).has.ki(xi.ki.LIGHT_OF_VAHZL)

            client:gotoAndTriggerEntity('_0z0', { eventId = 203 })

            client:enterBcnmViaNpc('_0z0', xi.battlefield.id.WHEN_ANGELS_FALL)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })

            client:gotoAndTriggerEntity('_0zt', { eventId = 204 })

            -- Begin: Eden was missing this section
            client:gotoZone(xi.zone.ALTAIEU)
            client:expectEvent({ eventId = 165 })
            assert.player(player).no.ki(xi.ki.MYSTERIOUS_AMULET_PRISHE)
            -- End: Eden was missing this section

            assert.player(player).has.mission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
        end)
    end)
end)
