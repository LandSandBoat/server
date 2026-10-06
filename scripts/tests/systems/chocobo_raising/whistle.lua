-----------------------------------
-- The Chocobo Whistle quest, registration, riding, and the whistle and card trades.
-----------------------------------
local ffi           = require('ffi')
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local whistle = xi.chocoboRaising.whistle

local register         = 223
local registerFromCard = 479
local cardToChococard  = 495

-- STR F, END E, no traits.
local gFat =
{
    color       = xi.chocoboRaising.color.YELLOW,
    strength    = 10,
    endurance   = 40,
    appearance  = 0,
    properties  = 0x00AC0000,
    speed       = 64,
    minutes     = 21,
    packetSpeed = 32,
}

-- STR rank 3, END D, large talons.
local blondBrian =
{
    color       = xi.chocoboRaising.color.YELLOW,
    strength    = 100,
    endurance   = 70,
    appearance  = xi.chocoboRaising.appearance.LARGE_TALONS,
    properties  = 0x00CC6008,
    speed       = 70,
    minutes     = 25,
    packetSpeed = 35,
}

local function namedAdult(player, bird)
    raisingClient.tradeEgg(player)
    raisingClient.setChocobo(player,
    {
        first_name = 'Test',
        last_name  = 'Bird',
        stage      = xi.chocoboRaising.stage.ADULT_1,
        color      = bird.color,
        strength   = bird.strength,
        endurance  = bird.endurance,
        appearance = bird.appearance,
    })
end

local function registerAtTrainer(player)
    local client = raisingClient.new(player)

    raisingClient.talk(client)
    local reply = raisingClient.send(client, register)
    raisingClient.finish(client, 0)

    return reply
end

-- Speed from the last 0x037 packet.
local function packetSpeed(player)
    local speed
    for _, packet in pairs(player.packets:getIncoming()) do
        if packet.type == 0x037 then
            speed = bit.band(raisingClient.readU32(packet.data, 0x2C), 0xFFF)
        end
    end

    return speed
end

-- True when a message basic packet (0x029) carried `messageId` since the last clear.
local function messageSent(player, messageId)
    for _, packet in pairs(player.packets:getIncoming()) do
        if
            packet.type == 0x029 and
            bit.band(packet.data[0x18] + packet.data[0x19] * 256, 0x7FFF) == messageId
        then
            return true
        end
    end

    return false
end

describe('Chocobo whistle', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA, level = 20 })
        player:setGMLevel(0)
        player:deleteRaisedChocobo()
        player:addKeyItem(xi.keyItem.CHOCOBO_LICENSE)
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    -- Speed is 64 + 2 per STR rank; time is 17 + 4 minutes per END rank.
    it('computes the captured speed and time, capped at a rental\'s speed and the SS time', function()
        for _, bird in ipairs({ gFat, blondBrian }) do
            local registration = whistle.registration(bird)
            assert(registration.speed == bird.speed, string.format('Expected speed %d, got %d', bird.speed, registration.speed))
            assert(registration.minutes == bird.minutes, string.format('Expected %d minutes, got %d', bird.minutes, registration.minutes))
        end

        local capped = whistle.registration(
        {
            color      = 0,
            appearance = 0,
            strength   = 255,
            endurance  = 255,
            ability1   = xi.chocoboRaising.ability.GALLOP,
            ability2   = xi.chocoboRaising.ability.CANTER,
        })

        assert(capped.speed == xi.settings.map.MOUNT_SPEED, 'Expected rental speed')
        assert(capped.minutes == 45, 'Expected the time cap')

        local firstClass = whistle.registration({ strength = 255, endurance = 0, ability1 = xi.chocoboRaising.ability.GALLOP, ability2 = 0, color = 0 })
        assert(firstClass.speed == xi.settings.map.MOUNT_SPEED, 'Expected SS STR with Gallop to match a rental')
        assert(firstClass.silksSpeedBonus == 0, 'Expected the silks to add nothing past a rental')
    end)

    describe('registration', function()
        it('opens registration once the quest is done and registers the captured chocobos for 250 gil', function()
            namedAdult(player, gFat)
            player:addItem(xi.item.CHOCOBO_WHISTLE)

            -- Menu mask (option 215): only bit 5 (register) opens after the quest.
            local client = raisingClient.new(player)
            raisingClient.talk(client)
            local before = raisingClient.send(client, 215)[0]
            raisingClient.finish(client, 0)

            xi.chocoboRaising.setWhistleProgress(player, whistle.prog.DONE)
            raisingClient.talk(client)
            local after = raisingClient.send(client, 215)[0]
            raisingClient.finish(client, 0)

            assert(before == 0x5FFFFFE8, string.format('Expected the captured mask before the whistle, got 0x%X', before))
            assert(after == 0x5FFFFFC8, string.format('Expected the captured mask after the whistle, got 0x%X', after))

            player:setGil(249)
            registerAtTrainer(player)

            assert(not player:getFieldChocobo(), 'Expected no registration without 250 gil')
            player.assert:hasGil(249)

            for _, bird in ipairs({ gFat, blondBrian }) do
                player:deleteRaisedChocobo()
                namedAdult(player, bird)
                player:setGil(1000)

                local reply = registerAtTrainer(player)
                assert(reply[0] == 0, 'Expected a zero reply')
                player.assert:hasGil(750)

                local chocobo = player:getFieldChocobo()
                assert(chocobo, 'Expected a registered chocobo')
                assert(chocobo.properties == bird.properties, string.format('Expected 0x%08X, got 0x%08X', bird.properties, chocobo.properties))
            end
        end)

        it('shows colour and physical traits', function()
            local chocobo =
            {
                color      = xi.chocoboRaising.color.GREEN,
                strength   = 0,
                endurance  = 0,
                appearance = xi.chocoboRaising.appearance.LARGE_BEAK + xi.chocoboRaising.appearance.FULL_TAIL,
            }

            player:registerChocobo(whistle.registration(chocobo))

            local registered = assert(player:getFieldChocobo())
            assert(registered.color == xi.chocoboRaising.color.GREEN, 'Expected green')
            assert(registered.largeBeak and registered.fullTail and not registered.largeTalons, 'Expected beak and tail')
            assert(bit.band(bit.rshift(registered.properties, 9), 0x7) == xi.chocoboRaising.color.GREEN, 'Expected the colour in bits 9-11')
            assert(bit.band(registered.properties, 0x41) == 0x41, 'Expected the beak and tail bits')
        end)
    end)

    describe('riding', function()
        it('calls a registered chocobo at its speed and time, and refuses with none registered', function()
            player:addItem(xi.item.CHOCOBO_WHISTLE)
            raisingClient.gotoZone(player, xi.zone.EAST_RONFAURE)
            raisingClient.callChocobo(player)

            player.assert.no:hasEffect(xi.effect.MOUNTED)
            assert(messageSent(player, xi.msg.basic.ITEM_UNABLE_TO_USE), 'Expected the refusal message')
            assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 25, 'Expected no charge used')
            player:unequipItem(xi.slot.NECK)
            player:delItem(xi.item.CHOCOBO_WHISTLE, 1)

            for _, bird in ipairs({ gFat, blondBrian }) do
                player:registerChocobo(whistle.registration(bird))
                player:addItem(xi.item.CHOCOBO_WHISTLE)

                raisingClient.callChocobo(player)

                player.assert:hasEffect(xi.effect.MOUNTED)
                local effect = assert(player:getStatusEffect(xi.effect.MOUNTED))
                assert(effect:getSubPower() == 64, 'Expected the personal chocobo flag')
                assert(effect:getDuration() == bird.minutes * 60 * 1000, string.format('Expected %d minutes, got %d ms', bird.minutes, effect:getDuration()))
                local speed = packetSpeed(player)
                assert(speed == bird.packetSpeed, string.format('Expected speed %d, got %s', bird.packetSpeed, tostring(speed)))

                assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 24, 'Expected one charge used')

                player:delStatusEffectSilent(xi.effect.MOUNTED)
                player:unequipItem(xi.slot.NECK)
                player:delItem(xi.item.CHOCOBO_WHISTLE, 1)
            end
        end)

        -- No source shows Red Racing Silks extending /mount, so they do not.
        it('ignores Red Racing Silks on a personal chocobo called with /mount', function()
            player:registerChocobo(whistle.registration(gFat))
            player:addKeyItem(xi.keyItem.CHOCOBO_COMPANION)
            raisingClient.gotoZone(player, xi.zone.EAST_RONFAURE)
            player:addItem(xi.item.RED_RACING_SILKS)
            player:equipItem(xi.item.RED_RACING_SILKS, nil, xi.slot.BODY)

            -- Mount ID 0 is the chocobo.
            local packet = ffi.new('uint8_t[28]')
            local id     = player:getID()
            for byte = 0, 3 do
                packet[4 + byte] = bit.band(bit.rshift(id, byte * 8), 0xFF)
            end

            packet[8]  = bit.band(player:getTargID(), 0xFF)
            packet[9]  = bit.rshift(player:getTargID(), 8)
            packet[10] = 0x1A
            player.packets:send(0x01A, packet, assert(ffi.sizeof(packet)))

            local effect = assert(player:getStatusEffect(xi.effect.MOUNTED), 'Expected to mount')
            assert(effect:getDuration() == gFat.minutes * 60 * 1000, string.format('Expected %d minutes, got %d ms', gFat.minutes, effect:getDuration()))
        end)

        it('rides a rental at rental speed after registering', function()
            player:registerChocobo(whistle.registration(gFat))
            raisingClient.gotoZone(player, xi.zone.EAST_RONFAURE)

            player.packets:clear()
            player:addStatusEffect(xi.effect.MOUNTED, { power = xi.mount.CHOCOBO, duration = 1800, origin = player, silent = true })
            xi.test.world:tickEntity(player)

            local speed = packetSpeed(player)
            assert(speed == xi.settings.map.MOUNT_SPEED / 2, string.format('Expected rental speed, got %s', tostring(speed)))
        end)

        -- bg-wiki: the purple silks rank does not snapshot, and it works on /mount too.
        it('adds time with red racing silks when called, and a rank of speed only while purple silks are worn', function()
            local registration = whistle.registration(gFat)
            player:registerChocobo(registration)

            player:addItem(xi.item.RED_RACING_SILKS)
            player:equipItem(xi.item.RED_RACING_SILKS, nil, xi.slot.BODY)
            assert(whistle.ride(player).seconds == (gFat.minutes + 10) * 60, 'Expected 10 more minutes')
            player:unequipItem(xi.slot.BODY)

            assert(registration.silksSpeedBonus == 2, string.format('Expected one speed rank, got %d', registration.silksSpeedBonus))

            player:addItem(xi.item.PURPLE_RACING_SILKS)
            raisingClient.gotoZone(player, xi.zone.EAST_RONFAURE)

            -- The personal chocobo flag is what the whistle and /mount both set.
            player.packets:clear()
            player:addStatusEffect(xi.effect.MOUNTED, { power = xi.mount.CHOCOBO, duration = 1800, origin = player, subPower = xi.chocoboRaising.personalChocoboFlag, silent = true })
            xi.test.world:tickEntity(player)
            local bare = packetSpeed(player)

            player.packets:clear()
            player:equipItem(xi.item.PURPLE_RACING_SILKS, nil, xi.slot.BODY)
            xi.test.world:tickEntity(player)
            local worn = packetSpeed(player)

            player.packets:clear()
            player:unequipItem(xi.slot.BODY)
            xi.test.world:tickEntity(player)
            local removed = packetSpeed(player)

            assert(bare == gFat.packetSpeed, string.format('Expected speed %d without the silks, got %s', gFat.packetSpeed, tostring(bare)))
            assert(worn == bare + 1, string.format('Expected one rank faster with the silks, got %s', tostring(worn)))
            assert(removed == bare, string.format('Expected the rank gone once removed, got %s', tostring(removed)))
        end)
    end)

    describe('trades at the trainer', function()
        local rechargeEvent = 845
        local cardEvent     = 844

        local function usedWhistle()
            player:registerChocobo(whistle.registration(gFat))
            player:addItem(xi.item.CHOCOBO_WHISTLE)
            raisingClient.gotoZone(player, xi.zone.EAST_RONFAURE)
            raisingClient.callChocobo(player)
            player:delStatusEffectSilent(xi.effect.MOUNTED)
            player:unequipItem(xi.slot.NECK)
            raisingClient.gotoZone(player, xi.zone.SOUTHERN_SAN_DORIA)
            assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 24, 'Expected one charge used')
        end

        -- p0 is charges used, at 400 gil each.
        it('quotes a recharge by charges used and recharges for gil', function()
            usedWhistle()
            player:setGil(1000)

            local client = raisingClient.new(player)
            local start  = raisingClient.trade(client, { xi.item.CHOCOBO_WHISTLE })
            assert(start.eventId == rechargeEvent, 'Expected the recharge event')
            assert(start.params[0] == 1 and start.params[1] == 400, string.format('Expected [1, 400], got [%d, %d]', start.params[0], start.params[1]))
            raisingClient.finish(client, whistle.option.PAY_RECHARGE)

            player.assert:hasGil(600)
            assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 25, 'Expected a full whistle')
        end)

        it('hands the whistle back uncharged when the recharge is declined or unpaid', function()
            usedWhistle()
            player:setGil(1000)

            local client = raisingClient.new(player)
            raisingClient.trade(client, { xi.item.CHOCOBO_WHISTLE })
            raisingClient.finish(client, 0)

            player.assert:hasGil(1000)
            assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 24, 'Expected the same whistle back when declined')

            player:setGil(399)
            raisingClient.trade(client, { xi.item.CHOCOBO_WHISTLE })
            raisingClient.finish(client, whistle.option.PAY_RECHARGE)

            player.assert:hasGil(399)
            assert(player:getItemCount(xi.item.CHOCOBO_WHISTLE) == 1, 'Expected the whistle back')
            assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 24, 'Expected the whistle uncharged without the gil')
        end)

        it('recharges with a coupon', function()
            usedWhistle()
            player:addItem(xi.item.WHISTLE_COUPON)

            local client = raisingClient.new(player)
            local start  = raisingClient.trade(client, { xi.item.CHOCOBO_WHISTLE, xi.item.WHISTLE_COUPON })
            assert(start.params[0] == 1 and start.params[1] == 0, 'Expected the coupon quote')

            local reply = raisingClient.send(client, whistle.option.USE_COUPON)
            assert(reply[0] == 0xFFFFFFFF and reply[1] == whistle.option.USE_COUPON, 'Expected the captured coupon reply')
            raisingClient.finish(client, whistle.option.USE_COUPON)

            player.assert.no:hasItem(xi.item.WHISTLE_COUPON)
            assert(player:findItem(xi.item.CHOCOBO_WHISTLE):getCurrentCharges() == 25, 'Expected a full whistle')
        end)

        it('copies a registration card into a chococard, and registers its chocobo once the quest is done', function()
            local card = xi.chocoboRaising.chocoStateToCard(player,
            {
                first_name         = 'Card',
                last_name          = 'Bird',
                strength           = blondBrian.strength,
                endurance          = blondBrian.endurance,
                discernment        = 0,
                receptivity        = 0,
                allele1            = 0,
                allele2            = 0,
                allele3            = 0,
                ability1           = 0,
                ability2           = 0,
                personality        = 0,
                weather_preference = 0,
                sex                = xi.chocoboRaising.gender.MALE,
                color              = xi.chocoboRaising.color.YELLOW,
                appearance         = 0,
            })

            player:addItem({ id = xi.item.VCS_REGISTRATION_CARD, exdata = card })
            player:setGil(1000)

            local client = raisingClient.new(player)
            local start  = raisingClient.trade(client, { xi.item.VCS_REGISTRATION_CARD })
            assert(start.eventId == cardEvent, 'Expected the card event')
            assert(start.params[0] == 0x7FFFFFFB, string.format('Expected the captured mask, got 0x%X', start.params[0]))
            raisingClient.finish(client, cardToChococard)

            player.assert:hasGil(700)
            assert(player:findItem(xi.item.CHOCOCARD_M), 'Expected a chococard')
            assert(player:findItem(xi.item.VCS_REGISTRATION_CARD), 'Expected to keep the registration card')

            xi.chocoboRaising.setWhistleProgress(player, whistle.prog.DONE)
            player:addItem(xi.item.CHOCOBO_WHISTLE)
            player:setGil(1000)

            start = raisingClient.trade(client, { xi.item.VCS_REGISTRATION_CARD })
            assert(bit.band(start.params[0], bit.lshift(1, 3)) == 0, 'Expected registration offered')
            raisingClient.finish(client, registerFromCard)

            player.assert:hasGil(750)
            local chocobo = player:getFieldChocobo()
            assert(chocobo and chocobo.speed == blondBrian.speed and chocobo.minutes == blondBrian.minutes, 'Expected the card\'s riding stats')
        end)
    end)

    describe('quest', function()
        -- Captured walk reply [300, energy, 1, 0, stage, 0, 0, weather], then 88 | distance << 8 answered [810, 0, 0, 0, 0, 1, 0, 0].
        it('finds the handkerchief on the search walk', function()
            local client = raisingClient.tradeEgg(player)
            raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADULT_1, energy = 100 })
            xi.chocoboRaising.setWhistleProgress(player, whistle.prog.SEARCH)

            stub('math.randomInt', helpers.lowestRoll)

            raisingClient.talk(client)
            local walk   = raisingClient.send(client, 242 + xi.chocoboRaising.cutscenes.GO_ON_A_WALK_SHORT * 256)
            local search = raisingClient.send(client, 88 + bit.lshift(1, 8))
            raisingClient.finish(client, 0)

            assert(walk[2] == 1 and walk[6] == 0, string.format('Expected the search walk with p6 0, got p2 %d p6 %d', walk[2], walk[6]))
            assert(search[0] == xi.keyItem.HANDKERCHIEF and search[5] == 1, 'Expected the handkerchief found')
            player.assert:hasKI(xi.keyItem.HANDKERCHIEF)
            assert(xi.chocoboRaising.whistleProgress(player) == whistle.prog.FOUND, 'Expected the quest at found')
        end)

        it('starts the search when a San d\'Oria chocobo grows up, unless the player has a whistle', function()
            local kerchief = xi.chocoboRaising.handkerchief

            -- { case, handkerchief state, holds a whistle, whistle flag on the adult scene, quest after }
            local cases =
            {
                { 'a first raise',                kerchief.NONE, false, 1, whistle.prog.SEARCH      },
                { 'a returned handkerchief',      kerchief.DONE, false, 1, whistle.prog.SEARCH      },
                { 'a player who holds a whistle', kerchief.NONE, true,  0, whistle.prog.NOT_STARTED },
            }

            stub('math.randomInt', 1)

            for _, case in ipairs(cases) do
                player:deleteRaisedChocobo()
                xi.chocoboRaising.setWhistleProgress(player, whistle.prog.NOT_STARTED)
                xi.chocoboRaising.setHandkerchiefState(player, case[2])

                if case[3] then
                    player:addItem(xi.item.CHOCOBO_WHISTLE)
                end

                local client = raisingClient.tradeEgg(player)
                xi.test.world:skipVanaDays(25 * xi.chocoboRaising.daysToAdult1)

                local reply = assert(raisingClient.replyFor(raisingClient.visit(client), xi.chocoboRaising.cutscenes.ADOLESCENT_TO_ADULT_1), string.format('%s: expected the adult scene', case[1]))
                assert(reply[2] == case[4], string.format('%s: expected whistle flag %d on the adult scene, got %d', case[1], case[4], reply[2]))
                assert(xi.chocoboRaising.whistleProgress(player) == case[5], string.format('%s: expected quest step %d', case[1], case[5]))
                player.assert.no:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)
            end
        end)

        it('sends other raisers to Hantileon', function()
            stub('math.randomInt', 1)
            raisingClient.gotoZone(player, xi.zone.WINDURST_WOODS)

            local client = raisingClient.tradeEgg(player)
            xi.test.world:skipVanaDays(25 * xi.chocoboRaising.daysToAdult1)
            raisingClient.visit(client)
            assert(xi.chocoboRaising.whistleProgress(player) == whistle.prog.SEE_HANTILEON, 'Expected the Hantileon step')

            raisingClient.gotoZone(player, xi.zone.SOUTHERN_SAN_DORIA)

            local hantileon = raisingClient.forNPC(player, 'Hantileon', 829)
            local start     = raisingClient.talk(hantileon)
            assert(start.eventId == 829 and start.params[3] == 2, 'Expected the captured 829 start')

            local reply = raisingClient.send(hantileon, 244)
            assert(reply[2] == 1 and reply[4] == 4 and reply[5] == 1, 'Expected the captured 244 reply')
            raisingClient.finish(hantileon, 244)

            assert(xi.chocoboRaising.whistleProgress(player) == whistle.prog.SEARCH, 'Expected the search')
        end)

        it('keeps the dirty handkerchief when the whistle is declined, and trades it for the whistle', function()
            xi.chocoboRaising.setWhistleProgress(player, whistle.prog.FOUND)
            player:addKeyItem(xi.keyItem.DIRTY_HANDKERCHIEF)

            local hantileon = raisingClient.forNPC(player, 'Hantileon', 830)
            raisingClient.talk(hantileon)
            raisingClient.finish(hantileon, 0)

            player.assert.no:hasItem(xi.item.CHOCOBO_WHISTLE)
            player.assert:hasKI(xi.keyItem.DIRTY_HANDKERCHIEF)
            assert(xi.chocoboRaising.whistleProgress(player) == whistle.prog.FOUND, 'Expected the quest unchanged')

            local start = raisingClient.talk(hantileon)
            assert(start.eventId == 830 and start.params[1] == 1, 'Expected the dirty handkerchief variant')
            raisingClient.finish(hantileon, whistle.option.RECEIVE_WHISTLE)

            player.assert:hasItem(xi.item.CHOCOBO_WHISTLE)
            player.assert.no:hasKI(xi.keyItem.DIRTY_HANDKERCHIEF)
            assert(xi.chocoboRaising.whistleProgress(player) == whistle.prog.DONE, 'Expected the quest done')
            assert(player:getCharVar(xi.chocoboRaising.whistleQuestVar) == 0, 'Expected the quest var cleared')
        end)
    end)

    describe('replacement whistles', function()
        local receiveBit  = 6
        local purchaseBit = 7

        before_each(function()
            player:setCharVar(whistle.pendingVar, 0)
        end)

        it('holds the quest whistle for a full inventory until it is received', function()
            raisingClient.tradeEgg(player)
            xi.chocoboRaising.setWhistleProgress(player, whistle.prog.FOUND)
            player:addKeyItem(xi.keyItem.DIRTY_HANDKERCHIEF)
            raisingClient.leaveFreeSlots(player, 0)

            local hantileon = raisingClient.forNPC(player, 'Hantileon', 830)
            raisingClient.talk(hantileon)
            raisingClient.finish(hantileon, whistle.option.RECEIVE_WHISTLE)

            player.assert.no:hasItem(xi.item.CHOCOBO_WHISTLE)
            player.assert.no:hasKI(xi.keyItem.DIRTY_HANDKERCHIEF)
            assert(player:getCharVar(whistle.pendingVar) == 1, 'Expected the whistle held')
            assert(xi.chocoboRaising.whistleProgress(player) == whistle.prog.DONE, 'Expected the quest done')

            raisingClient.leaveFreeSlots(player, 1)
            local client = raisingClient.new(player)
            raisingClient.talk(client)
            local mask = raisingClient.send(client, 215)[0]

            -- A clear menu bit offers the entry.
            assert(bit.band(mask, bit.lshift(1, receiveBit)) == 0 and bit.band(mask, bit.lshift(1, purchaseBit)) ~= 0, 'Expected Receive and not Purchase')
            raisingClient.finish(client, whistle.option.RECEIVE_WHISTLE)

            player.assert:hasItem(xi.item.CHOCOBO_WHISTLE)
            assert(not whistle.canReceiveWhistle(player), 'Expected nothing held')
        end)

        it('sells a lost whistle from the main menu, but not a second one', function()
            raisingClient.tradeEgg(player)
            xi.chocoboRaising.setWhistleProgress(player, whistle.prog.DONE)
            player:setGil(25000)

            local client = raisingClient.new(player)
            raisingClient.talk(client)
            local mask = raisingClient.send(client, 215)[0]

            -- A clear menu bit offers the entry.
            assert(bit.band(mask, bit.lshift(1, purchaseBit)) == 0 and bit.band(mask, bit.lshift(1, receiveBit)) ~= 0, 'Expected Purchase and not Receive')
            raisingClient.finish(client, whistle.option.BUY_WHISTLE)

            player.assert:hasGil(5000)
            assert(player:getItemCount(xi.item.CHOCOBO_WHISTLE) == 1, 'Expected exactly one whistle')

            player:setGil(25000)
            raisingClient.talk(client)
            raisingClient.finish(client, whistle.option.BUY_WHISTLE)

            player.assert:hasGil(25000)
        end)
    end)

    it('gives Mapitoto\'s chocobo companion only for a registered whistle', function()
        raisingClient.gotoZone(player, xi.zone.UPPER_JEUNO)

        player:addKeyItem(xi.keyItem.TRAINERS_WHISTLE)
        player:addItem(xi.item.CHOCOBO_WHISTLE)

        player.actions:tradeNpc('Mapitoto', { xi.item.CHOCOBO_WHISTLE })
        player.events:expectNotInEvent()

        player:registerChocobo(whistle.registration(gFat))

        local mapitoto = raisingClient.forNPC(player, 'Mapitoto', 10227)
        local start    = raisingClient.trade(mapitoto, { xi.item.CHOCOBO_WHISTLE })
        assert(start.eventId == 10227, 'Expected the companion event')
        assert(start.params[0] == xi.item.CHOCOBO_WHISTLE and start.params[1] == xi.keyItem.TRAINERS_WHISTLE, 'Expected the whistle and the KI')
        assert(start.params[2] == 0 and start.params[3] == xi.keyItem.CHOCOBO_COMPANION, 'Expected the captured params')
        player.assert:hasKI(xi.keyItem.CHOCOBO_COMPANION)
        raisingClient.finish(mapitoto, xi.keyItem.CHOCOBO_COMPANION)

        player.assert:hasKI(xi.keyItem.CHOCOBO_COMPANION)
        assert(player:getItemCount(xi.item.CHOCOBO_WHISTLE) == 1, 'Expected the whistle handed back')
    end)
end)
