describe('Guild shop hours', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.MHAURA })
    end)

    local statOpen  = 0
    local statClose = 1

    local function guildStat()
        local stat
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x086 then
                stat = pkt.data[4]
            end
        end

        return stat
    end

    local function openAt(hour)
        xi.test.world:setVanaTime(hour, 0)
        player.packets:clear()
        player.entities:gotoAndTrigger('Kamilah')
    end

    it('reports closed before opening hours', function()
        openAt(7)
        assert(guildStat() == statClose, 'not closed before hours')
    end)

    it('reports open during shop hours', function()
        openAt(8)
        assert(guildStat() == statOpen, 'not open during hours')
    end)

    it('closes at the close hour', function()
        openAt(22)
        player.packets:clear()

        xi.test.world:tick(xi.tick.TIME)
        xi.test.world:setVanaTime(23, 30)
        xi.test.world:tick(xi.tick.TIME)

        assert(guildStat() == statClose, 'not closed at close hour')
    end)
end)
