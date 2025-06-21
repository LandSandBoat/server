describe('San d\'Oria Missions', function()
    local client, player

    before_each(function()
        client, player = xi.test.world:spawnPlayer()

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
            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Ambrotien', { eventId = 2000, finishOption = 0 })
            assert.player(player).has.mission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)

            -- Acquire an Orcish Axe and trade to a gate guard.
            player:addItem(xi.item.ORCISH_AXE)
            client:tradeNpc('Ambrotien', { xi.item.ORCISH_AXE }, { eventId = 2020 })
            assert.is_false(player:hasItem(xi.item.ORCISH_AXE))
            assert.player(player).has.mission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
            assert.is_true(player:hasCompletedMission(xi.mission.log_id.SANDORIA,
                xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS))
        end)
    end)

    describe('Bat Hunt', function()
        it('should complete the mission', function()
            player:setRank(1)
            player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)
            player:completeMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS)

            -- Pick up mission from gate guard.
            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Ambrotien', { eventId = 2009, finishOption = 101 })
            assert.player(player).has.mission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT)

            -- Goto King Ranperres Tomb and trigger Tombstone
            client:gotoZone(xi.zone.KING_RANPERRES_TOMB)
            client:gotoAndTriggerEntity('Tombstone_Upper', { eventId = 4 })

            -- Go back to gate guard and trade Orcish Mail Scales gotten from bats around tomb.
            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            player:addItem(xi.item.ORCISH_MAIL_SCALES)
            client:gotoAndTriggerEntity('Ambrotien', { eventId = 2022 })
            client:tradeNpc('Ambrotien', { xi.item.ORCISH_MAIL_SCALES }, { eventId = 2023 })
            assert.player(player).has.mission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
            assert(player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT))
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
            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Ambrotien', { eventId = 2009, finishOption = 102 })
            assert.player(player).has.mission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)

            -- Travel to Northern Sandoria and talk to Arnau
            client:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Arnau', { eventId = 693 })

            -- Ghelsba Outpost and bcnm win
            client:gotoZone(xi.zone.GHELSBA_OUTPOST)
            client:enterBcnmViaNpc('Hut_Door', xi.battlefield.id.SAVE_THE_CHILDREN)
            client:killBattlefieldMobs()
            client:expectBcnmWin({ finishOption = 2 })
            assert.player(player).has.ki(xi.ki.ORCISH_HUT_KEY)
            client:gotoAndTriggerEntity('Hut_Door', { eventId = 55 })

            -- Go back to gate guard and finish mission.
            client:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Ambrotien', { eventId = 2004 })
            assert.player(player).has.mission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
            assert(player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN))
            assert.player(player).has.nationRank(2)

            -- Travel to Northern Sandoria and talk to Arnau for optional cs
            client:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
            client:gotoAndTriggerEntity('Arnau', { eventId = 694 })
        end)
    end)
end)
