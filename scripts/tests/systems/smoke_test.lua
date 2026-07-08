describe('Smoke Tests', function()
    it('New Character Flow', function()
        ---@type CClientEntityPair
        local player = xi.test.world:spawnPlayer(
            {
                zone = xi.zone.PORT_SAN_DORIA,
                new  = true,
            })

        -- Verify player was created in correct zone
        player.assert:inZone(xi.zone.PORT_SAN_DORIA)

        -- Verify starting race gear, job gear, and adventurer coupon
        player.assert
            :hasItem(xi.item.HUME_M_GLOVES)
            :hasItem(xi.item.HUME_M_BOOTS)
            :hasItem(xi.item.ONION_SWORD)
            :hasItem(xi.item.ADVENTURER_COUPON)

        -- Verify starting key items
        player.assert
            :hasKI(xi.ki.MAP_OF_THE_SAN_DORIA_AREA)
            :hasKI(xi.ki.JOB_GESTURE_WARRIOR)
            :hasKI(xi.ki.JOB_GESTURE_MONK)
            :hasKI(xi.ki.JOB_GESTURE_WHITE_MAGE)
            :hasKI(xi.ki.JOB_GESTURE_BLACK_MAGE)
            :hasKI(xi.ki.JOB_GESTURE_RED_MAGE)
            :hasKI(xi.ki.JOB_GESTURE_THIEF)

        -- Verify starting gil
        local expectedGil = xi.settings.main.START_GIL or 10
        player.assert:hasGil(expectedGil)

        -- Talk to an NPC and get an event
        player.entities:gotoAndTrigger('Regine', { eventId = 510 })

        -- Zone to West Sarutabaruta
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player.assert:inZone(xi.zone.WEST_RONFAURE)

        -- Find a rabbit and teleport to it
        local rabbit = player.entities:moveTo('Wild_Rabbit')
        assert(rabbit)
        -- TODO: Set the seed, attack Rabbit once, verify HP lost match expectations
    end)
end)
