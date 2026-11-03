describe('Ability recast persistence across zoning', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                job   = xi.job.WAR,
                level = 75,
                zone  = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('keeps a recast longer than 32767 seconds', function()
        player:addRecast(xi.recast.ABILITY, xi.recastID.SPECIAL, 40000)
        player:gotoZone(xi.zone.EAST_RONFAURE)

        -- A recast clamped to 32767 seconds would have run out by now.
        xi.test.world:skipTime(33000)

        assert(player:hasRecast(xi.recast.ABILITY, xi.recastID.SPECIAL), 'the recast should survive zoning')
    end)
end)
