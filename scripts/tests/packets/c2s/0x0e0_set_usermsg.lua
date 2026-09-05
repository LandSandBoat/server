describe('Search message', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('stores a message that fits the search comment field', function()
        local message = string.rep('a', 123)

        player.actions:setSearchMessage(message)

        assert(player:getSearchMessage() == message, 'message was not stored')
    end)

    it('rejects a message longer than the search comment field', function()
        player.actions:setSearchMessage('short')
        player.actions:setSearchMessage(string.rep('a', 124))

        assert(player:getSearchMessage() == 'short', 'oversized message was stored')
    end)
end)
