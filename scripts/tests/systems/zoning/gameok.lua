-----------------------------------
-- C2S 0x00C GAMEOK tells the server the client has loaded the zone.
-- Before it, a retail client drops most packets and still acks them, so they are never resent,
-- and S2C 0x00B leaves it stuck on "Downloading data" for good.
-- Retail sends the zone-in reply (0x04F, 0x051, 0x01C, 0x00A) alone in one datagram, then only
-- the equip list and party lists until GAMEOK. Everything else waits for it.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('GAMEOK', function()
    ---@type CClientEntityPair
    local player

    -- A party teleported together lands on the same spot
    local landing = { 86.131, -65.817, 273.861, 25 }

    -- Dropped sub-packets as a failure message, bar the 0x051 that rides with S2C 0x00A
    local function droppedPackets(client)
        local received      = client.network:received()
        local loginDatagram = 0
        local dropped       = {}

        for _, packet in ipairs(received) do
            if packet.type == 0x00A and packet.accepted then
                loginDatagram = packet.datagram
            end
        end

        for _, packet in ipairs(received) do
            if
                not packet.accepted and
                not (packet.type == 0x051 and packet.datagram == loginDatagram)
            then
                table.insert(dropped, string.format('0x%03X in datagram %u: %s', packet.type, packet.datagram, packet.reason))
            end
        end

        return table.concat(dropped, ', ')
    end

    -- Without a spawn, position updates have no entity to move and the player stays invisible
    local function sawSpawn(client, entityId)
        for _, packet in ipairs(client.network:received()) do
            -- 0x10 is the look bit, which every spawn carries
            if
                packet.type == 0x00D and
                packet.entityId == entityId and
                packet.accepted and
                bit.band(packet.updateMask, 0x10) ~= 0
            then
                return true
            end
        end

        return false
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player.network:drain()
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE, landing)
    end)

    it('holds a warp requested during the load until the client sends it', function()
        assert(player.network:login())

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        assert(player:getZoneID() == xi.zone.EAST_RONFAURE, 'The char left the zone before the client loaded it')

        player.network:finishLoading()
        assert(not player.network:isHung(), player.network:hangReason())
        assert(player.network:mode() == 'ingame')

        assert(zoning.awaitZoneOut(player) == 'login')
        player.network:zoneIn()
        assert(player:getZoneID() == xi.zone.WEST_RONFAURE)
    end)

    it('keeps a warp requested during the load across a C2S 0x00A retry', function()
        assert(not player.network:login({ dropReply = true }))

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        assert(player.network:login())
        assert(player:getStatus() == xi.status.DISAPPEAR, 'The retry cleared the queued warp')

        player.network:finishLoading()
        assert(zoning.awaitZoneOut(player) == 'login')
        player.network:zoneIn()
        assert(player:getZoneID() == xi.zone.WEST_RONFAURE)
    end)

    it('takes a logout requested during the load at once, and holds its 0x00B until the client sends it', function()
        assert(player.network:login())

        player:leaveGame()
        xi.test.world:tick()
        assert(not player:getZone(), 'The char is still in the zone')

        player.network:finishLoading()
        assert(not player.network:isHung(), player.network:hangReason())
        assert(player.network:mode() == 'ingame', 'The logout 0x00B went out right after GAMEOK')

        xi.test.world:skipTime(2)
        player.network:exchange()
        assert(player.network:mode() == 'ingame', 'The logout 0x00B went out under 3 s after GAMEOK')

        assert(zoning.awaitZoneOut(player) == 'loggedout')
    end)

    it('waits a moment after GAMEOK before the warp goes out', function()
        assert(player.network:login())

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        player.network:finishLoading()

        -- On PC the client can still be finishing its load right after GAMEOK
        xi.test.world:tick()
        player.network:exchange()
        assert(player.network:mode() == 'ingame', 'S2C 0x00B went out right after GAMEOK')

        -- Inside the settle time, with room for slow builds
        xi.test.world:skipTime(1)
        player.network:exchange()
        assert(player.network:mode() == 'ingame', 'S2C 0x00B went out under 3 s after GAMEOK')

        assert(zoning.awaitZoneOut(player) == 'login')
    end)

    it('opens the gate on a GAMEOK the handler refuses', function()
        assert(player.network:login())
        player.network:finishLoading({ refuseGameOk = true })

        assert(zoning.zoneOut(player, xi.zone.WEST_RONFAURE) == 'login', 'The warp never went out')
    end)

    it('stops waiting for GAMEOK after the load deadline', function()
        assert(player.network:login())

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()

        -- Still loading, so the warp waits
        xi.test.world:skipTime(20)
        player.network:exchange()
        assert(player.network:mode() == 'loading')

        -- A client this slow is not loading, and the warp goes out
        xi.test.world:skipTime(15)
        player.network:exchange()
        assert(player.network:isHung(), string.format('Client is %s', player.network:mode()))
    end)

    it('sends the zone-in reply alone in a datagram that ends at S2C 0x00A, as retail does', function()
        -- With gear on, there is an equip list to send after the reply
        player.network:zoneIn()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        assert(player:getEquipID(xi.slot.MAIN) == xi.item.BRONZE_SWORD)
        player.network:drain()
        zoning.zoneOut(player, xi.zone.WEST_RONFAURE)

        player.network:clearReceived()
        player.network:zoneIn()

        local loginDatagram = 0
        local received      = player.network:received()
        for _, packet in ipairs(received) do
            if packet.type == 0x00A then
                loginDatagram = packet.datagram
            end
        end

        local reply        = {}
        local sawEquipList = false
        for _, packet in ipairs(received) do
            if packet.datagram == loginDatagram then
                table.insert(reply, string.format('%03X', packet.type))
            elseif
                packet.type == 0x050 and
                packet.accepted
            then
                sawEquipList = true
            end
        end

        -- The equip list never shares the reply's datagram on retail
        local order = table.concat(reply, ' ')
        assert(order == '04F 051 01C 00A', string.format('The zone-in reply datagram was %s', order))
        assert(sawEquipList, 'The equip list never arrived after S2C 0x00A')
    end)

    it('sends only the zone-in reply, equip list and party lists before GAMEOK', function()
        local sentBeforeGameOk =
        {
            [0x00A] = true, -- Login
            [0x01C] = true, -- Item max
            [0x04F] = true, -- Equip clear
            [0x051] = true, -- Grap list
            [0x050] = true, -- Equip list
            [0x0C8] = true, -- Alliance list
            [0x0DD] = true, -- Party member
        }

        -- The zone queues spawns and updates for the char while the client sends C2S 0x011 and loads
        player.network:clearReceived()
        assert(player.network:login())
        for _ = 1, 3 do
            xi.test.world:tick()
            player.network:exchange()
        end

        for _, packet in ipairs(player.network:received()) do
            if packet.type ~= 0 then
                assert(sentBeforeGameOk[packet.type], string.format('0x%03X went out before GAMEOK', packet.type))
            end
        end

        -- What was held reaches the client once it has loaded
        player.network:clearReceived()
        player.network:finishLoading()
        player.network:drain()

        local sawHeld = false
        for _, packet in ipairs(player.network:received()) do
            if
                (packet.type == 0x00D or packet.type == 0x00E) and
                packet.accepted
            then
                sawHeld = true
            end
        end

        assert(sawHeld, 'No held spawn reached the client after GAMEOK')
    end)

    it('lets the client drop nothing during a zone change', function()
        -- Anything the client drops is still acked, so the server would never resend it
        player.network:clearReceived()
        player.network:zoneIn()

        local dropped = droppedPackets(player)
        assert(dropped == '', string.format('Client dropped %s', dropped))
    end)

    it('delivers the party list once the client has loaded', function()
        local other = xi.test.world:spawnPlayer({ zone = xi.zone.EAST_RONFAURE })
        player.network:zoneIn()
        player.actions:inviteToParty(other)
        other.actions:acceptPartyInvite()
        player.network:drain()
        zoning.zoneOut(player, xi.zone.WEST_RONFAURE)

        player.network:clearReceived()
        player.network:zoneIn()

        -- GAMEOK asks for the list, and the next char tick sends it. Retail mostly sends it after GAMEOK too.
        xi.test.world:tick()
        player.network:drain()

        local sawMember = false
        for _, packet in ipairs(player.network:received()) do
            if
                packet.type == 0x0DD and
                packet.accepted and
                packet.entityId == other:getID()
            then
                sawMember = true
            end
        end

        assert(sawMember, 'The client never got the party list')
        local dropped = droppedPackets(player)
        assert(dropped == '', string.format('Client dropped %s', dropped))
    end)

    -- A party teleported together arrived invisible, since a spawn sent before GAMEOK is dropped and never resent
    it('shows a player who zones in while the client loads', function()
        local other = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        other.network:drain()
        zoning.zoneOut(other, xi.zone.EAST_RONFAURE, landing)

        -- The other player's spawn queues while the player is still loading
        player.network:clearReceived()
        assert(player.network:login())
        assert(other.network:login())

        -- The spawn waits for the player's C2S 0x00C instead of riding in the 0x011 reply
        player.network:finishLoading()
        player.network:drain()

        assert(sawSpawn(player, other:getID()), string.format('Player never saw the other player. Dropped: %s', droppedPackets(player)))
    end)
end)
