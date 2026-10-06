describe('Stable chocobo patrols', function()
    -- Walking can carry a chocobo a hair past its point.
    local margin = 0.2

    local walkers =
    {
        { zone = xi.zone.SOUTHERN_SAN_DORIA, id = 17719338, minX = 11.3, maxX = 18.6, minZ = -92.5, maxZ = -87.6 },
        { zone = xi.zone.SOUTHERN_SAN_DORIA, id = 17719339, minX = 24.2, maxX = 27.6, minZ = -92.4, maxZ = -90.0 },
        { zone = xi.zone.SOUTHERN_SAN_DORIA, id = 17719340, minX = 13.3, maxX = 19.9, minZ = -100.4, maxZ = -96.7 },
        { zone = xi.zone.WINDURST_WOODS,     id = 17764417, minX = 121.0, maxX = 128.3, minZ = -111.2, maxZ = -102.2 },
    }

    it('turns to heading 0 when it picks the point it stands on', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        stub('math.randomInt', 1)

        -- Wherever it starts, it walks to its first point and then keeps picking it.
        local npc    = player.entities:get(17719338)
        local turned = false
        for _ = 1, 60 do
            xi.test.world:skipTime(1)

            local pos = npc:getPos()
            if
                math.abs(pos.x - 11.348) < 0.01 and
                math.abs(pos.z - -87.631) < 0.01 and
                npc:getRotPos() == 0
            then
                turned = true
                break
            end
        end

        assert(turned, string.format('Expected heading 0 at the first point, got %d', npc:getRotPos()))
    end)

    for _, walker in ipairs(walkers) do
        it(string.format('walks between its points (%d)', walker.id), function()
            local player = xi.test.world:spawnPlayer({ zone = walker.zone })

            local npc   = player.entities:get(walker.id)
            local start = npc:getPos()
            local moved = false

            for _ = 1, 120 do
                xi.test.world:skipTime(1)

                local pos = npc:getPos()
                moved     = moved or pos.x ~= start.x or pos.z ~= start.z

                assert(pos.x >= walker.minX - margin and pos.x <= walker.maxX + margin, string.format('x %.3f left the pen', pos.x))
                assert(pos.z >= walker.minZ - margin and pos.z <= walker.maxZ + margin, string.format('z %.3f left the pen', pos.z))
            end

            assert(moved, 'Expected the chocobo to walk')
        end)
    end
end)
