describe('Trade to NPC', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.LA_THEINE_PLATEAU })
        player:addItem(xi.item.FIRE_CRYSTAL)
    end)

    it('reaches a shown NPC', function()
        player.actions:tradeNpc('Telepoint', { xi.item.FIRE_CRYSTAL })

        player.assert:hasItem(xi.item.FADED_CRYSTAL)
    end)

    it('ignores a hidden NPC', function()
        local telepoint = player.entities:moveTo('Telepoint')
        telepoint:setStatus(xi.status.DISAPPEAR)

        player.actions:tradeNpc('Telepoint', { xi.item.FIRE_CRYSTAL })
        telepoint:setStatus(xi.status.NORMAL)

        assert(not player:hasItem(xi.item.FADED_CRYSTAL), 'The hidden Telepoint took the trade')
    end)
end)
