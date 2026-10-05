describe('Stratagems', function()
    it('uses the synced level charges after level sync', function()
        local scholar = xi.test.world:spawnPlayer({ job = xi.job.SCH, level = 75 })
        local warrior = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 32 })

        scholar.actions:useAbility(scholar, xi.jobAbility.LIGHT_ARTS)
        xi.test.world:tick()

        warrior.actions:inviteToParty(scholar)
        scholar.actions:acceptPartyInvite()
        warrior.actions:setLevelSync(warrior)

        -- Level sync wears off Arts
        scholar:resetRecasts()
        scholar.packets:clear()
        scholar.actions:useAbility(scholar, xi.jobAbility.DARK_ARTS)
        xi.test.world:tick()
        scholar.assert:hasEffect(xi.effect.DARK_ARTS)

        -- Calc2 adjusts the client's charge time, a stale one crashes the client
        local calc2 = nil
        for _, packet in ipairs(scholar.packets:getIncoming()) do
            if packet.type == 0x119 then
                for slot = 0, 30 do
                    local offset = 0x04 + slot * 8
                    if packet.data[offset + 3] == xi.recastID.STRATAGEM then
                        calc2 = packet.data[offset + 4] + packet.data[offset + 5] * 256
                    end
                end
            end
        end

        assert(calc2 == 0, string.format('expected Calc2 0, got %s', tostring(calc2)))
    end)
end)
