local packetReader = require('scripts.tests.helpers.packet_reader')
local rancorID     = zones[xi.zone.DEN_OF_RANCOR]

describe('ASA M12 - Sisters in Arms', function()
    ---@type CClientEntityPair
    local player

    local uggalepihTablets =
    {
        ['qm_shining1'] = xi.keyItem.TABLET_OF_HEXES_GREED,
        ['qm_shining2'] = xi.keyItem.TABLET_OF_HEXES_ENVY,
        ['qm_shining3'] = xi.keyItem.TABLET_OF_HEXES_MALICE,
        ['qm_shining4'] = xi.keyItem.TABLET_OF_HEXES_DECEIT,
        ['qm_shining5'] = xi.keyItem.TABLET_OF_HEXES_PRIDE,
        ['qm_shining6'] = xi.keyItem.TABLET_OF_HEXES_BALE,
    }

    local rancorTablets =
    {
        ['qm_shiny_1']  = xi.keyItem.TABLET_OF_HEXES_DESPAIR,
        ['qm_shiny_2']  = xi.keyItem.TABLET_OF_HEXES_REGRET,
        ['qm_shiny_3']  = xi.keyItem.TABLET_OF_HEXES_RAGE,
        ['qm_shiny_4']  = xi.keyItem.TABLET_OF_HEXES_AGONY,
        ['qm_shiny_5']  = xi.keyItem.TABLET_OF_HEXES_DOLOR,
        ['qm_shiny_6']  = xi.keyItem.TABLET_OF_HEXES_RANCOR,
        ['qm_shiny_7']  = xi.keyItem.TABLET_OF_HEXES_STRIFE,
        ['qm_shiny_8']  = xi.keyItem.TABLET_OF_HEXES_PENURY,
        ['qm_shiny_9']  = xi.keyItem.TABLET_OF_HEXES_BLIGHT,
        ['qm_shiny_10'] = xi.keyItem.TABLET_OF_HEXES_DEATH,
    }

    local function collect(tablets)
        for npcName, tablet in pairs(tablets) do
            player.entities:gotoAndTrigger(npcName)
            player.events:expectNotInEvent()
            player.assert:hasKI(tablet)
        end
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 75 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS)
    end)

    it('has Aldo repeat the task once, then give way to other business', function()
        -- Zilart has its own Aldo event at the same priority.
        player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION)
        player:gotoZone(xi.zone.LOWER_JEUNO)
        if player:isInEvent() then
            player.events:finish()
        end

        local reminders = 0
        for _ = 1, 3 do
            player.packets:clear()
            player.entities:gotoAndTrigger('Aldo')
            if packetReader.lastEventStart(player).eventId == 10103 then
                reminders = reminders + 1
            end

            player.events:finish()
        end

        assert(reminders == 1, string.format('Expected one reminder from Aldo, got %d', reminders))
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS)
    end)

    it('gives six tablets in the Temple of Uggalepih', function()
        player:gotoZone(xi.zone.TEMPLE_OF_UGGALEPIH)
        collect(uggalepihTablets)
    end)

    it('gives ten tablets in the Den of Rancor, once each', function()
        player:gotoZone(xi.zone.DEN_OF_RANCOR)
        collect(rancorTablets)

        player.packets:clear()
        player.entities:gotoAndTrigger('qm_shiny_1')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, rancorID.text.NOTHING_OUT_OF_ORDINARY), 'Expected nothing more from a looted ???')
    end)

    it('still gives tablets once the mission is done', function()
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.AN_UNEASY_PEACE)
        player:gotoZone(xi.zone.DEN_OF_RANCOR)

        player.entities:gotoAndTrigger('qm_shiny_1')
        player.assert:hasKI(xi.keyItem.TABLET_OF_HEXES_DESPAIR)
    end)

    it('completes at the Mahogany Door with a tablet', function()
        player:addKeyItem(xi.keyItem.TABLET_OF_HEXES_GREED)
        player:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)

        player.entities:gotoAndTrigger('_4j0', { eventId = 4 })
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.PROJECT_SHANTOTTOFICATION)
        player.assert:hasKI(xi.keyItem.TABLET_OF_HEXES_GREED)
    end)

    it('waits at the Mahogany Door without a tablet', function()
        player:gotoZone(xi.zone.SACRIFICIAL_CHAMBER)

        player.entities:gotoAndTrigger('_4j0')
        player.events:expectNotInEvent()
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SISTERS_IN_ARMS)
    end)
end)
