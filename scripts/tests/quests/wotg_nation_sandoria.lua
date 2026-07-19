describe('WOTG Nation Quests - San d\'Oria', function()
    ---@type CClientEntityPair
    local player

    --
    -- Setup
    --

    before_each(function()
        player = xi.test.world:spawnPlayer()
        player:setLevel(99)

        -- Avoid cross-expansion zone-in cutscene conflicts (see tests/missions/wotg.lua).
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
    end)

    --
    -- Quests
    --

    describe('00 - Steamed Rams', function()
        it('should complete the quest and align the player with San d\'Oria', function()
            -- Obtain the red recommendation letter from Randecque in Garlaige Citadel (S).
            player:gotoZone(xi.zone.GARLAIGE_CITADEL_S)
            player.entities:gotoAndTrigger('Randecque', { eventId = 1, finishOption = 0 })
            player.assert:hasKI(xi.ki.RED_RECOMMENDATION_LETTER)

            -- Start the quest with Mainchelite in Southern San d'Oria (S).
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA_S)
            player.entities:gotoAndTrigger('Mainchelite', { eventId = 7, finishOption = 0 })
            player.assert:hasQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS)
            player.assert.no:hasKI(xi.ki.RED_RECOMMENDATION_LETTER)

            -- Collect the three pieces of evidence from the ??? in East Ronfaure (S).
            player:gotoZone(xi.zone.EAST_RONFAURE_S)
            player.entities:gotoAndTrigger('qm3', { eventId = 1 })
            player.assert:hasKI(xi.ki.CHARRED_PROPELLER)
            player.entities:gotoAndTrigger('qm4', { eventId = 2 })
            player.assert:hasKI(xi.ki.PIECE_OF_SHATTERED_LUMBER)
            player.entities:gotoAndTrigger('qm5', { eventId = 3 })
            player.assert:hasKI(xi.ki.OXIDIZED_PLATE)

            -- Return to Mainchelite to complete the quest.
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA_S)
            player.entities:gotoAndTrigger('Mainchelite', { eventId = 12 })
            player.assert:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS)

            -- The evidence key items are consumed on completion.
            player.assert.no:hasKI(xi.ki.CHARRED_PROPELLER)
            player.assert.no:hasKI(xi.ki.PIECE_OF_SHATTERED_LUMBER)
            player.assert.no:hasKI(xi.ki.OXIDIZED_PLATE)

            -- First nation quest completed: Sprinter's Shoes and the service ribbon.
            player.assert:hasItem(xi.item.SPRINTERS_SHOES)
            player.assert:hasKI(xi.ki.BRONZE_RIBBON_OF_SERVICE)
        end)
    end)

    describe('01 - Gifts of the Griffon', function()
        it('should accept, distribute the seven plumes, and complete for the Deathstone', function()
            -- Prereq: the section-1 check requires a completed first nation quest.
            player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS)

            -- Opening cutscene with Louxiard (Prog 0 -> 1, sets mustZone).
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA_S)
            player.entities:gotoAndTrigger('Louxiard', { eventId = 21, finishOption = 0 })
            player.assert.no:hasQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)

            -- Zone out to a different zone then back to clear mustZone, then the return cutscene (Prog 1 -> 2).
            player:gotoZone(xi.zone.EAST_RONFAURE_S)
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA_S)
            player.entities:gotoAndTrigger('Louxiard', { eventId = 22, finishOption = 0 })

            -- Rholont accepts the quest and hands over seven Plumes d'Or.
            player.entities:gotoAndTrigger('Rholont', { eventId = 23, finishOption = 0 })
            player.assert:hasQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)
            player.assert:hasItem(xi.item.PLUME_DOR)

            -- Distribute one Plume d'Or to each of the seven elders (per-NPC trade events 25-31).
            player.actions:tradeNpc('Machionage',           { xi.item.PLUME_DOR }, { eventId = 28 })
            player.actions:tradeNpc('Louxiard',             { xi.item.PLUME_DOR }, { eventId = 26 })
            player.actions:tradeNpc('Illeuse',              { xi.item.PLUME_DOR }, { eventId = 31 })
            player.actions:tradeNpc('Rongelouts_N_Distaud', { xi.item.PLUME_DOR }, { eventId = 25 })
            player.actions:tradeNpc('Sabiliont',            { xi.item.PLUME_DOR }, { eventId = 27 })
            player.actions:tradeNpc('Elnonde',              { xi.item.PLUME_DOR }, { eventId = 30 })
            player.actions:tradeNpc('Loillie',              { xi.item.PLUME_DOR }, { eventId = 29 })

            -- All seven plumes handed out.
            player.assert.no:hasItem(xi.item.PLUME_DOR)

            -- Return to Rholont to complete the quest (all 7 bits set -> event 24).
            player.entities:gotoAndTrigger('Rholont', { eventId = 24, finishOption = 0 })
            player.assert:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)
            player.assert:hasItem(xi.item.DEATHSTONE)
        end)
    end)

    describe('02 - Claws of the Griffon', function()
        it('should accept, drive the full quest, and reward the Angelstone', function()
            -- Prereqs (from the impl's check): San d'Oria alignment + Gifts of the Griffon done.
            -- Timer var defaults to 0 <= VanadielUniqueDay(), so the one-day wait is already satisfied.
            player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.STEAMED_RAMS)
            player:completeQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.GIFTS_OF_THE_GRIFFON)

            -- Accept the quest from Rholont in Southern San d'Oria (S) (sets mustZone).
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA_S)
            player.entities:gotoAndTrigger('Rholont', { eventId = 47, finishOption = 0 })
            player.assert:hasQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON)

            -- Talking again before zoning gives the pre-zone-out flavor dialogue (Option 0 -> event 50).
            player.entities:gotoAndTrigger('Rholont', { eventId = 50 })

            -- Zone out (clears mustZone) and return to Rholont for the follow-up cutscene (Prog -> 1).
            player:gotoZone(xi.zone.EAST_RONFAURE_S)
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA_S)
            player.entities:gotoAndTrigger('Rholont', { eventId = 48 })

            -- Travel to Jugner Forest (S) via East Ronfaure (S) to trigger the onZoneIn cutscene (Prog -> 2).
            player:gotoZone(xi.zone.EAST_RONFAURE_S)
            player:gotoZone(xi.zone.JUGNER_FOREST_S)
            player.events:expect({ eventId = 200 })

            -- Check the ??? (qm6) for the pre-fight cutscene (Prog -> 3).
            player.entities:gotoAndTrigger('qm6', { eventId = 201 })

            -- Check the ??? again to spawn and claim Fingerfilcher Dradzad (Prog stays 3).
            player.entities:gotoAndTrigger('qm6', { eventId = 202 })

            -- Defeat Fingerfilcher Dradzad. Open-world mob combat isn't driveable through the
            -- test harness (only BCNM mobs expose killMobs), so simulate the onMobDeath outcome
            -- that advances Prog 3 -> 4.
            player:setVar(xi.quest.getVarPrefix(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) .. 'Prog', 4)

            -- Check the ??? a final time to complete the quest and receive the reward.
            player.entities:gotoAndTrigger('qm6', { eventId = 203 })
            player.assert:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON)
            player.assert:hasItem(xi.item.ANGELSTONE)
        end)
    end)
end)
