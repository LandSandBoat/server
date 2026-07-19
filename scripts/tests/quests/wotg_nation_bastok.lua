describe('WOTG Nation Quests - Bastok', function()
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

    describe('00 - The Fighting Fourth', function()
        it('should complete the quest and align the player with Bastok', function()
            -- Obtain the blue recommendation letter from Turbulent Storm in The Eldieme Necropolis (S).
            player:gotoZone(xi.zone.THE_ELDIEME_NECROPOLIS_S)
            player.entities:gotoAndTrigger('Turbulent_Storm', { eventId = 7, finishOption = 0 })
            player.assert:hasKI(xi.ki.BLUE_RECOMMENDATION_LETTER)

            -- Enlist with Adelbrecht in Bastok Markets (S); the letter is exchanged for battle rations.
            player:gotoZone(xi.zone.BASTOK_MARKETS_S)
            player.entities:gotoAndTrigger('Adelbrecht', { eventId = 139, finishOption = 1 })
            player.assert
                :hasQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)
                :hasKI(xi.ki.BATTLE_RATIONS)
            player.assert.no:hasKI(xi.ki.BLUE_RECOMMENDATION_LETTER)

            -- Deliver the rations along the watchtowers in North Gustaberg (S).
            player:gotoZone(xi.zone.NORTH_GUSTABERG_S)
            player.entities:gotoAndTrigger('Gebhardt', { eventId = 102 })
            player.assert.no:hasKI(xi.ki.BATTLE_RATIONS)
            player.entities:gotoAndTrigger('Roderich', { eventId = 104 })
            player.entities:gotoAndTrigger('Barricade', { eventId = 106 })

            -- Report back to Adelbrecht to complete the quest.
            player:gotoZone(xi.zone.BASTOK_MARKETS_S)
            player.entities:gotoAndTrigger('Adelbrecht', { eventId = 143 })
            player.assert:hasCompletedQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH)

            -- First nation quest completed: Sprinter's Shoes, service ribbon, and Bastok allegiance.
            player.assert:hasItem(xi.item.SPRINTERS_SHOES)
            player.assert:hasKI(xi.ki.BRONZE_RIBBON_OF_SERVICE)
        end)
    end)
end)
