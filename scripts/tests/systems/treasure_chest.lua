describe('Treasure', function()
    it('opens chest with key and consumes the key', function()
        ---@type CClientEntityPair
        local player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.ORDELLES_CAVES,
            })
        player:addKeyItem(xi.ki.MAP_OF_ORDELLES_CAVES)

        -- Skip time to let the chest's 'opened' var reset (queued at 5s)
        xi.test.world:skipTime(6)

        -- Give the player a chest key
        player:addItem(xi.item.ORDELLE_CHEST_KEY)
        player.assert:hasItem(xi.item.ORDELLE_CHEST_KEY)

        -- Trade the key to the Treasure Chest
        player.actions:tradeNpc('Treasure_Chest',
            {
                {
                    itemId = xi.item.ORDELLE_CHEST_KEY,
                    quantity = 1,
                },
            })

        -- Assert the key was consumed
        player.assert.no:hasItem(xi.item.ORDELLE_CHEST_KEY)
    end)
end)
