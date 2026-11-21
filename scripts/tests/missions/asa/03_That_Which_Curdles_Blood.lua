local packetReader = require('scripts.tests.helpers.packet_reader')
local qufimID      = zones[xi.zone.QUFIM_ISLAND]

describe('ASA M3 - That Which Curdles Blood', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 10 })

        -- Skips the Rhapsodies of Vana'diel cutscene on entering a city.
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONANCE)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
        player:setCharVar('Mission[11][2]Option', xi.item.ENFEEBLEMENT_KIT_OF_SLEEP)
    end)

    it('has the three guild NPCs explain the kit', function()
        player:gotoZone(xi.zone.PORT_WINDURST)
        -- The first Kuroido-Moido only appears in cutscenes.
        player.entities:gotoAndTrigger(zones[xi.zone.PORT_WINDURST].npc.KUROIDO_MOIDO[2], { eventId = 858 })

        player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
        player.entities:gotoAndTrigger('Faulpie', { eventId = 944 })

        player:gotoZone(xi.zone.BASTOK_MINES)
        player.entities:gotoAndTrigger('Abd-al-Raziq', { eventId = 590 })

        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
    end)

    it('completes when the kit is traded to the Trodden Snow', function()
        player:addItem(xi.item.ENFEEBLEMENT_KIT_OF_SLEEP)
        player:gotoZone(xi.zone.QUFIM_ISLAND)
        player.actions:tradeNpc('Trodden_Snow', { xi.item.ENFEEBLEMENT_KIT_OF_SLEEP }, { eventId = 44 })

        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)
        player.assert.no:hasItem(xi.item.ENFEEBLEMENT_KIT_OF_SLEEP)
        local seals =
        {
            xi.keyItem.DOMINAS_SCARLET_SEAL,
            xi.keyItem.DOMINAS_CERULEAN_SEAL,
            xi.keyItem.DOMINAS_EMERALD_SEAL,
            xi.keyItem.DOMINAS_AMBER_SEAL,
            xi.keyItem.DOMINAS_VIOLET_SEAL,
            xi.keyItem.DOMINAS_AZURE_SEAL,
        }

        for _, seal in ipairs(seals) do
            player.assert:hasKI(seal)
        end
    end)

    it('shows the writing in the snow', function()
        player:gotoZone(xi.zone.QUFIM_ISLAND)

        player.packets:clear()
        player.entities:gotoAndTrigger('Trodden_Snow')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, qufimID.text.ASA_SNOW), 'Expected the writing in the snow')
    end)

    it('refuses a kit other than the one demanded', function()
        player:addItem(xi.item.ENFEEBLEMENT_KIT_OF_POISON)
        player:gotoZone(xi.zone.QUFIM_ISLAND)
        player.actions:tradeNpc('Trodden_Snow', { xi.item.ENFEEBLEMENT_KIT_OF_POISON })

        player.events:expectNotInEvent()
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
        player.assert:hasItem(xi.item.ENFEEBLEMENT_KIT_OF_POISON)
    end)
end)
