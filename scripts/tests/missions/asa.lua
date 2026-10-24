describe('A Shantotto Ascension', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()
        player:setLevel(99)

        -- Avoid cross-expansion zone-in cutscene conflicts (see tests/missions/wotg.lua).
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.A_RHAPSODY_FOR_THE_AGES)
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.ABOMINATION)
    end)

    describe('03 - That Which Curdles Blood', function()
        it('should take the chosen enfeeblement kit at the Trodden Snow and give the seals', function()
            player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
            xi.mission.setVar(player, xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD, 'Option', xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS)
            player:addItem(xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS)

            player:gotoZone(xi.zone.QUFIM_ISLAND)
            player.actions:tradeNpc('Trodden_Snow', { xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS }, { eventId = 44 })

            player.assert
                :hasCompletedMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
                :hasKI(xi.keyItem.DOMINAS_SCARLET_SEAL)
                :hasKI(xi.keyItem.DOMINAS_AZURE_SEAL)
            player.assert.no:hasItem(xi.item.ENFEEBLEMENT_KIT_OF_BLINDNESS)
        end)
    end)
end)
