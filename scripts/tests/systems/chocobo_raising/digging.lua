-----------------------------------
-- Digging on a registered chocobo against a rental.
-----------------------------------
local ffi           = require('ffi')
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local whistle  = xi.chocoboRaising.whistle
local ability  = xi.chocoboRaising.ability
local personal = xi.chocoboDig.personal

local zoneId = xi.zone.EAST_RONFAURE

local regularItem = xi.item.LITTLE_WORM
local burrowItem  = xi.item.CHAMOMILE
local boreItem    = xi.item.ARROWWOOD_LOG

local hit  = 1
local miss = 1000

-- RCP 255 is rank 7: a rate of 50 becomes 67.
local between = 60

-- The first regular pass makes 4 layer rolls: the item and three extras.
local function missFirstPass(call)
    if call <= 4 then
        return miss
    end

    return hit
end

local function digTable(regularRate)
    return
    {
        [xi.chocoboDig.layer.TREASURE] = {},
        [xi.chocoboDig.layer.REGULAR]  = { { regularItem, regularRate or 50, xi.craftRank.AMATEUR } },
        [xi.chocoboDig.layer.BURROW]   = { { burrowItem, 50, xi.craftRank.AMATEUR } },
        [xi.chocoboDig.layer.BORE]     = { { boreItem, 50, xi.craftRank.AMATEUR } },
    }
end

local function chocobo(fields)
    local bird =
    {
        color              = xi.chocoboRaising.color.YELLOW,
        appearance         = 0,
        strength           = 0,
        endurance          = 0,
        discernment        = 0,
        receptivity        = 0,
        ability1           = ability.NONE,
        ability2           = ability.NONE,
        weather_preference = 0,
    }

    for key, value in pairs(fields) do
        bird[key] = value
    end

    return bird
end

describe('Chocobo digging', function()
    ---@type CClientEntityPair
    local player

    local originalTable
    local digging

    -- (1, 1000) is a layer roll, (1, 100) a percent roll, anything else picks the first find.
    local layerRoll
    local percentRoll
    local layerRolls

    local function dig()
        player:setLocalVar('ZoneInTime', 0)
        player:setLocalVar('[DIG]LastDigTime', 0)
        player:setLocalVar('[DIG]LastXPos', 5000)
        player:setLocalVar('[DIG]LastXPosSign', 0)

        local packet = ffi.new('uint8_t[28]')
        local id     = player:getID()
        for byte = 0, 3 do
            packet[4 + byte] = bit.band(bit.rshift(id, byte * 8), 0xFF)
        end

        packet[8]  = bit.band(player:getTargID(), 0xFF)
        packet[9]  = bit.rshift(player:getTargID(), 8)
        packet[10] = 0x11

        layerRolls = 0
        digging    = true
        player.packets:send(0x01A, packet, assert(ffi.sizeof(packet)))
        digging = false
    end

    -- Towns forbid mounts, and job tests leave enmity in West Ronfaure, so ride in East Ronfaure.
    local function ridePersonal(bird)
        player:setGil(whistle.registrationPrice)
        assert(whistle.register(player, bird), 'Expected the registration')
        player:addItem(xi.item.CHOCOBO_WHISTLE)
        raisingClient.callChocobo(player)

        local mount = assert(player:getStatusEffect(xi.effect.MOUNTED), 'Expected to ride the chocobo')
        assert(mount:getSubPower() == 64, 'Expected the personal chocobo')
    end

    local function rideRental(bird)
        player:setGil(whistle.registrationPrice)
        whistle.register(player, bird)
        player:addStatusEffect(xi.effect.MOUNTED, { power = xi.mount.CHOCOBO, duration = 1800, origin = player, silent = true })
    end

    -- dig() zeroes the last dig time, so a dig that never ran fails here.
    local function assertFinds(expected)
        assert(player:getLocalVar('[DIG]LastDigTime') ~= 0, 'Expected the dig to run')

        for _, itemId in ipairs({ regularItem, burrowItem, boreItem }) do
            local found = player:hasItem(itemId)
            assert(found == (expected[itemId] == true), string.format('Item %d: expected found=%s', itemId, tostring(expected[itemId] == true)))
        end
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        xi.test.world:setSetting('main.DIG_FATIGUE', 100)

        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA, level = 20 })
        player:setGMLevel(0)
        player:deleteRaisedChocobo()
        player:addKeyItem(xi.keyItem.CHOCOBO_LICENSE)
        raisingClient.gotoZone(player, zoneId)

        player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
        xi.chocoboDig.updateFatigue(player, 0)

        originalTable = xi.chocoboDig.digInfo[zoneId]
        xi.chocoboDig.digInfo[zoneId] = digTable()

        layerRoll   = hit
        percentRoll = 100
        digging     = false

        stub('VanadielMoonPhase', 25)

        local originalRandomInt = math.randomInt
        stub('math.randomInt', function(low, high)
            if not digging then
                return originalRandomInt(low, high)
            end

            if low == 1 and high == 1000 then
                layerRolls = layerRolls + 1

                if type(layerRoll) == 'function' then
                    return layerRoll(layerRolls)
                end

                return layerRoll
            end

            if low == 1 and high == 100 then
                return percentRoll
            end

            return low
        end)
    end)

    after_each(function()
        xi.chocoboDig.digInfo[zoneId] = originalTable
        player:deleteRaisedChocobo()
    end)

    describe('Burrow and Bore', function()
        it('ignores the registered abilities, RCP and DSC on a rental', function()
            rideRental(chocobo({ ability1 = ability.BURROW, ability2 = ability.BORE, receptivity = 255, discernment = 255 }))
            percentRoll = 1
            dig()

            assertFinds({ [regularItem] = true })
            player.assert.no:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)

            -- A rare rate the registered RCP would raise.
            player:delItem(regularItem, 1)
            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            layerRoll = between
            dig()

            assertFinds({})
            assert(layerRolls == 4, string.format('Expected the regular layer rolled, got %d rolls', layerRolls))
        end)

        -- /mount sets the personal flag whether or not a chocobo is registered.
        it('treats a /mount chocobo with none registered as a rental', function()
            player:registerChocobo({ ability1 = ability.BURROW })
            player:addStatusEffect(xi.effect.MOUNTED, { power = xi.mount.CHOCOBO, subPower = 64, duration = 1800, origin = player, silent = true })
            dig()

            assertFinds({ [regularItem] = true })
        end)

        it('digs the regular layer only, and only once, on a personal chocobo without the abilities', function()
            ridePersonal(chocobo({}))
            dig()

            assertFinds({ [regularItem] = true })

            -- Without Treasure Finder a pass that finds nothing is not rolled again.
            player:delItem(regularItem, 1)
            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            layerRoll = missFirstPass
            dig()

            assertFinds({})
            assert(layerRolls == 4, string.format('Expected one pass, got %d rolls', layerRolls))
        end)

        it('digs the Burrow layer with Burrow', function()
            ridePersonal(chocobo({ ability1 = ability.BURROW }))
            dig()

            assertFinds({ [regularItem] = true, [burrowItem] = true })
        end)

        it('counts three finds as one dig', function()
            ridePersonal(chocobo({ ability1 = ability.BURROW, ability2 = ability.BORE }))
            dig()

            assertFinds({ [regularItem] = true, [burrowItem] = true, [boreItem] = true })
            assert(xi.chocoboDig.fetchFatigue(player) == 1, string.format('Expected one dig, got %d', xi.chocoboDig.fetchFatigue(player)))
        end)
    end)

    describe('END', function()
        local limit = 5

        before_each(function()
            xi.test.world:setSetting('main.DIG_FATIGUE', limit)
        end)

        it('stops a rental at the daily limit', function()
            rideRental(chocobo({ endurance = 255 }))
            xi.chocoboDig.updateFatigue(player, limit)
            dig()

            assertFinds({})
            assert(layerRolls == 0, string.format('Expected the dig refused before any roll, got %d rolls', layerRolls))
        end)

        it('adds a dig per 2 END', function()
            ridePersonal(chocobo({ endurance = 40 }))

            xi.chocoboDig.updateFatigue(player, limit + 19)
            dig()
            assertFinds({ [regularItem] = true })

            player:delItem(regularItem, 1)
            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            xi.chocoboDig.updateFatigue(player, limit + 20)
            dig()
            assertFinds({})
            assert(layerRolls == 0, string.format('Expected the dig refused before any roll, got %d rolls', layerRolls))
        end)

        it('caps the extra digs at 100', function()
            ridePersonal(chocobo({ endurance = 255 }))

            xi.chocoboDig.updateFatigue(player, limit + personal.maxExtraDigs - 1)
            dig()
            assertFinds({ [regularItem] = true })

            player:delItem(regularItem, 1)
            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            xi.chocoboDig.updateFatigue(player, limit + personal.maxExtraDigs)
            dig()
            assertFinds({})
            assert(layerRolls == 0, string.format('Expected the dig refused before any roll, got %d rolls', layerRolls))
        end)
    end)

    describe('Treasure Finder', function()
        it('rolls the regular layer again when nothing was found', function()
            ridePersonal(chocobo({ ability1 = ability.TREASURE_FINDER }))
            layerRoll = missFirstPass
            dig()

            assertFinds({ [regularItem] = true })
            assert(layerRolls > 4, string.format('Expected a second pass, got %d rolls', layerRolls))
        end)

        it('does not roll again on a rental', function()
            rideRental(chocobo({ ability1 = ability.TREASURE_FINDER }))
            layerRoll = missFirstPass
            dig()

            assertFinds({})
            assert(layerRolls == 4, string.format('Expected one pass, got %d rolls', layerRolls))
        end)
    end)

    describe('RCP', function()
        it('raises a rare rate and leaves a common rate alone', function()
            ridePersonal(chocobo({ receptivity = 255 }))
            layerRoll = between
            dig()

            assertFinds({ [regularItem] = true })

            player:delItem(regularItem, 1)
            player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
            xi.chocoboDig.digInfo[zoneId] = digTable(personal.rareRateBelow)
            layerRoll = personal.rareRateBelow + 1
            dig()

            assertFinds({})
            assert(layerRolls == 4, string.format('Expected the regular layer rolled, got %d rolls', layerRolls))
        end)

        it('stores RCP beside the packed stats', function()
            player:setGil(whistle.registrationPrice)
            whistle.register(player, chocobo({ strength = 255, endurance = 254, discernment = 253, receptivity = 252 }))

            local stats = whistle.registeredStats(player)
            assert(stats.strength == 255 and stats.endurance == 254 and stats.discernment == 253, 'Expected the packed stats')
            assert(stats.receptivity == 252, string.format('Expected RCP 252, got %d', stats.receptivity))
        end)
    end)

    describe('DSC', function()
        -- DSC 255 is rank 7: a 30% chance.
        it('keeps the greens on a winning roll and eats them on a losing one', function()
            ridePersonal(chocobo({ discernment = 255 }))
            percentRoll = 6 * personal.keepGreensPerRank
            dig()

            assertFinds({ [regularItem] = true })
            player.assert:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)

            percentRoll = 6 * personal.keepGreensPerRank + 1
            dig()

            assertFinds({ [regularItem] = true })
            player.assert.no:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
        end)

        describe('with little room', function()
            before_each(function()
                ridePersonal(chocobo({ discernment = 255 }))
                percentRoll = 6 * personal.keepGreensPerRank
            end)

            it('spends the last greens when the find takes their slot', function()
                raisingClient.leaveFreeSlots(player, 0)
                dig()

                assertFinds({ [regularItem] = true })
                player.assert.no:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
                assert(player:getItemCount(regularItem) == 1, 'Expected one find')
            end)

            it('keeps the last greens when a slot is left for them', function()
                raisingClient.leaveFreeSlots(player, 1)
                dig()

                assertFinds({ [regularItem] = true })
                assert(player:getItemCount(xi.item.BUNCH_OF_GYSAHL_GREENS) == 1, 'Expected the greens back')
            end)

            it('keeps a green from a stack with a full inventory', function()
                player:delItem(xi.item.BUNCH_OF_GYSAHL_GREENS, 1)
                player:addItem({ id = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 2 })
                raisingClient.leaveFreeSlots(player, 0)
                dig()

                assert(player:getItemCount(xi.item.BUNCH_OF_GYSAHL_GREENS) == 2, string.format('Expected 2 greens, got %d', player:getItemCount(xi.item.BUNCH_OF_GYSAHL_GREENS)))
            end)
        end)

        it('spends a single green from one of two slots when the find takes its slot', function()
            ridePersonal(chocobo({ discernment = 255 }))
            percentRoll = 6 * personal.keepGreensPerRank
            player:addItem({ id = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 1 })
            player:changeContainerSize(xi.inventoryLocation.INVENTORY, -player:getFreeSlotsCount())
            dig()

            assertFinds({ [regularItem] = true })
            assert(player:getItemCount(xi.item.BUNCH_OF_GYSAHL_GREENS) == 1, string.format('Expected 1 green left, got %d', player:getItemCount(xi.item.BUNCH_OF_GYSAHL_GREENS)))
        end)
    end)
end)
