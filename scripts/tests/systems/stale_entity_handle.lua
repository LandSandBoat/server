describe('Stale entity handle', function()
    ---@type CClientEntityPair
    local player

    local function staleHandle()
        local handle = GetPlayerByID(player:getID())
        assert(handle ~= nil, 'expected a handle to the player')
        assert(handle:getID() == player:getID(), 'handle should work while the player is alive')

        player:gotoZone(xi.zone.EAST_RONFAURE)

        return handle
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    it('raises when a stale handle is the receiver', function()
        local handle = staleHandle()

        local ok, err = pcall(function()
            return handle:getID()
        end)

        assert(not ok, 'expected the stale handle to raise')
        assert(tostring(err):find('getID'), 'error should name the binding, got: ' .. tostring(err))
        assert(tostring(err):find('is gone'), 'error should say the entity is gone, got: ' .. tostring(err))
    end)

    it('raises when a stale handle is an argument', function()
        local handle = staleHandle()

        local ok, err = pcall(function()
            player:facePlayer(handle)
        end)

        assert(not ok, 'expected the stale argument to raise')
        assert(tostring(err):find('facePlayer'), 'error should name the binding, got: ' .. tostring(err))
        assert(tostring(err):find('is gone'), 'error should say the entity is gone, got: ' .. tostring(err))
    end)
end)
