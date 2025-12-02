describe('Time Travel', function()
    ---@type CClientEntityPair
    local player

    setup(function()
        -- Process all pending tasks before manipulating time
        xi.test.world:tick()
    end)

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
    end)

    it('can skip to next time server tick', function()
        xi.test.world:tick(xi.tick.TIME)
    end)

    it('can skip to next status effect tick', function()
        player:changeJob(xi.job.BLM)
        player:setLevel(99)
        player:setMP(0)
        player:setMod(xi.mod.REFRESH, 10)
        for i = 1, 10 do
            xi.test.world:tick(xi.tick.EFFECT)
            assert(player:getMP() == i * 10)
        end
    end)

    it('can skip to next trigger area tick', function()
        -- Head to Windurst Walls and move to Heaven's Tower area
        player:gotoZone(xi.zone.WINDURST_WALLS)
        assert(not player:isPlayerInTriggerArea(1))
        player:setPos({ x = 0, y = -16.5, z = 141, rot = 0 })
        xi.test.world:tick(xi.tick.TRIGGER_AREAS)

        -- Now the player should have the trigger area in their list
        -- and receive the zoning event
        assert(player:isPlayerInTriggerArea(1))
        player.events:expect({ eventId = 86, finishOption = 0 })
    end)

    it('can skip to next JST hourly tick', function()
        -- Note: GetSystemTime is not JST but that doesn't matter for this test
        local startTime = GetSystemTime()
        -- TODO: Can check if influence messages are received
        -- For now, we can just check that we landed on a :00 boundary
        xi.test.world:tick(xi.tick.JST_HOUR)
        local endTime = GetSystemTime()
        assert(startTime ~= endTime, 'Time did not advance')

        local date = os.date('*t', endTime)
        assert(date.min == 0, string.format('Expected minute 0, got %d', date.min))
        assert(date.sec == 0, string.format('Expected seconds 0, got %d', date.sec))
    end)

    it('can skip to next JST daily tick', function()
        xi.test.world:tick(xi.tick.JST_DAY)

        local jstHour = JstHour()
        local endTime = GetSystemTime()
        local date    = os.date('*t', endTime)

        assert(jstHour == 0, string.format('Expected JST hour 0 (midnight), got %d', jstHour))
        assert(date.min == 0, string.format('Expected minute 0, got %d', date.min))
        assert(date.sec == 0, string.format('Expected seconds 0, got %d', date.sec))
    end)

    it('can skip to next Vanadiel hourly tick', function()
        local startHour = VanadielHour()
        xi.test.world:tick(xi.tick.VANA_HOUR)
        local endHour    = VanadielHour()
        local vanaMinute = VanadielMinute()

        assert(startHour ~= endHour, string.format('Vanadiel hour did not change (still %d)', startHour))
        assert(vanaMinute == 0, string.format('Expected Vanadiel minute 0, got %d', vanaMinute))
    end)

    it('can skip to next Vanadiel daily tick', function()
        xi.test.world:tick(xi.tick.VANA_DAY)

        -- Should be at the start of a Vanadiel day (hour 0)
        local vanaHour = VanadielHour()
        assert(vanaHour == 0, string.format('Expected Vanadiel hour 0, got %d', vanaHour))

        -- Minute should also be 0
        local vanaMinute = VanadielMinute()
        assert(vanaMinute == 0, string.format('Expected Vanadiel minute 0, got %d', vanaMinute))
    end)
end)
