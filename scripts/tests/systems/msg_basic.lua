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

local function battleMessages(player)
    local ids = {}
    for _, packet in pairs(player.packets:getIncoming()) do
        if packet.type == 0x029 then
            table.insert(ids, bit.band(packet.data[0x18] + packet.data[0x19] * 256, 0x7FFF))
        end
    end

    return ids
end

local function assertSent(player, messageId)
    local ids = battleMessages(player)
    for _, id in ipairs(ids) do
        if id == messageId then
            return
        end
    end

    error(string.format('Expected battle message %d, got { %s }', messageId, table.concat(ids, ', ')))
end

describe('xi.msg.basic', function()
    it('matches the ids the core sends', function()
        assert(xi.msg.basic.CANNOT_IN_THIS_AREA == 40)
        assert(xi.msg.basic.NOT_ENOUGH_MP == 34)
        assert(xi.msg.basic.UNABLE_TO_CAST_SPELLS == 49)
    end)

    it('sends CANNOT_IN_THIS_AREA for a jailed shout', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.MORDION_GAOL })
        player.packets:clear()

        local packet = ffi.new('GP_CLI_COMMAND_CHAT_STD', { Kind = 1 })
        ffi.copy(packet.Str, 'hello')
        player.packets:send(0x0B5, packet, assert(ffi.sizeof(packet)))

        assertSent(player, xi.msg.basic.CANNOT_IN_THIS_AREA)
    end)

    it('sends NOT_ENOUGH_MP for a cast without MP', function()
        local player = xi.test.world:spawnPlayer({ job = xi.job.WHM, level = 10 })
        player:addSpell(xi.magic.spell.CURE)
        player:setMP(0)
        player.packets:clear()

        player.actions:useSpell(player, xi.magic.spell.CURE)
        xi.test.world:skipTime(1)

        assertSent(player, xi.msg.basic.NOT_ENOUGH_MP)
    end)

    it('sends UNABLE_TO_CAST_SPELLS while silenced', function()
        local player = xi.test.world:spawnPlayer({ job = xi.job.WHM, level = 10 })
        player:addSpell(xi.magic.spell.CURE)
        player:setMP(100)
        player:addStatusEffect(xi.effect.SILENCE, { power = 1, duration = 60, origin = player })
        player.packets:clear()

        player.actions:useSpell(player, xi.magic.spell.CURE)
        xi.test.world:skipTime(1)

        assertSent(player, xi.msg.basic.UNABLE_TO_CAST_SPELLS)
    end)
end)
