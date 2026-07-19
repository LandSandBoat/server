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
end)
