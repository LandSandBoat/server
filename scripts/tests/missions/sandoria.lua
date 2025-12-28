describe('San d\'Oria', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()

        player:setNation(xi.nation.SANDORIA)

        -- SOA first cutscene conflicts
        player:addMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)
        local missionStatus = player:getMissionStatus(xi.mission.log_id.SOA)
        missionStatus = utils.mask.setBit(missionStatus, 0, true)
        missionStatus = utils.mask.setBit(missionStatus, 1, true)
        player:setMissionStatus(xi.mission.log_id.SOA, missionStatus)
        player:completeMission(xi.mission.log_id.SOA, xi.mission.id.soa.RUMORS_FROM_THE_WEST)
    end)

    describe('Smash the Orcish Scouts', function()
        it('should complete the mission', function()
            player:setRank(1)

            -- Pick up mission from gate guard.
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Ambrotien', { eventId = 2000, finishOption = 0 })
            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)

            -- Acquire an Orcish Axe and trade to a gate guard.
            player:addItem(xi.item.ORCISH_AXE)
            player.actions:tradeNpc('Ambrotien', { xi.item.ORCISH_AXE }, { eventId = 2020 })
            player.assert.no:hasItem(xi.item.ORCISH_AXE)
            player.assert
                :hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
                :hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
        end)
    end)

    describe('Bat Hunt', function()
        it('should complete the mission', function()
            player:setRank(1)
            player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
            player:completeMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)

            -- Pick up mission from gate guard.
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Ambrotien', { eventId = 2009, finishOption = 101 })
            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT)

            -- Goto King Ranperres Tomb and trigger Tombstone
            player:gotoZone(xi.zone.KING_RANPERRES_TOMB)
            player.entities:gotoAndTrigger('Tombstone_Upper', { eventId = 4 })

            -- Go back to gate guard and trade Orcish Mail Scales gotten from bats around tomb.
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player:addItem(xi.item.ORCISH_MAIL_SCALES)
            player.entities:gotoAndTrigger('Ambrotien', { eventId = 2022 })
            player.actions:tradeNpc('Ambrotien', { xi.item.ORCISH_MAIL_SCALES }, { eventId = 2023 })
            player.assert
                :hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
                :hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT)
        end)
    end)

    describe('Save the Children', function()
        it('should complete the mission', function()
            player:setRank(1)
            player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
            player:completeMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
            player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT)
            player:completeMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT)

            -- Pick up mission from gate guard.
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Ambrotien', { eventId = 2009, finishOption = 102 })
            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)

            -- Travel to Northern Sandoria and talk to Arnau
            player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Arnau', { eventId = 693 })

            -- Ghelsba Outpost and bcnm win
            player:gotoZone(xi.zone.GHELSBA_OUTPOST)
            player.bcnm:enter('Hut_Door', xi.battlefield.id.SAVE_THE_CHILDREN)
            player.bcnm:killMobs()
            player.bcnm:expectWin({ finishOption = 2 })
            player.assert:hasKI(xi.ki.ORCISH_HUT_KEY)
            player.entities:gotoAndTrigger('Hut_Door', { eventId = 55 })

            -- Go back to gate guard and finish mission.
            player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Ambrotien', { eventId = 2004 })
            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
            player.assert:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)
            player.assert:hasNationRank(2)

            -- Travel to Northern Sandoria and talk to Arnau for optional cs
            player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            player.entities:gotoAndTrigger('Arnau', { eventId = 694 })
        end)
    end)
end)
