describe('Talk action', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_BASTOK })
    end)

    it('starts the event of a shown NPC', function()
        player.entities:gotoAndTrigger('Agapito', { eventId = 17 })
    end)

    it('ignores a hidden NPC', function()
        local agapito = player.entities:moveTo('Agapito')
        agapito:setStatus(xi.status.DISAPPEAR)

        player.actions:trigger(agapito)
        agapito:setStatus(xi.status.NORMAL)

        player.events:expectNotInEvent()
    end)
end)
