describe('Uragnite shell', function()
    local player
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.CEIZAK_BATTLEGROUNDS })
        mob    = player.entities:get('Bight_Uragnite')
        mob:respawn()
        mob:clearPath()
    end)

    it('spawns open', function()
        assert(mob:getAnimationSub() == 4, 'expected animationSub 4, got ' .. mob:getAnimationSub())
    end)

    it('closes during a rest and reopens', function()
        local closedAt = nil
        local openedAt = nil
        for second = 1, 300 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)
            local sub = mob:getAnimationSub()
            if sub == 5 and not closedAt then
                closedAt = second
            elseif sub == 4 and closedAt and not openedAt then
                openedAt = second
                break
            end
        end

        assert(closedAt, 'the shell never closed')
        assert(openedAt, 'the shell never opened again')
        local closed = openedAt - closedAt
        assert(closed >= 15 and closed <= 35, 'shell was closed for ' .. closed .. ' s')
    end)
end)
