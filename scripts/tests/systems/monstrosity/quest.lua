-----------------------------------
-- The Monstrosity unlock quest, and how it shares the city NPCs with scripts/globals/monstrosity/city.lua.
-----------------------------------

describe('Monstrosity quest', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        -- Rumors from the West and Rhapsodies of Vana'diel play their own cutscenes on entering a city.
        xi.test.world:setSetting('main.ENABLE_SOA', 0)
        xi.test.world:setSetting('main.ENABLE_ROV', 0)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.NORTHERN_SAN_DORIA })
    end)

    it('lets the Suspicious Elvaan chat before the Hume is spoken to', function()
        player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 881 })
    end)

    it('says nothing happens at a city Odyssean Passage without the ring', function()
        player.entities:gotoAndTrigger('Odyssean_Passage')

        assert(not player:isInEvent(), 'the Passage opened without the ring')
    end)

    it('unlocks a starter family and sends the player to the Feretory', function()
        player:gotoZone(xi.zone.PASHHOW_MARSHLANDS)
        player.entities:gotoAndTrigger('Suspicious_Hume', { eventId = 40 })
        player:gotoZone(xi.zone.NORTHERN_SAN_DORIA)

        -- The quest's events win over the NPC script every time, not every other time.
        for _ = 1, 2 do
            player.entities:gotoAndTrigger('Suspicious_Elvaan', { eventId = 882 })
        end

        player:addItem(xi.item.LIZARD_TAIL)
        player.actions:tradeNpc('Suspicious_Elvaan', { xi.item.LIZARD_TAIL }, { eventId = 883 })
        player.assert:hasKI(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)
        player.assert.no:hasItem(xi.item.LIZARD_TAIL)
        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.LIZARD), 'the Lizard should be unlocked')

        player.entities:gotoAndTrigger('Odyssean_Passage', { eventId = 885, finishOption = 1 })
        xi.test.world:skipTime(5)

        assert(player:getZoneID() == xi.zone.FERETORY, string.format('the Passage went to zone %d', player:getZoneID()))

        player.events:expect({ eventId = 2, updates = { 1 }, finishOption = 1 })
        assert(player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY), 'the introduction did not complete the quest')
    end)
end)
