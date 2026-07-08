describe('Interaction Framework', function()
    it('completes Shady Business quest with zinc ore trade', function()
        ---@type CClientEntityPair
        local player = xi.test.world:spawnPlayer()

        -- Set prerequisite: Beauty and the Galka quest must be completed
        player:addQuest(xi.questLog.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
        player:completeQuest(xi.questLog.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)

        -- Go to Port Bastok and talk to Talib
        player:gotoZone(xi.zone.PORT_BASTOK)
        player.entities:gotoAndTrigger('Talib', { eventId = 90 })

        -- Verify quest was started
        player.assert:hasQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)

        -- Add 4 chunks of zinc ore to inventory
        player:addItem(xi.item.CHUNK_OF_ZINC_ORE, 4)

        -- Trade the zinc ore to complete the quest
        player.actions:tradeNpc('Talib',
            {
                {
                    itemId = xi.item.CHUNK_OF_ZINC_ORE,
                    quantity = 4,
                }
            },
            { eventId = 91 })

        -- Verify quest completion and rewards
        player.assert
            :hasCompletedQuest(xi.questLog.BASTOK, xi.quest.id.bastok.SHADY_BUSINESS)
            :hasGil(350) -- Quest reward is 350 gil

        -- Verify the zinc ore was consumed
        player.assert.no:hasItem(xi.item.CHUNK_OF_ZINC_ORE)
    end)
end)
