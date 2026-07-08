-----------------------------------
-- Verifies the default 'test_npcs_in_gm_home' module (listed in modules/init.txt)
-- still inserts its example NPC into GM_Home, and that triggering it prints
-- the expected message back to the player.
--
-- See: modules/custom/lua/test_npcs_in_gm_home.lua
-----------------------------------
describe('Module: test_npcs_in_gm_home', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
    end)

    -- Dynamic entities are stored internally with a 'DE_' prefix, and entity name
    -- lookups are full-match (std::regex_match), so we query the prefixed name.
    local horroName = 'DE_Horro'

    -- Pull every CHAT_STD (0x017) message the server pushed to the player and
    -- decode the sender name + message text out of the raw packet bytes.
    local function chatMessages()
        local function readStr(pkt, startIdx, maxLen)
            local s = ''
            for i = 0, maxLen - 1 do
                local byte = pkt.data[startIdx + i]
                if byte == nil or byte == 0 then
                    break
                end

                s = string.format('%s%s', s, string.char(byte))
            end

            return s
        end

        local messages = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x017 then
                table.insert(messages,
                    {
                        name = readStr(pkt, 8, 15),
                        text = readStr(pkt, 23, pkt.size - 23),
                    })
            end
        end

        return messages
    end

    it('inserts Horro into GM_Home', function()
        local horro = player.entities:get(horroName)
        assert(horro, 'Horro NPC was not found in GM_Home')
    end)

    it('prints its greeting when triggered', function()
        player.packets:clear()
        player.entities:gotoAndTrigger(horroName)

        local found = false
        for _, msg in ipairs(chatMessages()) do
            if msg.text == 'Welcome to GM Home!' then
                -- packetName is set to '<STAR_LARGE icon>Horro', so just check the suffix
                assert(string.find(msg.name, 'Horro', 1, true), string.format('greeting came from an unexpected sender: %s', msg.name))
                found = true
                break
            end
        end

        assert(found, 'Did not receive Horro\'s "Welcome to GM Home!" greeting')
    end)
end)
