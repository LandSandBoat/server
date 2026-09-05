describe('Level Sync', function()
    it('resets TP when applied, and for a player joining afterwards', function()
        local leader = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })
        local target = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 20, zone = xi.zone.SOUTHERN_SAN_DORIA })
        local joiner = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 75, zone = xi.zone.SOUTHERN_SAN_DORIA })

        leader.actions:inviteToParty(target)
        target.actions:acceptPartyInvite()

        leader:setTP(1000)
        target:setTP(1000)

        leader.actions:setLevelSync(target)

        leader.assert:hasEffect(xi.effect.LEVEL_SYNC)
        assert(leader:getMainLvl() == 20, string.format('expected sync to 20, level=%d', leader:getMainLvl()))
        assert(leader:getTP() == 0, string.format('expected leader TP reset, TP=%d', leader:getTP()))
        assert(target:getTP() == 0, string.format('expected target TP reset, TP=%d', target:getTP()))

        joiner:setTP(1000)
        leader.actions:inviteToParty(joiner)
        joiner.actions:acceptPartyInvite()

        joiner.assert:hasEffect(xi.effect.LEVEL_SYNC)
        assert(joiner:getMainLvl() == 20, string.format('expected joiner sync to 20, level=%d', joiner:getMainLvl()))
        assert(joiner:getTP() == 0, string.format('expected joiner TP reset, TP=%d', joiner:getTP()))
    end)
end)
