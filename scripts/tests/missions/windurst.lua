describe('Windurst', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer()

        player:setNation(xi.nation.WINDURST)
        player:setRank(4)
        player:setRankPoints(4000)
    end)

    describe('Magicite', function()
        it('should not start the mission from the embassy attendant', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('Pakh_Jatalfih', { eventId = 50 })

            player.assert:hasMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.NONE)
            player.assert.no:hasKI(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end)

        it('should not start the mission when the door event is cancelled', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r8', { eventId = 131, finishOption = utils.EVENT_CANCELLED_OPTION })

            player.assert:hasMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.NONE)
            player.assert.no:hasKI(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end)

        it('should start the mission at the embassy door', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r8', { eventId = 131, finishOption = 1 })

            player.assert:hasMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MAGICITE)
            player.assert:hasKI(xi.ki.ARCHDUCAL_AUDIENCE_PERMIT)
        end)

        it('should give Paya-Sabya a follow up line once the garden scene has played', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r8', { eventId = 131, finishOption = 1 })
            player.entities:gotoAndTrigger('_6r9', { eventId = 128 })

            player:gotoZone(xi.zone.LOWER_JEUNO)
            player.entities:gotoAndTrigger('Aldo', { eventId = 152 })

            player:gotoZone(xi.zone.UPPER_JEUNO)
            player.entities:gotoAndTrigger('Paya-Sabya', { eventId = 80 })
            player.entities:gotoAndTrigger('Paya-Sabya', { eventId = 23 })
        end)

        it('should complete the mission', function()
            player:gotoZone(xi.zone.RULUDE_GARDENS)
            player.entities:gotoAndTrigger('_6r8', { eventId = 131, finishOption = 1 })
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

            player.entities:gotoAndTrigger('Pakh_Jatalfih', { eventId = 37 })
            player.assert
                :hasMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.NONE)
                :hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MAGICITE)
                :hasKI(xi.ki.MESSAGE_TO_JEUNO_WINDURST)
        end)
    end)
end)
