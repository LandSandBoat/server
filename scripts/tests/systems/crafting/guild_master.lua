-----------------------------------
-- Guild Masters
--
-- The guild master handler only acts on its own trigger and trade events.
-- Quest cutscenes on the same NPC finish through the fallback too. Before the event
-- check, they credited the speak-to-the-guild-master eminence records.
-- A Moral Manifest on Ponono is the quest-event source.
-----------------------------------
---@diagnostic disable: inject-field
local ffi = require('ffi')

ffi.cdef [[
    typedef struct {
        uint16_t id : 9;
        uint16_t size : 7;
        uint16_t sync;
    } GMTEST_CLI_HEADER;

    // 0x10C - Records of Eminence take-objective packet
    typedef struct {
        GMTEST_CLI_HEADER header;
        uint16_t ObjectiveId;
        uint16_t padding00;
    } GMTEST_CLI_ROE_START;
]]

local speakToWeavers = 103 -- Records of Eminence: Speak to Weavers' Guild Master

describe('Guild Master', function()
    ---@type CClientEntityPair
    local player

    -- Fresh characters get the expansion intro cutscenes on zone-in. Complete the
    -- expansions before travelling so they cannot interrupt the guild master events.
    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 60 })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
        player:gotoZone(xi.zone.WINDURST_WOODS)
    end)

    local function takeRecord(recordId)
        local packet = ffi.new('GMTEST_CLI_ROE_START')
        packet.ObjectiveId = recordId
        player.packets:send(0x10C, packet, ffi.sizeof(packet) or 0)
        assert(player:hasEminenceRecord(recordId), 'the eminence record was not taken')
    end

    it('signs the player up for the guild', function()
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 1 })
        player.assert:hasItem(xi.item.EARTH_CRYSTAL)
        assert(bit.band(player:getCharVar('Guild_Member'), bit.lshift(1, xi.guild.CLOTHCRAFT)) ~= 0, 'signup did not record guild membership')
    end)

    it('credits the speak-to-the-guild-master record from its own menu', function()
        takeRecord(speakToWeavers)
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })
        assert(player:getEminenceCompleted(speakToWeavers), 'the guild master menu did not credit the record')
    end)

    it('does not credit the record from a quest event on the same NPC', function()
        takeRecord(speakToWeavers)
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)

        player.entities:gotoAndTrigger('Ponono', { eventId = 700, finishOption = 0 })
        assert(not player:getEminenceCompleted(speakToWeavers), 'a quest cutscene credited the guild master record')

        player.entities:gotoAndTrigger('Ponono', { eventId = 701, finishOption = 0 })
        assert(not player:getEminenceCompleted(speakToWeavers), 'a quest reminder credited the guild master record')

        -- The reminder alternates with the menu, and the menu still credits it.
        player.entities:gotoAndTrigger('Ponono', { eventId = 10011, finishOption = 0 })
        assert(player:getEminenceCompleted(speakToWeavers), 'the record stopped crediting after quest events')
    end)
end)
