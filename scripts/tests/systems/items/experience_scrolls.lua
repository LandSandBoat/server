local ffi = require('ffi')

describe('Experience scrolls', function()
    ---@type CClientEntityPair
    local player

    local rolled = false

    -- Source: https://wiki.ffo.jp/html/8068.html
    local scrolls =
    {
        { id = xi.item.DRAGON_CHRONICLES,     level = 4,  min = 500, max = 1000 },
        { id = xi.item.MIRATETES_MEMOIRS,     level = 20, min = 750, max = 1500 },
        { id = xi.item.GINUVAS_BATTLE_THEORY, level = 65, min = 75,  max = 200  },
        { id = xi.item.SCHULTZ_STRATAGEMS,    level = 65, min = 200, max = 500  },
        { id = xi.item.HEROS_REFLECTIONS,     level = 60, min = 200, max = 500  },
    }

    local function setMeritMode(enabled)
        local packet = ffi.new('uint8_t[12]')
        packet[4] = 2
        packet[5] = enabled and 1 or 0
        player.packets:send(0x0BE, packet, ffi.sizeof(packet) or 0)
    end

    local function readPoints()
        -- Request the current EXP and merit totals.
        -- Scrolls do not always send a merit update.
        player.packets:clear()
        local request = ffi.new('uint8_t[8]')
        player.packets:send(0x061, request, ffi.sizeof(request) or 0)

        local points = {}
        for _, packet in ipairs(player.packets:getIncoming()) do
            if packet.type == 0x061 then
                points.exp   = packet.data[16] + packet.data[17] * 256
                points.next  = packet.data[18] + packet.data[19] * 256
                points.level = packet.data[13]
            elseif packet.type == 0x063 and packet.data[4] + packet.data[5] * 256 == 2 then
                points.limit = packet.data[8] + packet.data[9] * 256
                local flags  = packet.data[10] + packet.data[11] * 256
                points.merit = bit.band(flags, 0x7F)
                points.mode  = bit.band(flags, 0x8000) ~= 0
            end
        end

        assert(points.exp and points.limit and points.merit, 'missing fresh EXP or merit state')
        return points
    end

    local function useScroll(scroll, roll)
        rolled = false
        local randomInt = math.randomInt
        stub('math.randomInt', function(low, high)
            if low == scroll.min and high == scroll.max then
                rolled = true
                return roll
            end

            return randomInt(low, high)
        end)

        player:addItem(scroll.id)
        local item = player:findItem(scroll.id)
        assert(item, 'missing scroll')
        player.packets:clear()
        player.actions:useItem(player, item:getSlotID())
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(10)
    end

    local function checkGainMessage(scroll, amount)
        assert(rolled, 'scroll did not use the expected EXP range')
        local finishes = 0
        for _, action in ipairs(player.packets:actionPackets()) do
            if action.cmd_no == xi.action.category.ITEM_FINISH then
                finishes = finishes + 1
                assert(action.cmd_arg == scroll.id, 'wrong item in completion packet')
                local result = action.target[1].result[1]
                assert(result.message == xi.msg.basic.ITEM_EXP_GAINED, 'wrong EXP message')
                assert(result.value == amount, string.format('expected EXP message %d, got %d', amount, result.value))
                assert(result.kind == 1 and result.sub_kind == 34, 'wrong scroll animation')
            end
        end

        assert(finishes == 1, 'expected one item completion')
        for _, packet in ipairs(player.packets:getIncoming()) do
            if packet.type == 0x029 or packet.type == 0x02D then
                local message = bit.band(packet.data[24] + packet.data[25] * 256, 0x7FFF)
                assert(message ~= xi.msg.basic.EXP_GAINED and message ~= xi.msg.basic.LIMIT_POINTS_GAINED, 'unexpected separate EXP or LP message')
            end
        end

        player.assert.no:hasItem(scroll.id)
    end

    before_each(function()
        xi.test.world:setSetting('main.EXP_RATE', 1)
        xi.test.world:setSetting('map.EXP_LOSS_LEVEL', 1)
        xi.test.world:setSetting('map.MAX_MERIT_POINTS', 30)
        player = xi.test.world:spawnPlayer({ level = 99, zone = xi.zone.GM_HOME })
        player:setLevelCap(99)
        player:addKeyItem(xi.ki.LIMIT_BREAKER)

        -- Start with 9,999 LP and 2 merits. Any LP gain will add a merit.
        player:addExp(29999)
        local points = readPoints()
        assert(points.limit == 9999 and points.merit == 2, 'invalid merit precondition')
        assert(points.exp == points.next - 1, 'invalid capped EXP precondition')
    end)

    for _, scroll in ipairs(scrolls) do
        describe(tostring(scroll.id), function()
            for _, meritMode in ipairs({ false, true }) do
                describe(meritMode and 'merit mode' or 'EXP mode', function()
                    for _, state in ipairs(
                        {
                            { name = 'capped at 99', level = 99, cap = 99, loss = 0    },
                            { name = 'room for EXP', level = 99, cap = 99, loss = 2000 },
                            { name = 'crossing cap', level = 99, cap = 99, loss = 1    },
                            { name = 'capped at 75', level = 75, cap = 75, loss = 0    },
                            { name = 'leveling up',  level = 75, cap = 99, loss = 1    },
                        }) do
                        it(state.name, function()
                            player:setLevel(state.level)
                            player:setLevelCap(state.cap)
                            if state.loss > 0 then
                                player:delExp(state.loss)
                            end

                            setMeritMode(meritMode)
                            local before = readPoints()
                            assert(before.mode == meritMode, 'merit mode was not set')
                            assert(before.exp == before.next - 1 - state.loss, 'EXP setup failed')

                            useScroll(scroll, scroll.max)
                            checkGainMessage(scroll, scroll.max)
                            local after    = readPoints()
                            local expected = before.exp + scroll.max
                            if state.level == state.cap then
                                expected = math.min(expected, before.next - 1)
                                assert(after.level == state.level, 'exceeded the level cap')
                            else
                                expected = expected - before.next
                                assert(after.level == state.level + 1, 'scroll did not level up')
                            end

                            assert(after.exp == expected, 'incorrect EXP after scroll')
                            assert(after.limit == before.limit, 'scroll changed limit points')
                            assert(after.merit == before.merit, 'scroll changed merit points')
                            assert(after.mode == before.mode, 'scroll changed merit mode')
                        end)
                    end
                end)
            end

            it('works at its minimum level', function()
                player:setLevel(scroll.level)
                player:setLevelCap(scroll.level)
                setMeritMode(false)
                local before = readPoints()
                useScroll(scroll, scroll.min)
                checkGainMessage(scroll, scroll.min)
                local after = readPoints()
                assert(after.exp == before.exp and after.level == before.level, 'exceeded the level cap')
                assert(after.limit == before.limit and after.merit == before.merit, 'scroll granted LP or merits')
            end)

            it('cannot be used below its minimum level', function()
                player:setLevel(scroll.level - 1)
                local before = readPoints()
                useScroll(scroll, scroll.min)
                player.assert:hasItem(scroll.id)
                for _, action in ipairs(player.packets:actionPackets()) do
                    assert(action.cmd_no ~= xi.action.category.ITEM_FINISH, 'underleveled use completed')
                end

                local after = readPoints()
                assert(after.exp == before.exp, 'rejected use changed EXP')
                assert(after.limit == before.limit and after.merit == before.merit, 'rejected use changed LP or merits')
            end)

            for _, rate in ipairs({ 0, 1.5 }) do
                it('applies script EXP rate ' .. rate .. ' once', function()
                    xi.test.world:setSetting('main.EXP_RATE', rate)
                    xi.test.world:setSetting('map.EXP_RATE', 3)
                    player:delExp(3000)
                    setMeritMode(true)
                    local before = readPoints()
                    local roll   = scroll.min + 1
                    -- The EXP award and message both round to the nearest whole number.
                    local amount = math.floor(roll * rate + 0.5)
                    useScroll(scroll, roll)
                    checkGainMessage(scroll, amount)
                    local after = readPoints()
                    assert(after.exp == before.exp + amount, 'script EXP rate applied incorrectly')
                    assert(after.limit == before.limit and after.merit == before.merit, 'rate changed LP or merits')
                end)
            end

            it('keeps EXP and merit state after zoning', function()
                player:delExp(2000)
                setMeritMode(true)
                useScroll(scroll, scroll.max)
                checkGainMessage(scroll, scroll.max)
                local before = readPoints()
                player:gotoZone(xi.zone.QUFIM_ISLAND)
                local after = readPoints()
                assert(after.exp == before.exp, 'scroll EXP was not saved')
                assert(after.limit == before.limit and after.merit == before.merit, 'scroll changed saved LP or merits')
                assert(after.mode == before.mode, 'scroll changed saved merit mode')
            end)

            it('does not grant LP to a level-synced participant', function()
                xi.test.world:setSetting('map.LEVEL_SYNC_ENABLE', true)
                setMeritMode(true)
                local target = xi.test.world:spawnPlayer({ level = 65, zone = xi.zone.GM_HOME })
                target:setLevelCap(99)
                player.actions:inviteToParty(target)
                target.actions:acceptPartyInvite()
                player.actions:setLevelSync(target)
                player.assert:hasEffect(xi.effect.LEVEL_SYNC)
                assert(player:getMainLvl() == 65, 'level sync was not applied')
                local before = readPoints()
                useScroll(scroll, scroll.max)
                checkGainMessage(scroll, scroll.max)
                xi.test.world:skipTime(31)
                local after = readPoints()
                player.assert:hasEffect(xi.effect.LEVEL_SYNC)
                assert(after.exp == before.exp, 'synced participant exceeded the stored job EXP cap')
                assert(after.limit == before.limit and after.merit == before.merit, 'synced scroll changed LP or merits')
            end)

            it('does not grant LP without Limit Breaker', function()
                player:delKeyItem(xi.ki.LIMIT_BREAKER)
                local before = readPoints()
                useScroll(scroll, scroll.max)
                checkGainMessage(scroll, scroll.max)
                local after = readPoints()
                assert(after.exp == before.exp, 'scroll exceeded the EXP cap')
                assert(after.limit == before.limit and after.merit == before.merit, 'scroll granted hidden LP or merits')
            end)

            it('still grants EXP when merits and LP are capped', function()
                xi.test.world:setSetting('map.MAX_MERIT_POINTS', 2)
                player:delExp(2000)
                setMeritMode(true)
                local before = readPoints()
                useScroll(scroll, scroll.max)
                checkGainMessage(scroll, scroll.max)
                local after = readPoints()
                assert(after.exp == before.exp + scroll.max, 'full merits prevented EXP gain')
                assert(after.limit == before.limit and after.merit == before.merit, 'scroll changed capped LP or merits')
            end)

            it('does not grant LP to a capped level-sync designee', function()
                xi.test.world:setSetting('map.LEVEL_SYNC_ENABLE', true)
                player:setLevel(75)
                player:setLevelCap(75)
                setMeritMode(true)
                local member = xi.test.world:spawnPlayer({ level = 99, zone = xi.zone.GM_HOME })
                player.actions:inviteToParty(member)
                member.actions:acceptPartyInvite()
                player.actions:setLevelSync(player)
                player.assert:hasEffect(xi.effect.LEVEL_SYNC)
                local before = readPoints()
                useScroll(scroll, scroll.max)
                checkGainMessage(scroll, scroll.max)
                local after = readPoints()
                assert(after.exp == before.exp, 'sync designee exceeded the EXP cap')
                assert(after.limit == before.limit and after.merit == before.merit, 'sync designee gained LP or merits')
            end)
        end)
    end

    for _, meritMode in ipairs({ false, true }) do
        it('ordinary addExp still grants LP in ' .. (meritMode and 'merit mode' or 'capped EXP mode'), function()
            setMeritMode(meritMode)
            local before = readPoints()
            player:addExp(546)
            local after = readPoints()
            assert(after.exp == before.exp, 'ordinary LP gain changed EXP')
            assert(after.limit == 545 and after.merit == before.merit + 1, 'ordinary LP conversion broke')
            assert(after.mode == before.mode, 'ordinary gain changed merit mode')
        end)
    end

    it('explicit true retains ordinary addExp behavior', function()
        player:addExp(546, true)
        local points = readPoints()
        assert(points.limit == 545 and points.merit == 3, 'explicit true no longer permits LP')
    end)
end)
