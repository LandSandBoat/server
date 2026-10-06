-----------------------------------
-- The kid Mithra shops grow with the whole server's spending and reset at JST midnight.
-----------------------------------
local ffi = require('ffi')

describe('Kid Mithra shops', function()
    ---@type CClientEntityPair
    local player

    local function setShop(prefix, level, sales, lockUntil)
        SetServerVariable(string.format('%sLevel', prefix), level)
        SetServerVariable(string.format('%sSales', prefix), sales)
        SetServerVariable(string.format('%sLockUntil', prefix), lockUntil)
        SetServerVariable(string.format('%sIgnoreUntil', prefix), 0)
    end

    local function buy(slot)
        local packet = ffi.new('uint8_t[16]')
        packet[4]    = 1
        packet[10]   = slot
        player.packets:send(0x083, packet, assert(ffi.sizeof(packet)))

        -- Shop purchases are rate limited.
        xi.test.world:skipTime(2)
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.RULUDE_GARDENS })
        player:setGil(1000000)
    end)

    describe('Dabih Jajalioh', function()
        it('sells no eggs while she is starting out', function()
            setShop('[Dabih]', 1, 0, 0)
            player.entities:gotoAndTrigger('Dabih_Jajalioh')

            -- Eight flowers, so slot 9 is past the end of the stock.
            buy(9)

            assert(player:getItemCount(xi.item.CHOCOBO_EGG_FAINTLY_WARM) == 0, 'Expected no egg at level 1')
            assert(GetServerVariable('[Dabih]Level') == 1, 'Expected level 1')
        end)

        it('rises a level past 10,000 gil and sells as many eggs as players buy', function()
            setShop('[Dabih]', 1, 10001, 0)
            player.entities:gotoAndTrigger('Dabih_Jajalioh')

            assert(GetServerVariable('[Dabih]Level') == 2, 'Expected level 2')

            -- Eight flowers and an Ogre Pumpkin come first.
            for _ = 1, 5 do
                buy(9)
            end

            local eggs = player:getItemCount(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
            assert(eggs == 5, string.format('Expected five eggs, got %d', eggs))
        end)

        it('sells the third egg and drops three flowers at the top level', function()
            setShop('[Dabih]', 3, 30001, 0)
            player.entities:gotoAndTrigger('Dabih_Jajalioh')

            assert(GetServerVariable('[Dabih]Level') == 4, 'Expected level 4')

            -- Five flowers, then the stock of levels 2, 3 and 4.
            buy(15)

            assert(player:getItemCount(xi.item.CHOCOBO_EGG_A_BIT_WARM) == 1, 'Expected the a bit warm egg')
        end)

        it('starts each level from nothing, locks, and ignores purchases right after rising', function()
            setShop('[Dabih]', 1, 10001, 0)
            player.entities:gotoAndTrigger('Dabih_Jajalioh')

            assert(GetServerVariable('[Dabih]Sales') == 0, 'Expected the takings to start over')
            assert(GetServerVariable('[Dabih]LockUntil') >= GetSystemTime() + 4200, 'Expected a lock of about 71 minutes')

            -- A flower bought inside the first minute does not count.
            buy(0)
            assert(GetServerVariable('[Dabih]Sales') == 0, 'Expected the purchase to be ignored')
        end)

        it('holds her level while locked after a change', function()
            setShop('[Dabih]', 1, 50000, GetSystemTime() + 600)
            player.entities:gotoAndTrigger('Dabih_Jajalioh')

            assert(GetServerVariable('[Dabih]Level') == 1, 'Expected no rise while locked')
        end)
    end)

    it('saves each shop only until JST midnight', function()
        local expiries = {}
        stub('SetServerVariable', function(name, value, expiry)
            expiries[name] = expiry
        end)

        player.entities:gotoAndTrigger('Dabih_Jajalioh')

        for _, name in ipairs({ '[Dabih]Sales', '[Dabih]Level', '[Dabih]LockUntil', '[Dabih]IgnoreUntil' }) do
            assert(expiries[name] == JstMidnight(), string.format('Expected %s to expire at JST midnight', name))
        end
    end)

    describe('Macchi Gazlitah', function()
        it('adds her bakery stock at level 2', function()
            setShop('[Macchi]', 1, 0, 0)
            player.entities:gotoAndTrigger('Macchi_Gazlitah')

            -- Milk, cheese and broth, so slot 3 is past the end of the stock.
            buy(3)
            assert(player:getItemCount(xi.item.CHEESE_SANDWICH) == 0, 'Expected no sandwich at level 1')

            setShop('[Macchi]', 1, 10001, 0)
            player.entities:gotoAndTrigger('Macchi_Gazlitah')
            buy(3)

            assert(player:getItemCount(xi.item.CHEESE_SANDWICH) == 1, 'Expected a sandwich at level 2')
        end)

        it('needs over 20,000 gil to reach level 3', function()
            setShop('[Macchi]', 2, 19000, 0)
            player.entities:gotoAndTrigger('Macchi_Gazlitah')
            assert(GetServerVariable('[Macchi]Level') == 2, 'Expected her to stay at level 2')

            setShop('[Macchi]', 2, 20001, 0)
            player.entities:gotoAndTrigger('Macchi_Gazlitah')
            assert(GetServerVariable('[Macchi]Level') == 3, 'Expected level 3')
        end)

        it('stops at level 3', function()
            setShop('[Macchi]', 3, 900000, 0)
            player.entities:gotoAndTrigger('Macchi_Gazlitah')

            assert(GetServerVariable('[Macchi]Level') == 3, 'Expected her to stay at level 3')
        end)

        it('keeps her takings apart from Dabih\'s', function()
            setShop('[Dabih]', 1, 0, 0)
            setShop('[Macchi]', 1, 10001, 0)
            player.entities:gotoAndTrigger('Macchi_Gazlitah')
            player.entities:gotoAndTrigger('Dabih_Jajalioh')

            assert(GetServerVariable('[Macchi]Level') == 2, 'Expected Macchi at level 2')
            assert(GetServerVariable('[Dabih]Level') == 1, 'Expected Dabih to stay at level 1')
        end)
    end)
end)
