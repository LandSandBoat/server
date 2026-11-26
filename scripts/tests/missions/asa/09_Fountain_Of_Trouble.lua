local packetReader = require('scripts.tests.helpers.packet_reader')
local fountainID   = zones[xi.zone.FULL_MOON_FOUNTAIN]
local toraimaraiID = zones[xi.zone.TORAIMARAI_CANAL]

describe('ASA M9 - Fountain of Trouble', function()
    ---@type CClientEntityPair
    local player

    local saps =
    {
        ['qm1'] = xi.keyItem.FIRE_SAP_CRYSTAL,
        ['qm2'] = xi.keyItem.WATER_SAP_CRYSTAL,
        ['qm3'] = xi.keyItem.WIND_SAP_CRYSTAL,
        ['qm4'] = xi.keyItem.EARTH_SAP_CRYSTAL,
        ['qm5'] = xi.keyItem.LIGHTNING_SAP_CRYSTAL,
        ['qm6'] = xi.keyItem.ICE_SAP_CRYSTAL,
        ['qm7'] = xi.keyItem.LIGHT_SAP_CRYSTAL,
        ['qm8'] = xi.keyItem.DARK_SAP_CRYSTAL,
    }

    before_each(function()
        player = xi.test.world:spawnPlayer({ level = 75 })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)
    end)

    it('gives one sap per ??? in Toraimarai Canal, once', function()
        player:gotoZone(xi.zone.TORAIMARAI_CANAL)

        for npcName, sap in pairs(saps) do
            player.entities:gotoAndTrigger(npcName)
            player.events:expectNotInEvent()
            player.assert:hasKI(sap)
        end

        player.packets:clear()
        player.entities:gotoAndTrigger('qm1')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, toraimaraiID.text.NOTHING_OUT_OF_ORDINARY), 'Expected nothing more from a looted ???')
    end)

    it('still gives saps once the mission is done', function()
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ROMANCING_THE_CLONE)
        player:gotoZone(xi.zone.TORAIMARAI_CANAL)

        player.entities:gotoAndTrigger('qm1')
        player.assert:hasKI(xi.keyItem.FIRE_SAP_CRYSTAL)
    end)

    it('completes at the Moon Spiral entrance with a sap', function()
        player:addKeyItem(xi.keyItem.FIRE_SAP_CRYSTAL)
        player:gotoZone(xi.zone.FULL_MOON_FOUNTAIN)

        player.entities:gotoAndTrigger('MS_Entrance', { eventId = 63 })
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.BATTARU_ROYALE)
        player.assert:hasKI(xi.keyItem.FIRE_SAP_CRYSTAL)
    end)

    it('waits at the Moon Spiral entrance without a sap', function()
        player:gotoZone(xi.zone.FULL_MOON_FOUNTAIN)

        player.packets:clear()
        player.entities:gotoAndTrigger('MS_Entrance')
        player.events:expectNotInEvent()
        assert(packetReader.saidMessage(player, fountainID.text.NO_BATTLEFIELD_ENTRY), 'Expected the whirling force message')
        player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.FOUNTAIN_OF_TROUBLE)
    end)
end)
