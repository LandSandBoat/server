local ffi = require('ffi')

describe('Mog House visits', function()
    ---@type CClientEntityPair
    local host
    ---@type CClientEntityPair
    local visitor

    local function skipTime()
        for _ = 1, 4 do
            xi.test.world:skipTime(1)
        end
    end

    -- 0x0CB: kind 1 open / 2 close at 0x04, param2 0 on open / 1 on close at 0x06
    local function setMogHouseOpen(open)
        local packet = ffi.new('uint8_t[8]')
        packet[4]    = open and 1 or 2
        packet[6]    = open and 0 or 1
        host.packets:send(0x0CB, packet, assert(ffi.sizeof(packet)))
        skipTime()
    end

    local function placeFurniture(itemId, container, x)
        host:addItem(itemId)
        host.actions:moveItem(xi.inv.INVENTORY, host:findItem(itemId, xi.inv.INVENTORY):getSlotID(), container, 1)
        host.actions:placeFurniture(container, host:findItem(itemId, container):getSlotID(), x, 0)
        host.actions:finishFurnishing()

        return host:findItem(itemId, container)
    end

    local function visitHost()
        visitor.entities:gotoAndTrigger('Hildith', { eventId = 488, finishOption = host:getID() })
        skipTime()
    end

    before_each(function()
        host    = xi.test.world:spawnPlayer({ zone = xi.zone.BASTOK_MARKETS })
        visitor = xi.test.world:spawnPlayer({ zone = xi.zone.BASTOK_MARKETS })

        for _, player in ipairs({ host, visitor }) do
            if player:isInEvent() then
                player.events:finish()
            end
        end

        -- Party up in the same zone, cross-zone invites need xi_world
        visitor:setPos(host:getXPos(), host:getYPos(), host:getZPos())
        host.actions:inviteToParty(visitor)
        visitor.actions:acceptPartyInvite()
        assert(visitor:getPartySize() == 2, 'party not formed')

        host:setNation(xi.nation.BASTOK)
        host:gotoMogHouse(xi.zone.BASTOK_MINES)
        if host:isInEvent() then
            host.events:finish()
        end
    end)

    it('visits and gets sent back to the NPC on close', function()
        setMogHouseOpen(true)
        visitHost()

        assert(visitor:getZoneID() == xi.zone.BASTOK_MINES, 'visitor not in the host zone')
        assert(visitor:inMogHouse(xi.mogHouse.VISITING), 'visitor not in the host Mog House')
        assert(visitor:getMogHouseOwner():getID() == host:getID(), 'wrong owner')

        setMogHouseOpen(false)

        assert(visitor:getZoneID() == xi.zone.BASTOK_MARKETS, 'visitor not back in the NPC zone')
        assert(not visitor:inMogHouse(), 'visitor still in a Mog House')
        assert(visitor:checkDistance(visitor.entities:get('Hildith')) < 3, 'visitor not at the NPC')
    end)

    it('door exit goes back to the NPC', function()
        setMogHouseOpen(true)
        visitHost()

        -- 0x05E: zone line 'zmrq' at 0x04, exit mode 0
        local exitPacket = ffi.new('uint8_t[24]')
        ffi.copy(exitPacket + 4, 'zmrq', 4)
        visitor.packets:send(0x05E, exitPacket, assert(ffi.sizeof(exitPacket)))
        skipTime()

        assert(visitor:getZoneID() == xi.zone.BASTOK_MARKETS, 'visitor not back in the NPC zone')
        assert(visitor:checkDistance(visitor.entities:get('Hildith')) < 3, 'visitor not at the NPC')
    end)

    it('expels visitors when the host zones', function()
        setMogHouseOpen(true)
        visitHost()
        assert(visitor:inMogHouse(), 'visitor not in the Mog House')

        host:gotoZone(xi.zone.BASTOK_MINES)
        skipTime()

        assert(not visitor:inMogHouse(), 'visitor still in the Mog House')
        assert(visitor:getZoneID() == xi.zone.BASTOK_MARKETS, 'visitor not back in the NPC zone')
    end)

    it('refuses a closed Mog House', function()
        visitHost()

        assert(visitor:getZoneID() == xi.zone.BASTOK_MARKETS, 'visitor left the zone')
        assert(not visitor:inMogHouse(), 'visitor got in')
    end)

    it('refuses a host outside the party', function()
        setMogHouseOpen(true)
        visitor.actions:leaveParty()
        skipTime()
        visitHost()

        assert(not visitor:inMogHouse(), 'visitor got in')
    end)

    it('moogle ignores visitors', function()
        setMogHouseOpen(true)
        visitHost()

        visitor.packets:clear()
        visitor.actions:trigger(visitor.entities:get('Moogle'))

        for _, packet in ipairs(visitor.packets:getIncoming()) do
            assert(packet.type ~= 0x02E, 'moogle menu opened')
        end

        assert(not visitor:isInEvent(), 'moogle event started')
    end)

    it('locks the layout while open', function()
        setMogHouseOpen(true)
        assert(not placeFurniture(xi.item.ARMOR_BOX, xi.inv.MOGSAFE, 0):isInstalled(), 'furniture placed while open')

        setMogHouseOpen(false)
        host.actions:placeFurniture(xi.inv.MOGSAFE, host:findItem(xi.item.ARMOR_BOX, xi.inv.MOGSAFE):getSlotID(), 0, 0)
        host.actions:finishFurnishing()
        assert(host:findItem(xi.item.ARMOR_BOX, xi.inv.MOGSAFE):isInstalled(), 'furniture not placed after close')
    end)

    it('sends the host furniture from both safes', function()
        -- Safe 2 needs 2F unlocked
        host:setMoghouseFlag(0x20)
        host:changeContainerSize(xi.inv.MOGSAFE2, 10)

        -- Unplaced item in safe slot 1, so the visitor slots are compacted
        host:addItem(xi.item.BRONZE_SWORD)
        host.actions:moveItem(xi.inv.INVENTORY, host:findItem(xi.item.BRONZE_SWORD, xi.inv.INVENTORY):getSlotID(), xi.inv.MOGSAFE, 1)
        assert(placeFurniture(xi.item.ARMOR_BOX, xi.inv.MOGSAFE, 0):isInstalled(), 'safe furniture not placed')
        assert(placeFurniture(xi.item.HUME_M_MANNEQUIN, xi.inv.MOGSAFE, 14):isInstalled(), 'mannequin not placed')
        assert(placeFurniture(xi.item.WATER_CASK, xi.inv.MOGSAFE2, 3):isInstalled(), 'safe 2 furniture not placed')
        setMogHouseOpen(true)

        visitor.packets:clear()
        visitHost()

        -- 0x026: used at 0x04, container at 0x05, slot at 0x06
        local mannequinSent = false
        for _, packet in ipairs(visitor.packets:getIncoming()) do
            if packet.type == 0x026 and packet.data[4] == 1 then
                assert(packet.data[5] == xi.inv.MOGSAFE and packet.data[6] == 2, 'mannequin sent at the wrong slot')
                mannequinSent = true
            end
        end

        assert(mannequinSent, 'mannequin not sent')

        -- Inventory goes out on 0x00C, which the test zone-in doesn't send
        visitor.packets:clear()
        local gameOk = ffi.new('uint8_t[12]')
        visitor.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))

        -- 0x020: item id at 0x0C, container at 0x0E, slot at 0x0F
        local itemAt = {}
        for _, packet in ipairs(visitor.packets:getIncoming()) do
            if packet.type == 0x020 then
                itemAt[packet.data[14] * 256 + packet.data[15]] = packet.data[12] + packet.data[13] * 256
            end
        end

        assert(itemAt[xi.inv.MOGSAFE * 256 + 1] == xi.item.ARMOR_BOX, 'safe furniture missing')
        assert(itemAt[xi.inv.MOGSAFE * 256 + 2] == xi.item.HUME_M_MANNEQUIN, 'mannequin missing')
        assert(itemAt[xi.inv.MOGSAFE2 * 256 + 1] == xi.item.WATER_CASK, 'safe 2 furniture missing')
    end)
end)
