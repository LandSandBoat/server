describe('WOTG Nation Quests - Windurst', function()
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

    describe('00 - Snake on the Plains', function()
        it('should complete the quest and align the player with Windurst', function()
            -- The green recommendation letter is granted outside this quest; seed it directly.
            player:addKeyItem(xi.ki.GREEN_RECOMMENDATION_LETTER)

            -- Start the quest with Miah Riyuh in Windurst Waters (S); the letter is exchanged for putty.
            player:gotoZone(xi.zone.WINDURST_WATERS_S)
            player.entities:gotoAndTrigger('Miah_Riyuh', { eventId = 103, finishOption = 0 })
            player.assert
                :hasQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)
                :hasKI(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)
            player.assert.no:hasKI(xi.ki.GREEN_RECOMMENDATION_LETTER)

            -- Patch the three sealed entrances in West Sarutabaruta (S). These return a
            -- message action (not an event), so trigger them without an expected event.
            player:gotoZone(xi.zone.WEST_SARUTABARUTA_S)
            player.entities:gotoAndTrigger('Sealed_Entrance_1')
            player.entities:gotoAndTrigger('Sealed_Entrance_2')
            player.entities:gotoAndTrigger('Sealed_Entrance_3')

            -- All three sealed: the putty is consumed.
            player.assert.no:hasKI(xi.ki.ZONPA_ZIPPAS_ALL_PURPOSE_PUTTY)

            -- Return to Miah Riyuh to complete the quest.
            player:gotoZone(xi.zone.WINDURST_WATERS_S)
            player.entities:gotoAndTrigger('Miah_Riyuh', { eventId = 106, finishOption = 0 })
            player.assert:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SNAKE_ON_THE_PLAINS)

            -- First nation quest completed: Sprinter's Shoes and the service ribbon.
            player.assert:hasItem(xi.item.SPRINTERS_SHOES)
            player.assert:hasKI(xi.ki.BRONZE_RIBBON_OF_SERVICE)
        end)
    end)
end)
