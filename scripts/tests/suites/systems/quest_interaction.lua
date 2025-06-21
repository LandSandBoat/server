describe('[IF] Quest: The Pickpocket', function()
    local client, player

    setup(function()
        client, player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_SAN_DORIA })
    end)

    it('should be available initially', function()
        assert.player(player).quest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET)
            .has.status(xi.questStatus.QUEST_AVAILABLE)
    end)

    it('should trigger pre-requisite events', function()
        client:gotoAndTriggerEntity('Altiret', { eventId = 559 })
        client:gotoAndTriggerEntity('Miene', { eventId = 502 })

        assert.player(player).quest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET)
            .has.status(xi.questStatus.QUEST_AVAILABLE)
    end)

    it('should accept the quest', function()
        client:gotoAndTriggerEntity('Miene', { eventId = 554 })
        client:gotoAndTriggerEntity('Altiret', { eventId = 547 })

        assert.player(player).quest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET)
            .has.status(xi.questStatus.QUEST_ACCEPTED)
    end)

    it('should receive eagle button', function()
        client:gotoAndTriggerEntity('Miene', { eventId = 549 })
        assert.player(player).has.item(xi.item.EAGLE_BUTTON)
        -- TODO: add checks for tossing and reacquiring button
    end)

    it('should exchange eagle button for gilt glasses', function()
        client:gotoZone(xi.zone.WEST_RONFAURE)
        client:tradeNpc('Esca', { xi.item.EAGLE_BUTTON }, { eventId = 121 })

        assert.player(player).no.item(xi.item.EAGLE_BUTTON)
        assert.player(player).has.item(xi.item.GILT_GLASSES)
    end)

    it('should complete the quest', function()
        client:gotoZone(xi.zone.PORT_SAN_DORIA)
        client:tradeNpc('Altiret', { xi.item.GILT_GLASSES }, { eventId = 550 })

        assert.player(player).quest(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_PICKPOCKET)
            .has.status(xi.questStatus.QUEST_COMPLETED)
    end)
end)
