describe('Chains of Promathia', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
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
            player:gotoZone(xi.zone.QUFIM_ISLAND)
            player:gotoZone(xi.zone.LOWER_DELKFUTTS_TOWER)

            -- TODO: check Tales' Beginning with option 0, talking to the Tales' Beginning, which starts CS 53.
            -- In CS 53, Send option 4 to accept CS, which will start CS 22 with out any options to select
            -- Also verify charvar for TalesBeginning
            player.events:expect({ eventId = 22, finishOption = 1 })
            player.events:expect({ eventId = 36 })
            player.events:expect({ eventId = 37 })
            player.events:expect({ eventId = 38 })
            player.events:expect({ eventId = 39 })
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_RITES_OF_LIFE)
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
            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.events:expect({ eventId = 2 })

            -- trigger Monberaux for a series of CS's complete quest and get KI
            player.entities:gotoAndTrigger('Monberaux', { eventId = 10 })
            player.events:expect({ eventId = 206 })
            player.events:expect({ eventId = 207 })
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)
            player.assert:hasKI(xi.ki.MYSTERIOUS_AMULET)
        end)
    end)

    describe('1-2 Below the Arks - Holla', function()
        it('should complete Promyvion Holla and Spire battles to advance to The Mothercrystals', function()
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.BELOW_THE_ARKS)

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Monberaux', { eventId = 9 })

            -- Ru'Lude Gardens: Trigger Pherimociel to goto next Prog
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('Pherimociel', { eventId = 24 })

            -- Ru'Lude Gardens: Optional dialog
            player.entities:gotoAndTrigger('Pherimociel', { eventId = 25 })
            player.entities:gotoAndTrigger('High_Wind', { eventId = 33 })
            player.entities:gotoAndTrigger('Rainhard', { eventId = 34 })

            -- entering hall of transference -> Promy Holla
            player:gotoZone(xi.zone.HALL_OF_TRANSFERENCE)
            -- TODO: Not seeing 108 on the capture
            player.events:expect({ eventId = 108 })

            player.entities:gotoAndTrigger('_0e3', { eventId = 160 })
            player.assert:inZone(xi.zone.PROMYVION_HOLLA)

            -- 1st time entering gets a CS
            player.events:expect({ eventId = 50 })

            -- Spire of Holla, trigger and enter BCNM, winning grants next mission
            player:gotoZone(xi.zone.SPIRE_OF_HOLLA)
            player.bcnm:enter('_0h0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_HOLLA)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })
            player.assert:hasKI(xi.ki.LIGHT_OF_HOLLA)
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
        end)
    end)

    describe('1-3 The Mothercrystals', function()
        it('should complete all three Promyvion battles and unlock teleports', function()
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS)
            player:addKeyItem(xi.ki.LIGHT_OF_HOLLA)

            -- entering next promy
            player:gotoZone(xi.zone.KONSCHTAT_HIGHLANDS)
            -- Touching the telepoint will warp us to Hall of Transference and then Promyvion-Dem
            player.entities:gotoAndTrigger('Shattered_Telepoint')
            player.events:expect({ eventId = 912 }) -- Hall of Transference
            player.events:expect({ eventId = 51 })  -- Promyvion-Dem
            player.assert:inZone(xi.zone.PROMYVION_DEM)

            -- Fight at BCNM
            player:gotoZone(xi.zone.SPIRE_OF_DEM)
            player.bcnm:enter('_0j0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_DEM)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })
            player.assert:hasKI(xi.ki.LIGHT_OF_DEM)

            -- going to next promy, cs inside hall of transference
            player:gotoZone(xi.zone.TAHRONGI_CANYON)
            player.entities:gotoAndTrigger('Shattered_Telepoint', { eventId = 913, finishOption = 0 })

            -- event upon entering hall
            player.assert:inZone(xi.zone.HALL_OF_TRANSFERENCE)
            player.events:expect({ eventId = 155 })

            -- Event upon entering promy
            player:gotoZone(xi.zone.PROMYVION_MEA)
            player.events:expect({ eventId = 52 })

            -- enter and beat BCNM
            player:gotoZone(xi.zone.SPIRE_OF_MEA)
            player.bcnm:enter('_0l0', xi.battlefield.id.ANCIENT_FLAMES_BECKON_SPIRE_OF_MEA)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            -- Should have Light of Mea and be teleported to Lufaise Meadows
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)
                :hasKI(xi.ki.LIGHT_OF_MEA)
                :inZone(xi.zone.LUFAISE_MEADOWS)

            -- zone in cs
            player.events:expect({ eventId = 110 })
            player.entities:gotoAndTrigger('Swirling_Vortex', { eventId = 100 })

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('Swirling_Vortex', { eventId = 554 })

            player:gotoZone(xi.zone.QUFIM_ISLAND)
            player.entities:gotoAndTrigger('Swirling_Vortex', { eventId = 300 })

            player:gotoZone(xi.zone.VALKURM_DUNES)
            player.entities:gotoAndTrigger('Swirling_Vortex', { eventId = 12 })
        end)
    end)

    describe('2-1 An Invitation West', function()
        it('should lose amulet in Lufaise and advance to The Lost City', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_INVITATION_WEST)
            player:addKeyItem(xi.ki.MYSTERIOUS_AMULET)

            -- zone in and lose amulet
            player:gotoZone(xi.zone.LUFAISE_MEADOWS)
            player.events:expect({ eventId = 110 })
            player.assert.no:hasKI(xi.ki.MYSTERIOUS_AMULET)

            -- zone in to gain next mission
            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.events:expect({ eventId = 101 })

            -- check if mission completes
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
        end)
    end)

    describe('2-2 The Lost City', function()
        it('should complete NPC interactions in Tavnazian Safehold', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('Despachiaire')
            player.events:expect({ eventId = 102 })

            player.entities:gotoAndTrigger('Liphatte')
            player.events:expect({ eventId = 301 })

            player.entities:gotoAndTrigger('Justinius')
            player.events:expect({ eventId = 360 })

            player.entities:gotoAndTrigger('_0q1')
            player.events:expect({ eventId = 103 })

            -- check if mission completes
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)
        end)
    end)

    describe('2-3 Distant Beliefs', function()
        it('should defeat Minotour in Phomiuna Aqueducts', function()
            -- Sewer door needs this mission explicitly completed to trigger event
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
            player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LOST_CITY)
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS)

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('Justinius', { eventId = 123 })

            -- TODO: This trigger is not working. Supposed to warp to aqueducts
            -- player.entities:gotoAndTrigger('_0q1', { eventId = 502, finishOption = 1 })
            player:gotoZone(xi.zone.PHOMIUNA_AQUEDUCTS)

            xi.test.world:skipTime(900)
            xi.test.world:tick()
            player:claimAndKillMob('Minotaur')

            -- TODO: This is the right Wooden_Ladder to trigger but it's not working D:
            -- player.entities:gotoAndTrigger(16888103, { eventId = 35 })
            -- player.entities:gotoAndTrigger('_0r5', { eventId = 36 })

            -- force events
            player:startEvent(35)
            player.events:expect({ eventId = 35 })
            player:startEvent(36)
            player.events:expect({ eventId = 36 })

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('Justinius', { eventId = 113 })

            -- check if mission completes
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)
        end)
    end)

    describe('2-4 An Eternal Melody', function()
        it('should complete NPC interactions and obtain Mysterious Amulet', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.AN_ETERNAL_MELODY)

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)

            -- TODO: Unimplemented optional CS?
            -- player.entities:gotoAndTrigger('Calengeard', { eventId = 395 })
            -- player.entities:gotoAndTrigger('Reaugettie', { eventId = 292 })

            player.entities:gotoAndTrigger('Justinius', { eventId = 125 })
            player.entities:gotoAndTrigger('_0qa', { eventId = 104 })
            player.assert:hasKI(xi.ki.MYSTERIOUS_AMULET)

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p0', { eventId = 5 })

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD, { x = -5, y = -24, z = 18 })
            xi.test.world:skipTime(1)
            xi.test.world:tick()
            player.events:expect({ eventId = 105 })

            -- check if mission completes
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end)
    end)

    describe('2-5 Ancient Vows', function()
        it('should complete Monarch Linn BCNM and advance missions', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p2')
            player.events:expect({ eventId = 6 })

            player:gotoZone(xi.zone.RIVERNE_SITE_A01)
            player.events:expect({ eventId = 100 })

            player:gotoZone(xi.zone.MONARCH_LINN)
            player.bcnm:enter('SD_Entrance', xi.battlefield.id.ANCIENT_VOWS)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            player.assert:inZone(xi.zone.SOUTH_GUSTABERG)
            player.events:expect({ eventId = 906 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)
        end)
    end)

    describe('3-1 The Call of the Wyrmking', function()
        it('should complete cutscenes in Bastok and advance mission', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_CALL_OF_THE_WYRMKING)

            player:gotoZone(xi.zone.SOUTH_GUSTABERG)
            player.events:expect({ eventId = 906 })

            player:gotoZone(xi.zone.PORT_BASTOK, { x = -100, y = 0, z = -10 })
            player.events:expect({ eventId = 305 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 845 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
        end)
    end)

    describe('3-2 A Vessel Without a Captain', function()
        it('should complete story progression in Jeuno', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('_6tc', { eventId = 86 })

            player:gotoZone(xi.zone.RULUDE_GARDENS)
            -- Unimplemented optional CSs?
            -- player.entities:gotoAndTrigger('Auchefort', { eventId = 6 })
            -- player.entities:gotoAndTrigger('Pherimociel', { eventId = 26 })

            player:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            player.events:expect({ eventId = 65 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)
        end)
    end)

    describe('3-3 The Road Forks', function()
        it("should complete both San d'Oria and Windurst paths", function()
            local carpenterID = zones[xi.zone.CARPENTERS_LANDING]
            local chasmID = zones[xi.zone.ATTOHWA_CHASM]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS)

            -- 1st Path
            player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            player.events:expect({ event = 14 })
            player.entities:gotoAndTrigger('Arnau', { eventId = 51 })
            player.entities:gotoAndTrigger('Chasalvige', { eventId = 38 })

            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            player.entities:gotoAndTrigger('Guilloud')
            xi.test.world:tick()
            local ivy = player.entities:get(carpenterID.mob.OVERGROWN_IVY)
            ivy.assert:isSpawned()

            player:claimAndKillMob(ivy)
            xi.test.world:tick()

            player.entities:gotoAndTrigger('Guilloud', { event = 0 })

            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Hinaree', { event = 23 })
            player.entities:gotoAndTrigger('Hinaree', { event = 24 })

            -- 2nd Path
            player:gotoZone(xi.zone.WINDURST_WATERS)
            player.events:expect({ event = 871 })
            player.entities:gotoAndTrigger('Ohbiru-Dohbiru', { event = 872 })

            player:gotoZone(xi.zone.WINDURST_WALLS)
            player.entities:gotoAndTrigger('Yoran-Oran', { event = 469 })

            player:gotoZone(xi.zone.WINDURST_WATERS)
            player.entities:gotoAndTrigger('Kyume-Romeh', { event = 873 })
            player.entities:gotoAndTrigger('Honoi-Gomoi', { event = 874 })
            player.assert:hasKI(xi.ki.CRACKED_MIMEO_MIRROR)

            player:gotoZone(xi.zone.WINDURST_WALLS)
            player.entities:gotoAndTrigger('Yoran-Oran', { eventId = 470 })
            player.assert.no:hasKI(xi.ki.CRACKED_MIMEO_MIRROR)

            player:gotoZone(xi.zone.ATTOHWA_CHASM)
            player.entities:gotoAndTrigger('Loose_Sand')
            xi.test.world:tick()
            local mob2 = player.entities:get(chasmID.mob.LIOUMERE)
            mob2.assert:isSpawned()

            player:claimAndKillMob(mob2)
            xi.test.world:tick()

            player.entities:gotoAndTrigger('Loose_Sand')
            player.assert:hasKI(xi.ki.MIMEO_JEWEL)

            player.entities:gotoAndTrigger('Cradle_of_Rebirth', { event = 2 })
            player.assert.no:hasKI(xi.ki.MIMEO_JEWEL)
            player.assert:hasKI(xi.ki.MIMEO_FEATHER)
            player.assert:hasKI(xi.ki.SECOND_MIMEO_FEATHER)
            player.assert:hasKI(xi.ki.THIRD_MIMEO_FEATHER)

            player:gotoZone(xi.zone.WINDURST_WALLS)
            player.entities:gotoAndTrigger('Yoran-Oran', { event = 471 })
            player.assert.no:hasKI(xi.ki.MIMEO_FEATHER)
            player.assert.no:hasKI(xi.ki.SECOND_MIMEO_FEATHER)
            player.assert.no:hasKI(xi.ki.THIRD_MIMEO_FEATHER)

            player:gotoZone(xi.zone.PORT_WINDURST)
            player.entities:gotoAndTrigger('Yujuju', { event = 592 })

            player:gotoZone(xi.zone.WINDURST_WATERS)
            player.entities:gotoAndTrigger('Tosuka-Porika', { event = 875 })

            player:gotoZone(xi.zone.WINDURST_WALLS)
            player.entities:gotoAndTrigger('Yoran-Oran', { event = 472 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { event = 847 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)
        end)
    end)

    describe('3-4 Tending Aged Wounds', function()
        it('should complete story progression in Lower Jeuno', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.TENDING_AGED_WOUNDS)

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.events:expect({ event = 70 })

            player.entities:gotoAndTrigger('_6tc', { event = 22 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
        end)
    end)

    describe('3-5 Darkness Named', function()
        it('should complete Gray Chip quest and defeat Shrouded Maw BCNM', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Monberaux', { event = 82 })

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('Ghebi_Damomohe', { event = 54 })
            player.entities:gotoAndTrigger('Ghebi_Damomohe', { event = 53 })

            player:addItem(xi.item.GRAY_CHIP)
            player.actions:tradeNpc('Ghebi_Damomohe', { xi.item.GRAY_CHIP }, { eventId = 52 })
            player.assert:hasKI(xi.ki.PSOXJA_PASS)

            player:gotoZone(xi.zone.THE_SHROUDED_MAW)
            player.events:expect({ event = 2 })

            player.bcnm:enter('MC_Entrance', xi.battlefield.id.DARKNESS_NAMED)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Monberaux', { event = 75 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)
        end)
    end)

    describe('4-1 Sheltering Doubt', function()
        it('should complete story progression in Tavnazian Safehold', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.SHELTERING_DOUBT)

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            xi.test.world:tick()
            player.events:expect({ event = 107 })

            player.entities:gotoAndTrigger('Justinius')
            player.events:expect({ event = 129 })

            player.entities:gotoAndTrigger('Despachiaire')
            player.events:expect({ event = 108 })

            player.entities:gotoAndTrigger('Justinius')
            player.events:expect({ event = 109 })

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p0')
            player.events:expect({ event = 7 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
        end)
    end)

    describe('4-2 The Savage', function()
        it('should complete Monarch Linn BCNM for Savage battle', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p2', { eventId = 8, finishOption = 1 })

            player:gotoZone(xi.zone.RIVERNE_SITE_B01)

            player:gotoZone(xi.zone.MONARCH_LINN)
            player.bcnm:enter('SD_Entrance', xi.battlefield.id.SAVAGE)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('Justinius', { eventId = 110 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)
        end)
    end)

    describe('4-3 The Secrets of Worship', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.SACRARIUM]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SECRETS_OF_WORSHIP)

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('_0qa', { eventId = 111 })

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p8', { eventId = 9, finishOption = 1 })

            -- Player is now in Sacrarium
            player.assert:inZone(xi.zone.SACRARIUM)
            player.entities:gotoAndTrigger('_0s8', { eventId = 6 })

            local qm3 = player.entities:get('qm_prof_3')
            qm3:setLocalVar('hasProfessorMariselle', 1)
            player.entities:gotoAndTrigger('qm_prof_3')
            xi.test.world:tick()

            local professor = player.entities:get(ID.mob.OLD_PROFESSOR_MARISELLE)
            professor.assert:isSpawned()
            player:claimAndKillMob(professor)
            -- Shouldn't need to do these 3 but the test is flaky without them
            professor:despawn()
            xi.test.world:tick()
            qm3:setLocalVar('hasProfessorMariselle', 0)

            player.entities:gotoAndTrigger('qm_prof_3')
            player.assert:hasKI(xi.ki.RELIQUIARIUM_KEY)

            player.entities:gotoAndTrigger('_0s8', { eventId = 5 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)
        end)
    end)

    describe('4-4 Slanderous Utterings', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS)

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD, { x = 106, y = -40, z = -80 })
            xi.test.world:skipTime(1)
            xi.test.world:tick()
            player.events:expect({ eventId = 112 })

            player:gotoZone(xi.zone.SEALIONS_DEN)
            player.entities:gotoAndTrigger('_0w0', { eventId = 13 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)
        end)
    end)

    describe('5-1 The Enduring Tumult of War', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.PSOXJA]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ENDURING_TUMULT_OF_WAR)

            player:gotoZone(xi.zone.PORT_BASTOK)
            player.events:expect({ eventId = 306 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 849 })
            player.entities:gotoAndTrigger('Cid', { eventId = 863 })

            player:gotoZone(xi.zone.PSOXJA, { x = -300, y = 0, z = 0 })
            -- Note: gotoZone isn't well suited for CS that requires careful positioning on zone in yet.
            -- Force event
            player:startEvent(1)
            player.events:expect({ eventId = 1 })

            player.entities:gotoAndTrigger('_i98')
            local golem = player.entities:get(ID.mob.NUNYUNUWI)
            golem.assert:isSpawned()

            player:claimAndKillMob(golem)

            player.entities:gotoAndTrigger('_i99', { eventId = 2, finishOption = 1 })
            player.assert:inZone(xi.zone.PROMYVION_VAHZL)
            player.events:expect({ eventId = 50 })
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)
                :hasKI(xi.ki.LIGHT_OF_VAHZL)
        end)
    end)

    describe('5-2 Desires of Emptiness', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.PROMYVION_VAHZL]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS)

            player:gotoZone(xi.zone.PROMYVION_VAHZL)

            player.entities:gotoAndTrigger('_0mc')
            local propagator = player.entities:get(ID.mob.PROPAGATOR)
            propagator.assert:isSpawned()
            player:claimAndKillMob(propagator)
            player.entities:gotoAndTrigger('_0mc', { eventId = 51 })

            player.entities:gotoAndTrigger('_0md')
            local policitor = player.entities:get(ID.mob.SOLICITOR)
            policitor.assert:isSpawned()
            player:claimAndKillMob(policitor)
            player.entities:gotoAndTrigger('_0md', { eventId = 52 })

            player.entities:gotoAndTrigger('_0m0')
            local ponderer = player.entities:get(ID.mob.PONDERER)
            ponderer.assert:isSpawned()
            player:claimAndKillMob(ponderer)
            player.entities:gotoAndTrigger('_0m0', { eventId = 53 })

            player:gotoZone(xi.zone.SPIRE_OF_VAHZL)
            player.events:expect({ eventId = 20 })

            player.bcnm:enter('_0n0', xi.battlefield.id.DESIRES_OF_EMPTINESS)
            player.bcnm:killMobs()
            xi.test.world:skipTime(15)
            xi.test.world:tick()
            -- Player is sent to Beaucedine Glacier at end of event
            player.bcnm:expectWin({ finishOption = 2 })
            player.events:expect({ eventId = 206 })
            player.assert:inZone(xi.zone.BEAUCEDINE_GLACIER)

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 850 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)
        end)
    end)

    describe('5-3 Three Paths', function()
        it('should complete all three paths successfully', function()
            local upperID = zones[xi.zone.LOWER_DELKFUTTS_TOWER]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS)

            -- Louverance's Path
            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('Despachiaire', { eventId = 118 })

            player:gotoZone(xi.zone.WINDURST_WOODS)
            player.entities:gotoAndTrigger('Perih_Vashai', { eventId = 686 })

            player:gotoZone(xi.zone.BIBIKI_BAY)
            player.entities:gotoAndTrigger('Warmachine', { eventId = 33 })

            player:gotoZone(xi.zone.WINDURST_WALLS)
            player.entities:gotoAndTrigger('Yoran-Oran', { eventId = 481 })

            player:gotoZone(xi.zone.OLDTON_MOVALPOLOS)
            player.events:expect({ eventId = 1 })

            player:gotoZone(xi.zone.MINE_SHAFT_2716)
            player.bcnm:enter('_0d0', xi.battlefield.id.CENTURY_OF_HARDSHIP)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 852 })

            player:gotoZone(xi.zone.OLDTON_MOVALPOLOS)
            player.entities:gotoAndTrigger('Tarnotik', { eventId = 34 })

            player:addItem(xi.item.GOLD_KEY)
            player:gotoZone(xi.zone.MINE_SHAFT_2716)
            player.actions:tradeNpc('_0d0', { xi.item.GOLD_KEY }, { eventId = 3 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 853 })

            -- Tenzen's Path
            player:gotoZone(xi.zone.LA_THEINE_PLATEAU)
            player.entities:gotoAndTrigger('qm3', { eventId = 203 })

            player:gotoZone(xi.zone.PSOXJA)
            player.entities:gotoAndTrigger('_09g', { eventId = 3 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Monberaux', { eventId = 74 })

            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('Pherimociel', { eventId = 58 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Monberaux', { eventId = 6 })

            player:gotoZone(xi.zone.BATALLIA_DOWNS)
            player.entities:gotoAndTrigger('qm4', { eventId = 0 })
            player.entities:gotoAndTrigger('qm4', { eventId = 1 })
            player.assert:hasKI(xi.ki.DELKFUTT_RECOGNITION_DEVICE)

            player:gotoZone(xi.zone.LOWER_DELKFUTTS_TOWER)
            player.entities:gotoAndTrigger('_545')
            local idol = player.entities:get(upperID.mob.DISASTER_IDOL)
            idol.assert:isSpawned()
            player:claimAndKillMob(idol)
            xi.test.world:tick()
            player.entities:gotoAndTrigger('_545', { eventId = 25 })
            -- TODO: Are we supposed to lose the KI?
            -- player.assert.no:hasKI(xi.ki.DELKFUTT_RECOGNITION_DEVICE)

            player:gotoZone(xi.zone.PSOXJA)
            -- PsoXja CS conditions suck, force the event
            -- player:gotoZone(xi.zone.PSOXJA, { x = 220, y = -8, z = -282 })
            player:startEvent(4)
            player.events:expect({ eventId = 4 })

            player.entities:gotoAndTrigger('_09h', { eventId = 5 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 854 })

            -- Ulmia's Path
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Hinaree', { eventId = 22 })

            player:gotoZone(xi.zone.PORT_SAN_DORIA)
            player.events:expect({ eventId = 4 })

            player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Chasalvige', { eventId = 762 })

            player:gotoZone(xi.zone.WINDURST_WATERS)
            player.entities:gotoAndTrigger('Kerutoto', { eventId = 876 })

            player:gotoZone(xi.zone.WINDURST_WALLS)
            player.entities:gotoAndTrigger('Yoran-Oran', { eventId = 473 })

            player:gotoZone(xi.zone.BONEYARD_GULLY)
            player.bcnm:enter('_081', xi.battlefield.id.HEAD_WIND)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            -- TODO: BCNM not working?
            --             player:gotoZone(xi.zone.BEARCLAW_PINNACLE)
            --             player.bcnm:enter('Wind_Pillar_1', xi.battlefield.id.FLAMES_FOR_THE_DEAD)
            --             player.bcnm:killMobs()
            --             player.bcnm:expectWin({ finishOption = 2 })
            --
            --             player:gotoZone(xi.zone.METALWORKS)
            --             player.entities:gotoAndTrigger('Cid', { eventId = 855 })
            --
            --             player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        end)
    end)

    describe('6-1 For Whom the Verse is Sung', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)

            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('Pherimociel', { eventId = 10046 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('_6s1', { eventId = 10011 })

            player:gotoZone(xi.zone.RULUDE_GARDENS)
            xi.test.world:tick()
            player.events:expect({ eventId = 10047 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)
        end)
    end)

    describe('6-2 A Place to Return', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.MISAREAUX_COAST]
            local mob1 = player.entities:get(ID.mob.PM6_2_MOB_OFFSET)
            local mob2 = player.entities:get(ID.mob.PM6_2_MOB_OFFSET + 1)
            local mob3 = player.entities:get(ID.mob.PM6_2_MOB_OFFSET + 2)

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)

            player:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            player.events:expect({ eventId = 10048 })

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p0')
            mob1.assert:isSpawned()
            player:claimAndKillMob(mob1)
            mob2.assert:isSpawned()
            player:claimAndKillMob(mob2)
            mob3.assert:isSpawned()
            player:claimAndKillMob(mob3)
            xi.test.world:tick()

            player.entities:gotoAndTrigger('_0p0', { eventId = 10 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)
        end)
    end)

    describe('6-3 More Questions Than Answers', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)

            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('Pherimociel', { eventId = 10049 })

            player.entities:gotoAndTrigger('_6r9', { eventId = 10050 })

            player:gotoZone(xi.zone.SELBINA)
            player.entities:gotoAndTrigger('Mathilde', { eventId = 10005 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)
        end)
    end)

    describe('6-4 One to be Feared', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED)

            -- Optional CS?
            --             player:gotoZone(xi.zone.SELBINA)
            --             player.entities:gotoAndTrigger('Mathilde', { eventId = 173 })
            --             player.entities:gotoAndTrigger('Mathilde', { eventId = 174 })

            player:gotoZone(xi.zone.METALWORKS)
            player.entities:gotoAndTrigger('Cid', { eventId = 856 })

            player:gotoZone(xi.zone.SEALIONS_DEN)
            player.events:expect({ eventId = 15 })

            player.entities:gotoAndTrigger('_0w0', { eventId = 31 })

            -- Event progression not working
            --             player.bcnm:enter('_0w0', xi.battlefield.id.ONE_TO_BE_FEARED)
            --             player.entities:gotoAndTrigger('Airship_Door', { eventId = 32003, finishOption = 100 })
            --             player.events:expect({ eventId = 0 })
            --
            --             player.bcnm:killMobs()         -- Kill mammets
            --             player.events:expect({ eventId = 10 }) -- Move outside battlfield
            --
            --             -- Click door to enter next phase
            --             player.entities:gotoAndTrigger('Airship_Door', { eventId = 32003, finishOption = 100 })
            --             player.events:expect({ eventId = 1 })
            --             player.bcnm:killMobs()         -- Kill Omega
            --             player.events:expect({ eventId = 11 }) -- Move outside battlfield again
            --
            --             -- Click door to enter next phase
            --             player.entities:gotoAndTrigger('Airship_Door', { eventId = 32003, finishOption = 100 })
            --             player.events:expect({ eventId = 2 })
            --
            --             player.bcnm:killMobs() -- Kill Ultima
            --             player.bcnm:expectWin({ finishOption = 2 })
            --
            --             player.events:expect({ eventId = 33 })
            --
            --             player:getZoneID() == xi.zone.LUFAISE_MEADOWS)
            --             player.events:expect({ eventId = 111 })
            --
            --             player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)
        end)
    end)

    describe('7-1 Chains and Bonds', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CHAINS_AND_BONDS)

            player:gotoZone(xi.zone.LUFAISE_MEADOWS)
            xi.test.world:tick()
            player.events:expect({ eventId = 111 })

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            xi.test.world:tick()
            xi.test.world:skipTime(2)
            player.events:expect({ eventId = 114 })
            player.entities:gotoAndTrigger('_0q1', { eventId = 116 })

            player:gotoZone(xi.zone.SEALIONS_DEN)
            xi.test.world:tick()
            player.events:expect({ eventId = 14 })

            player:gotoZone(xi.zone.TAVNAZIAN_SAFEHOLD)
            player.entities:gotoAndTrigger('_0qa', { eventId = 115 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)
        end)
    end)

    describe('7-2 Flames in the Darkness', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FLAMES_IN_THE_DARKNESS)

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p2', { eventId = 12 })

            player:gotoZone(xi.zone.SEALIONS_DEN)
            player.entities:gotoAndTrigger('Sueleen', { eventId = 16 })

            player:gotoZone(xi.zone.RULUDE_GARDENS, { x = 0, y = 3, z = 45 })
            player.events:expect({ eventId = 10051 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('_6s1', { eventId = 10012 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)
        end)
    end)

    describe('7-3 Fire in the Eyes of Men', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.FIRE_IN_THE_EYES_OF_MEN)

            player:gotoZone(xi.zone.MINE_SHAFT_2716)
            player.entities:gotoAndTrigger('_0d0', { eventId = 4 })

            player:gotoZone(xi.zone.METALWORKS)

            -- First CS that sets the timer for the next event
            player.entities:gotoAndTrigger('Cid', { eventId = 857 })

            -- Cid telling us to come back later
            player.entities:gotoAndTrigger('Cid', { eventId = 858 })

            -- Skip to next vanadiel day and progress the mission
            xi.test.world:skipToNextVanaDay()
            player.entities:gotoAndTrigger('Cid', { eventId = 890 })
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)
        end)
    end)

    describe('7-4 Calm Before the Storm', function()
        it('should complete the mission successfully', function()
            local boggelmann = player.entities:get(zones[xi.zone.MISAREAUX_COAST].mob.BOGGELMANN)
            local crypton    = player.entities:get(zones[xi.zone.CARPENTERS_LANDING].mob.CRYPTONBERRY_EXECUTOR)

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.CALM_BEFORE_THE_STORM)

            player:gotoZone(xi.zone.MISAREAUX_COAST)
            player.entities:gotoAndTrigger('_0p4')
            boggelmann.assert:isSpawned()
            player:claimAndKillMob(boggelmann)
            player.entities:gotoAndTrigger('_0p4', { eventId = 13 })
            player.assert:hasKI(xi.ki.VESSEL_OF_LIGHT)

            player:gotoZone(xi.zone.CARPENTERS_LANDING)
            player.entities:gotoAndTrigger('qm_cryptonberries')
            crypton.assert:isSpawned()
            player:claimAndKillMob(crypton)
            player:setLocalVar(
                string.format('Mission[%d][%d]carpentersNm', xi.mission.log_id.COP,
                    xi.mission.id.cop.CALM_BEFORE_THE_STORM),
                15)
            player.entities:gotoAndTrigger('qm_cryptonberries', { eventId = 37 })

            player:gotoZone(xi.zone.BIBIKI_BAY)
            local dalham = player.entities:get('Dalham')
            player.entities:gotoAndTrigger('qm_dalham')
            dalham.assert:isSpawned()
            player:claimAndKillMob(dalham)
            player.entities:gotoAndTrigger('qm_dalham', { eventId = 41 })

            player:gotoZone(xi.zone.METALWORKS)
            --             player.entities:gotoAndTrigger('Cid', { eventId = 891 })
            player.entities:gotoAndTrigger('Cid', { eventId = 892 })
            player.assert:hasKI(xi.ki.LETTERS_FROM_ULMIA_AND_PRISHE)

            player:gotoZone(xi.zone.SEALIONS_DEN)
            player.entities:gotoAndTrigger('Sueleen', { eventId = 17 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)
        end)
    end)

    describe('7-5 The Warriors Path', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)

            player:gotoZone(xi.zone.SEALIONS_DEN)
            player.entities:gotoAndTrigger('_0w0', { eventId = 32 })

            player.bcnm:enter('_0w0', xi.battlefield.id.WARRIORS_PATH)
            -- TODO: Tenzen can't be killed and causes this call to fail
            --             player.bcnm:killMobs()
            --             player.bcnm:expectWin({ finishOption = 2 })
            --             player.events:expect({ eventId = 1 })
            --
            --             player.assert:inZone(xi.zone.ALTAIEU)
            --             player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)
        end)
    end)

    describe('8-1 Garden of Antiquity', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.GARDEN_OF_ANTIQUITY)

            player:gotoZone(xi.zone.ALTAIEU)
            player.entities:gotoAndTrigger('_0x0', { eventId = 164 })

            local southMob1 = player.entities:get(16912829)
            local southMob2 = player.entities:get(16912829 + 1)
            local southMob3 = player.entities:get(16912829 + 2)
            player.entities:gotoAndTrigger('_0x1')
            southMob1.assert:isSpawned()
            southMob2.assert:isSpawned()
            southMob3.assert:isSpawned()
            player:claimAndKillMob(southMob1)
            player:claimAndKillMob(southMob2)
            player:claimAndKillMob(southMob3)
            player.entities:gotoAndTrigger('_0x1', { eventId = 161 })

            local westMob1 = player.entities:get(16912832)
            local westMob2 = player.entities:get(16912832 + 1)
            local westMob3 = player.entities:get(16912832 + 2)
            player.entities:gotoAndTrigger('_0x2')
            westMob1.assert:isSpawned()
            westMob2.assert:isSpawned()
            westMob3.assert:isSpawned()
            player:claimAndKillMob(westMob1)
            player:claimAndKillMob(westMob2)
            player:claimAndKillMob(westMob3)
            player.entities:gotoAndTrigger('_0x2', { eventId = 162 })

            local eastMob1 = player.entities:get(16912835)
            local eastMob2 = player.entities:get(16912835 + 1)
            local eastMob3 = player.entities:get(16912835 + 2)
            player.entities:gotoAndTrigger('_0x3')
            eastMob1.assert:isSpawned()
            eastMob2.assert:isSpawned()
            eastMob3.assert:isSpawned()
            player:claimAndKillMob(eastMob1)
            player:claimAndKillMob(eastMob2)
            player:claimAndKillMob(eastMob3)
            player.entities:gotoAndTrigger('_0x3', { eventId = 163 })

            player.entities:gotoAndTrigger('_0x0', { eventId = 100 })

            player:gotoZone(xi.zone.GRAND_PALACE_OF_HUXZOI)
            xi.test.world:tick()
            player.entities:gotoAndTrigger('_iya', { eventId = 1 })
            player.entities:gotoAndTrigger('_iyb', { eventId = 2 })
            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)
        end)
    end)

    describe('8-2 A Fate Decided', function()
        it('should complete the mission successfully', function()
            local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]

            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_FATE_DECIDED)

            player:gotoZone(xi.zone.GRAND_PALACE_OF_HUXZOI)
            player.entities:gotoAndTrigger('_iyq')
            local mob = player.entities:get(ID.mob.IXGHRAH)
            mob.assert:isSpawned()
            player:claimAndKillMob(mob)
            player.entities:gotoAndTrigger('_iyq', { eventId = 3 })

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
        end)
    end)

    describe('8-3 When Angels Fall', function()
        it('should complete the mission successfully', function()
            -- setup mission
            player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL)
            player:addKeyItem(xi.ki.BRAND_OF_DAWN)
            player:addKeyItem(xi.ki.BRAND_OF_TWILIGHT)

            player:gotoZone(xi.zone.THE_GARDEN_OF_RUHMET)
            xi.test.world:tick()
            player.events:expect({ eventId = 201 })
            player.assert:hasKI(xi.ki.MYSTERIOUS_AMULET_PRISHE)

            -- Hume Ebon Panel
            player.entities:gotoAndTrigger('_iz2', { eventId = 202 })

            -- Eden was missing this event
            player.entities:gotoAndTrigger('_iz2', { eventId = 120, finishOption = 1 })
            player.assert:hasKI(xi.ki.LIGHT_OF_VAHZL)

            player.entities:gotoAndTrigger('_0z0', { eventId = 203 })

            player.bcnm:enter('_0z0', xi.battlefield.id.WHEN_ANGELS_FALL)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })

            player.entities:gotoAndTrigger('_0zt', { eventId = 204 })

            -- Begin: Eden was missing this section
            player:gotoZone(xi.zone.ALTAIEU)
            player.events:expect({ eventId = 165 })
            player.assert.no:hasKI(xi.ki.MYSTERIOUS_AMULET_PRISHE)
            -- End: Eden was missing this section

            player.assert:hasMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
        end)
    end)
end)
