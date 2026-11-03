---@diagnostic disable: undefined-field
local ffi = require('ffi')

ffi.cdef [[
    typedef struct {
        uint16_t id : 9;
        uint16_t size : 7;
        uint16_t sync;
        uint8_t  Kind;
        uint8_t  unknown00;
        char     Str[128];
    } GP_CLI_COMMAND_CHAT_STD;
]]

local unknownCommandLog = 'Function does not exist'
local rateLimitLog      = 'Rate-limiting packet GP_CLI_COMMAND_CHAT_STD'

local function countLogs(text)
    local count = 0
    for _, line in ipairs(xi.test.world:getLogs()) do
        if string.find(line, text, 1, true) then
            count = count + 1
        end
    end

    return count
end

local function sendChat(player, message)
    local packet = ffi.new('GP_CLI_COMMAND_CHAT_STD')
    ffi.copy(packet.Str, message)
    player.packets:send(0x0B5, packet, ffi.sizeof(packet))
end

describe('Chat commands', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
    end)

    it('drops a second chat packet sent within the rate limit', function()
        sendChat(player, '!notacommand')
        sendChat(player, '!notacommand')
        local count = countLogs(unknownCommandLog)
        assert(count == 1, string.format('Expected 1 log, got %d', count))

        xi.test.world:skipTime(1)
        sendChat(player, '!notacommand')
        count = countLogs(unknownCommandLog)
        assert(count == 2, string.format('Expected 2 logs, got %d', count))
    end)

    it('warns once for a burst of dropped packets', function()
        for _ = 1, 5 do
            sendChat(player, 'spam')
        end

        local count = countLogs(rateLimitLog)
        assert(count == 1, string.format('Expected 1 warning, got %d', count))
    end)

    it('limits each character separately', function()
        local otherPlayer = xi.test.world:spawnPlayer()

        sendChat(player, '!notacommand')
        sendChat(otherPlayer, '!notacommand')
        local count = countLogs(unknownCommandLog)
        assert(count == 2, string.format('Expected 2 logs, got %d', count))
    end)
end)
