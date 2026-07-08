describe('Lockstyle', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.SOUTHERN_SAN_DORIA,
            })
    end)

    it('equipped item model appears in the appearance update', function()
        player:addItem(xi.item.BRONZE_HARNESS)
        player:equipItem(xi.item.BRONZE_HARNESS)
        player.packets:clear()

        player.actions:setLockstyle(3,
            {
                { itemId = xi.item.BRONZE_HARNESS, slot = xi.slot.BODY },
            })

        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x051 then
                local bodyModel = pkt.data[8] + pkt.data[9] * 256
                assert(bodyModel == 0x200F,
                    string.format('expected body model 0x200F, got 0x%04X', bodyModel))
                return
            end
        end

        assert(false, 'did not receive GRAP_LIST packet')
    end)

    it('nonexistent item zeroes the body slot in the appearance update', function()
        player.packets:clear()

        player.actions:setLockstyle(3,
            {
                { itemId = 99999, slot = xi.slot.BODY },
            })

        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x051 then
                local bodyModel = pkt.data[8] + pkt.data[9] * 256
                assert(bodyModel == 0x2000,
                    string.format('expected zeroed body 0x2000, got 0x%04X', bodyModel))
                return
            end
        end

        assert(false, 'did not receive GRAP_LIST packet')
    end)

    it('toggling on and off is safe', function()
        player.actions:setLockstyle(3)
        player.actions:setLockstyle(4)
        player.actions:setLockstyle(0)
    end)
end)
