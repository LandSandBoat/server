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

    describe('Magicite', function()
        before_each(function()
            player:setRank(4)
            player:setRankPoints(4000)
        end)

        it('should not start the mission from the embassy attendant', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('Nelcabrit', { eventId = 45 })

            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
            player.assert.no:hasKI(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end)

        it('should not start the mission when the door event is cancelled', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r5', { eventId = 130, finishOption = utils.EVENT_CANCELLED_OPTION })

            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
            player.assert.no:hasKI(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end)

        it('should start the mission at the embassy door', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r5', { eventId = 130, finishOption = 1 })

            player.assert:hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.MAGICITE)
            player.assert:hasKI(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end)

        it('should give Paya-Sabya a follow up line once the garden scene has played', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r5', { eventId = 130, finishOption = 1 })
            player.entities:gotoAndTrigger('_6r9', { eventId = 128 })

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('Aldo', { eventId = 152 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Paya-Sabya', { eventId = 80 })
            player.entities:gotoAndTrigger('Paya-Sabya', { eventId = 23 })
        end)

        it('should complete the mission', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r5', { eventId = 130, finishOption = 1 })
            player.entities:gotoAndTrigger('_6r9', { eventId = 128 })
            player.assert:hasKI(xi.ki.LETTER_TO_ALDO)

            -- Aldo trades the letter for the silver bell.
            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('Aldo', { eventId = 152 })
            player.assert:hasKI(xi.ki.SILVER_BELL)
            player.assert.no:hasKI(xi.ki.LETTER_TO_ALDO)

            player:gotoZone(xi.zone.MONASTIC_CAVERN)
            player.entities:gotoAndTrigger('Magicite', { eventId = 0 })
            player.assert:hasKI(xi.ki.MAGICITE_OPTISTONE)

            player:gotoZone(xi.zone.ALTAR_ROOM)
            player.entities:gotoAndTrigger('Magicite', { eventId = 44 })
            player.assert:hasKI(xi.ki.MAGICITE_ORASTONE)

            -- The last stone appends the Lion and Shadow of Darkness scene to the same event.
            player:gotoZone(xi.zone.QULUN_DOME)
            player.entities:gotoAndTrigger('Magicite', { eventId = 0 })
            player.assert:hasKI(xi.ki.MAGICITE_AURASTONE)

            -- The archduke takes all three stones and issues the airship pass.
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r9', { eventId = 60 })
            player.assert:hasKI(xi.ki.AIRSHIP_PASS)
            player.assert.no:hasKI(xi.ki.MAGICITE_OPTISTONE)
            player.assert.no:hasKI(xi.ki.MAGICITE_ORASTONE)
            player.assert.no:hasKI(xi.ki.MAGICITE_AURASTONE)

            player.entities:gotoAndTrigger('Nelcabrit', { eventId = 36 })
            player.assert
                :hasMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.NONE)
                :hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.MAGICITE)
                :hasKI(xi.ki.MESSAGE_TO_JEUNO_SANDORIA)
        end)
    end)
end)
