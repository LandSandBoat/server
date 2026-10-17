describe('Harvest Festival item latents', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.WEST_RONFAURE })
    end)

    local function setMoonDay(day, fullMoon)
        xi.test.world:setVanaDay(day)

        -- The moon and weekday repeat together every 168 Vana'diel days.
        for _ = 1, 21 do
            local moonPhase = VanadielMoonPhase()
            if
                (fullMoon and moonPhase >= 95) or
                (not fullMoon and moonPhase <= 5)
            then
                return
            end

            xi.test.world:skipVanaDays(8)
        end

        error('Could not find the requested moon and weekday')
    end

    it('refreshes Horror Head at dawn, dusk, midnight, and equipment changes', function()
        setMoonDay(xi.day.DARKSDAY, true)
        xi.test.world:setVanaTime(5, 58)
        xi.test.world:tick(xi.tick.TIME)
        player:addItem(xi.item.HORROR_HEAD)
        player:equipItem(xi.item.HORROR_HEAD)
        assert(player:getMod(xi.mod.ENMITY) == -50)

        xi.test.world:tick(xi.tick.VANA_HOUR)
        assert(player:getMod(xi.mod.ENMITY) == 0, 'Horror Head stayed active after dawn')

        xi.test.world:setVanaTime(17, 58)
        xi.test.world:tick(xi.tick.TIME)
        xi.test.world:tick(xi.tick.VANA_HOUR)
        assert(player:getMod(xi.mod.ENMITY) == -50, 'Horror Head did not activate at dusk')

        player:unequipItem(xi.slot.HEAD)
        assert(player:getMod(xi.mod.ENMITY) == 0)
        player:equipItem(xi.item.HORROR_HEAD)
        assert(player:getMod(xi.mod.ENMITY) == -50)

        xi.test.world:tick(xi.tick.VANA_DAY)
        assert(player:getMod(xi.mod.ENMITY) == 0, 'Horror Head stayed active after Darksday')
    end)

    it('refreshes Horror Head II at dawn, dusk, and equipment changes', function()
        setMoonDay(xi.day.LIGHTSDAY, false)
        xi.test.world:setVanaTime(5, 58)
        xi.test.world:tick(xi.tick.TIME)
        player:addItem(xi.item.HORROR_HEAD_II)
        player:equipItem(xi.item.HORROR_HEAD_II)
        assert(player:getMod(xi.mod.ENMITY) == 0)

        xi.test.world:tick(xi.tick.VANA_HOUR)
        assert(player:getMod(xi.mod.ENMITY) == 50, 'Horror Head II did not activate at dawn')

        player:unequipItem(xi.slot.HEAD)
        assert(player:getMod(xi.mod.ENMITY) == 0)
        player:equipItem(xi.item.HORROR_HEAD_II)
        assert(player:getMod(xi.mod.ENMITY) == 50)

        xi.test.world:setVanaTime(17, 58)
        xi.test.world:tick(xi.tick.TIME)
        xi.test.world:tick(xi.tick.VANA_HOUR)
        assert(player:getMod(xi.mod.ENMITY) == 0, 'Horror Head II stayed active after dusk')
    end)

    local conditions =
    {
        { itemId = xi.item.HORROR_HEAD,    day = xi.day.LIGHTSDAY, fullMoon = true,  hour = 19 },
        { itemId = xi.item.HORROR_HEAD,    day = xi.day.DARKSDAY,  fullMoon = false, hour = 19 },
        { itemId = xi.item.HORROR_HEAD_II, day = xi.day.DARKSDAY,  fullMoon = false, hour = 12 },
        { itemId = xi.item.HORROR_HEAD_II, day = xi.day.LIGHTSDAY, fullMoon = true,  hour = 12 },
    }

    for _, condition in ipairs(conditions) do
        it(string.format('keeps item %u inactive on day %u with mismatched conditions', condition.itemId, condition.day), function()
            setMoonDay(condition.day, condition.fullMoon)
            xi.test.world:setVanaTime(condition.hour, 0)
            player:addItem(condition.itemId)
            player:equipItem(condition.itemId)
            assert(player:getMod(xi.mod.ENMITY) == 0)
        end)
    end

    for _, fullMoon in ipairs({ true, false }) do
        it('checks Horror Head at Darksday midnight ' .. (fullMoon and 'with full moon' or 'without full moon'), function()
            setMoonDay(xi.day.LIGHTSDAY, fullMoon)
            xi.test.world:setVanaTime(23, 58)
            xi.test.world:tick(xi.tick.TIME)
            player:addItem(xi.item.HORROR_HEAD)
            player:equipItem(xi.item.HORROR_HEAD)
            assert(player:getMod(xi.mod.ENMITY) == 0)

            xi.test.world:tick(xi.tick.VANA_DAY)
            assert(VanadielDayOfTheWeek() == xi.day.DARKSDAY)
            assert(fullMoon and VanadielMoonPhase() >= 95 or not fullMoon and VanadielMoonPhase() <= 10)
            assert(player:getMod(xi.mod.ENMITY) == (fullMoon and -50 or 0))
        end)
    end

    it('activates Pitchfork +1 movement speed only while equipped and costumed', function()
        player:addItem(xi.item.PITCHFORK_P1)
        player:equipItem(xi.item.PITCHFORK_P1)
        local pitchfork = player:getEquippedItem(xi.slot.MAIN)
        assert(pitchfork)
        assert(pitchfork:getMod(xi.mod.MOVE_SPEED_GEAR_BONUS) == 0)

        player:addStatusEffect(xi.effect.COSTUME, { power = 368, duration = 60, origin = player })
        assert(pitchfork:getMod(xi.mod.MOVE_SPEED_GEAR_BONUS) == 13)

        player:delStatusEffect(xi.effect.COSTUME)
        xi.test.world:tick(xi.tick.EFFECT)
        assert(pitchfork:getMod(xi.mod.MOVE_SPEED_GEAR_BONUS) == 0)

        player:addStatusEffect(xi.effect.COSTUME, { power = 368, duration = 60, origin = player })
        player:unequipItem(xi.slot.MAIN)
        assert(pitchfork:getMod(xi.mod.MOVE_SPEED_GEAR_BONUS) == 0)

        player:equipItem(xi.item.PITCHFORK_P1)
        assert(pitchfork:getMod(xi.mod.MOVE_SPEED_GEAR_BONUS) == 13)
    end)
end)

describe('Harvest Festival: Treat Staff activation', function()
    local staff = require('scripts/items/treat_staff')
    local player
    local target
    local item
    local enabled
    local moon
    local direction
    local day
    local hour
    local roll

    before_each(function()
        enabled   = stub('xi.events.harvestFestival.isEnabled', false)
        moon      = stub('VanadielMoonPhase', 100)
        direction = stub('VanadielMoonDirection', 0)
        day       = stub('VanadielDayOfTheWeek', xi.day.DARKSDAY)
        hour      = stub('VanadielHour', 0)
        roll      = stub('math.randomInt', 10)
        player    =
        {
            timers    = {},
            vars      = {},
            warps     = 0,
            level     = 75,
        }

        target = { level = 75 }

        function target:getMainLvl()
            return self.level
        end

        function player:getMainLvl()
            return self.level
        end

        function player:getLocalVar(name)
            return self.vars[name] or 0
        end

        function player:setLocalVar(name, value)
            self.vars[name] = value
        end

        function player:timer(delay, callback)
            table.insert(self.timers, { delay, callback })
        end

        function player:warp()
            self.warps = self.warps + 1
        end

        item = GetReadOnlyItem(xi.item.TREAT_STAFF)
        assert(item)
    end)

    it('requires the full moon, Darksday, and night outside the festival', function()
        local conditions =
        {
            { 95, 0, xi.day.DARKSDAY,  18, true  },
            { 95, 0, xi.day.DARKSDAY,   5, true  },
            { 95, 0, xi.day.DARKSDAY,   6, false },
            { 95, 0, xi.day.DARKSDAY,  17, false },
            { 95, 0, xi.day.LIGHTSDAY, 19, false },
            { 89, 2, xi.day.DARKSDAY,  19, false },
            { 90, 0, xi.day.DARKSDAY,  19, false },
            { 90, 2, xi.day.DARKSDAY,  19, true  },
            { 94, 1, xi.day.DARKSDAY,  19, false },
        }

        for _, condition in ipairs(conditions) do
            moon:returnValue(condition[1])
            direction:returnValue(condition[2])
            day:returnValue(condition[3])
            hour:returnValue(condition[4])
            local previous = #player.timers
            local effect, message, param = staff.onItemAdditionalEffect(player, target, 1, item)
            assert(effect == 0 and message == 0 and param == 0)
            assert(#player.timers == previous + (condition[5] and 1 or 0), 'Unexpected off-season activation')
            if condition[5] then
                player.timers[#player.timers][2](player)
            end
        end

        roll:called(3)
    end)

    it('uses the festival override and delays the warp until after the swing', function()
        enabled:returnValue(true)
        moon:returnValue(0)
        day:returnValue(xi.day.LIGHTSDAY)
        hour:returnValue(12)
        local effect, message, param = staff.onItemAdditionalEffect(player, target, 1, item)
        assert(effect == 0 and message == 0 and param == 0, 'Warp should not add an attack animation or message')
        assert(#player.timers == 1 and player.timers[1][1] == 2500)
        assert(player.warps == 0, 'Warp ran before the timer callback')
        player.timers[1][2](player)
        assert(player.warps == 1)
    end)

    it('uses ten percent against equal or lower levels and twenty against higher levels', function()
        for _, targetLevel in ipairs({ 74, 75, 76 }) do
            target.level = targetLevel
            local threshold = targetLevel > player.level and 20 or 10
            local previous = #player.timers
            roll:returnValue(threshold + 1)
            staff.onItemAdditionalEffect(player, target, 1, item)
            assert(#player.timers == previous, 'Chance exceeded the target-level threshold')
            roll:returnValue(threshold)
            staff.onItemAdditionalEffect(player, target, 1, item)
            assert(#player.timers == previous + 1, 'Threshold roll did not activate')
            player.timers[#player.timers][2](player)
        end

        roll:calledWith(1, 100)
    end)

    it('queues only one warp when several successful swings occur before the timer finishes', function()
        enabled:returnValue(true)
        target.level = 76
        roll:returnValue(1)
        for _ = 1, 8 do
            local effect, message, param = staff.onItemAdditionalEffect(player, target, 1, item)
            assert(effect == 0 and message == 0 and param == 0)
        end

        assert(#player.timers == 1, 'Multiattack queued multiple warp callbacks')
        assert(player.warps == 0)
        player.timers[1][2](player)
        assert(player.warps == 1)
        staff.onItemAdditionalEffect(player, target, 1, item)
        assert(#player.timers == 2, 'Completed warp left the item permanently locked')
    end)
end)

describe('Harvest Festival: Treat Staff melee dispatch', function()
    ---@type CClientEntityPair
    local player
    ---@type CTestEntity
    local target
    local enabled
    local hits
    local misses

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.BLM, level = 1, zone = xi.zone.WEST_RONFAURE })
        player:setUnkillable(true)
        player:addItem(xi.item.TREAT_STAFF)
        player:equipItem(xi.item.TREAT_STAFF)
        local item = player:getEquippedItem(xi.slot.MAIN)
        assert(item)
        assert(item:getMod(xi.mod.ITEM_ADDEFFECT_SCRIPTED) == 1)

        target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        target:setMobMod(xi.mobMod.NO_MOVE, 1)
        target:clearPath()
        target:setMaxHP(1000)
        target:setHP(1000)
        player.entities:moveTo(target:getID())
        hits = 0
        misses = 0
        player:addListener('MELEE_SWING_HIT', 'TEST_TREAT_STAFF_HIT', function()
            hits = hits + 1
        end)

        player:addListener('MELEE_SWING_MISS', 'TEST_TREAT_STAFF_MISS', function()
            misses = misses + 1
        end)

        enabled = stub('xi.events.harvestFestival.isEnabled', true)
        stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
        stub('math.randomInt', function(lower)
            return lower
        end)
    end)

    after_each(function()
        player:removeListener('TEST_TREAT_STAFF_HIT')
        player:removeListener('TEST_TREAT_STAFF_MISS')
        target:setMobMod(xi.mobMod.NO_MOVE, 0)
    end)

    it('queues one warp across a surviving triple attack', function()
        player:setMod(xi.mod.TRIPLE_ATTACK, 100)
        player.actions:engage(target)
        assert(player:isEngaged(), 'Player did not engage the target')
        assert(player:checkDistance(target) <= 1.1, 'Player was not moved into melee range')
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(player)

        assert(hits == 3, 'Expected all three melee hits, got ' .. hits .. ', misses ' .. misses)
        assert(target:isAlive(), 'The target must survive for additional effects')
        assert(player:getLocalVar('TreatStaffWarpPending') == 1)
        enabled:called(1)
    end)

    it('does not activate after the staff is unequipped', function()
        player:unequipItem(xi.slot.MAIN)
        player.actions:engage(target)
        assert(player:isEngaged(), 'Player did not engage the target')
        assert(player:checkDistance(target) <= 1.1, 'Player was not moved into melee range')
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(player)

        assert(hits > 0, 'Expected a melee hit without the staff, got ' .. hits)
        assert(player:getLocalVar('TreatStaffWarpPending') == 0)
        enabled:called(0)
    end)

    it('does not activate on a missed swing', function()
        target:addStatusEffect(xi.effect.ALL_MISS, { power = 1, duration = 60, origin = target })
        player.actions:engage(target)
        assert(player:isEngaged(), 'Player did not engage the target')
        assert(player:checkDistance(target) <= 1.1, 'Player was not moved into melee range')
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(player)

        assert(misses > 0 and hits == 0, 'Expected a missed melee swing')
        assert(player:getLocalVar('TreatStaffWarpPending') == 0)
        enabled:called(0)
    end)

    it('does not activate on a killing blow', function()
        player:setMod(xi.mod.ATT, 1000)
        player:setMod(xi.mod.STR, 1000)
        target:setMaxHP(1)
        target:setHP(1)
        player.actions:engage(target)
        assert(player:isEngaged(), 'Player did not engage the target')
        assert(player:checkDistance(target) <= 1.1, 'Player was not moved into melee range')
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(player)

        assert(hits > 0 and target:isDead(), 'Expected a killing melee hit')
        assert(player:getLocalVar('TreatStaffWarpPending') == 0)
        enabled:called(0)
    end)

    it('lets an enspell take priority over the staff', function()
        player:addStatusEffect(xi.effect.ENFIRE, { power = 1, duration = 60, origin = player })
        player.actions:engage(target)
        assert(player:isEngaged(), 'Player did not engage the target')
        assert(player:checkDistance(target) <= 1.1, 'Player was not moved into melee range')
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(3)
        xi.test.world:tickEntity(player)

        assert(hits > 0 and target:isAlive(), 'Expected a surviving melee hit')
        assert(player:getLocalVar('TreatStaffWarpPending') == 0)
        enabled:called(0)
    end)
end)
