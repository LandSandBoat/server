describe('TargetFind', function()
    ---@type CClientEntityPair
    local p1, p2, p3
    local wyv1, wyv2, wyv3

    before_each(function()
        -- Spawn everyone in Dragon's Aery as DRG
        local pConfig =
        {
            zone  = xi.zone.DRAGONS_AERY,
            job   = xi.job.DRG,
            level = 1,
        }

        p1 = xi.test.world:spawnPlayer(pConfig)
        p1:setUnkillable(true)
        p1.actions:useAbility(p1, xi.jobAbility.CALL_WYVERN)
        xi.test.world:tickEntity(p1)
        wyv1 = p1:getPet()

        p2 = xi.test.world:spawnPlayer(pConfig)
        p2:setUnkillable(true)
        p2.actions:useAbility(p2, xi.jobAbility.CALL_WYVERN)
        xi.test.world:tickEntity(p2)
        wyv2 = p2:getPet()

        p3 = xi.test.world:spawnPlayer(pConfig)
        p3:setUnkillable(true)
        p3.actions:useAbility(p3, xi.jobAbility.CALL_WYVERN)
        xi.test.world:tickEntity(p3)
        wyv3 = p3:getPet()

        assert(wyv1, 'P1 did not get a Wyvern')
        assert(wyv2, 'P2 did not get a Wyvern')
        assert(wyv3, 'P3 did not get a Wyvern')

        -- P1 and P2 are partied, P3 is solo
        p1.actions:inviteToParty(p2)
        p2.actions:acceptPartyInvite()
    end)

    it('Fafnir Spike Flail only hit claiming party', function()
        -- Force Flail to always hit
        local m = stub('xi.mobskills.mobPhysicalMove',
            {
                dmg        = 100,
                hitslanded = 3,
                isCritical = false,
            })
        -- All of them should go to Fafnir
        p1.entities:moveTo('Fafnir')
        p2.entities:moveTo('Fafnir')
        local fafnir = p3.entities:moveTo('Fafnir')

        -- Spawn Fafnir and claim it to the party
        fafnir:spawn()
        fafnir.assert:isAlive()
        fafnir:updateClaim(p1)

        -- Use Spike Flail
        fafnir:setTP(3000)
        fafnir:useMobAbility(952, p1)
        -- Give some time for the AI to progress through Prepare and Complete
        xi.test.world:skipTime(5)
        xi.test.world:skipTime(5)

        -- P1 and P2 should get hit. P3 should not.
        assert(p1:getHPP() ~= 100, 'P1 was not hit by Spike Flail')
        assert(p2:getHPP() ~= 100, 'P2 was not hit by Spike Flail')
        assert(p3:getHPP() == 100, 'P3 was hit by Spike Flail')

        -- Same for their wyverns!
        assert(wyv1:getHPP() ~= 100, 'P1 Wyvern was not hit by Spike Flail')
        assert(wyv2:getHPP() ~= 100, 'P1 Wyvern was not hit by Spike Flail')
        assert(wyv3:getHPP() == 100, 'P3 Wyvern was hit by Spike Flail')
    end)

    it('Nidhogg Spike Flail hits everyone', function()
        -- Force Flail to always hit
        local m = stub('xi.mobskills.mobPhysicalMove',
            {
                dmg        = 100,
                hitslanded = 3,
                isCritical = false,
            })

        -- All players should go to Nidhogg
        p1.entities:moveTo('Nidhogg')
        p2.entities:moveTo('Nidhogg')
        local nidhogg = p3.entities:moveTo('Nidhogg')

        -- Spawn Nidhogg and claim it to the party
        nidhogg:spawn()
        nidhogg.assert:isAlive()
        nidhogg:updateClaim(p1)
        nidhogg:setTP(3000)
        nidhogg:useMobAbility(1040, p1)
        -- Give some time for the AI to progress through Prepare and Complete
        xi.test.world:skipTime(5)
        xi.test.world:skipTime(5)

        -- P1, P2 and P3 should get hit.
        assert(p1:getHPP() ~= 100, 'P1 was not hit by Spike Flail')
        assert(p2:getHPP() ~= 100, 'P2 was not hit by Spike Flail')
        assert(p3:getHPP() ~= 100, 'P3 was not hit by Spike Flail')

        -- Same for their wyverns!
        assert(wyv1:getHPP() ~= 100, 'P1 Wyvern was not hit by Spike Flail')
        assert(wyv2:getHPP() ~= 100, 'P1 Wyvern was not hit by Spike Flail')
        assert(wyv3:getHPP() ~= 100, 'P3 Wyvern was not hit by Spike Flail')
    end)
end)
