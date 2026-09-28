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

    -- Exp is handed out one member at a time, so the target can level before the rest of the party on the same kill
    it('raises a member who levels up right after the sync target', function()
        local target = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 21, zone = xi.zone.WEST_RONFAURE })
        local member = xi.test.world:spawnPlayer({ job = xi.job.SAM, level = 21, zone = xi.zone.WEST_RONFAURE })
        member:setPos(target:getXPos(), target:getYPos(), target:getZPos())

        target.actions:inviteToParty(member)
        member.actions:acceptPartyInvite()
        target.actions:setLevelSync(target)

        target:addExp(20000)
        member:addExp(20000)

        assert(target:getMainLvl() == 22, string.format('expected target to reach 22, level=%d', target:getMainLvl()))
        assert(member:getMainLvl() == 22, string.format('expected member to follow the sync to 22, level=%d', member:getMainLvl()))
    end)
end)
