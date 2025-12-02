---@diagnostic disable: inject-field
local ffi = require('ffi')

ffi.cdef [[
    typedef struct {
        uint16_t id : 9;
        uint16_t size : 7;
        uint16_t sync;
    } GP_CLI_HEADER;

    // 0x0A1 - Random Request packet
    typedef struct {
        GP_CLI_HEADER header;
        uint32_t unknown00;          // Always 0
    } GP_CLI_COMMAND_DICE;
]]

describe('Packets', function()
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('can emit arbitrary packets and parse responses', function()
        local p = ffi.new('GP_CLI_COMMAND_DICE')
        p.unknown00 = 0

        -- Random number will be at:
        -- 0x0D + "string2 " (8) + playerName length + " string3 " (9)
        local playerName = player:getName()
        local param0Offset = 0x0D + 8 + #playerName + 9

        xi.test.world:setSeed(557)
        player.packets:send(0x0A2, p, ffi.sizeof(p))

        local incomingPackets = player.packets:getIncoming()
        for _, packet in pairs(incomingPackets) do
            if packet.type == 0x009 then
                -- Read param0 (max 3 digits for values up to 999)
                local param0Str = ''
                for i = 0, 2 do
                    local byte = packet.data[param0Offset + i]
                    if byte == 0 then
                        break
                    end

                    param0Str = string.format('%s%s', param0Str, string.char(byte))
                end

                local param0Value = tonumber(param0Str)
                assert(param0Value == 999, string.format('Expected random value 999, got %s', tostring(param0Value)))
                return
            end
        end

        assert(false, 'Did not receive message packet')
    end)
end)
