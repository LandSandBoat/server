describe('AoE Vertical Range', function()
    describe('player-centered', function()
        ---@type CClientEntityPair
        local p1, p2

        before_each(function()
            local pConfig =
            {
                zone  = xi.zone.GM_HOME,
                job   = xi.job.WHM,
                level = 99,
            }

            p1 = xi.test.world:spawnPlayer(pConfig)
            p2 = xi.test.world:spawnPlayer(pConfig)
            p1.actions:inviteToParty(p2)
            p2.actions:acceptPartyInvite()

            p1:addSpell(xi.magic.spell.BARSTONRA)
        end)

        it('Barstonra hits party member at 7.999y above', function()
            p2:setPos(p1:getXPos(), p1:getYPos() - 7.999, p1:getZPos())
            p1.actions:useSpell(p1, xi.magic.spell.BARSTONRA)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(10)
            p2.assert:hasEffect(xi.effect.BARSTONE)
        end)

        it('Barstonra misses party member at 8y above', function()
            p2:setPos(p1:getXPos(), p1:getYPos() - 8.0, p1:getZPos())
            p1.actions:useSpell(p1, xi.magic.spell.BARSTONRA)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(10)
            p2.assert.no:hasEffect(xi.effect.BARSTONE)
        end)
    end)

    describe('mob self-centered', function()
        ---@type CClientEntityPair
        local p1, p2

        ---@type CTestEntity
        local fafnir

        before_each(function()
            local pConfig =
            {
                zone  = xi.zone.DRAGONS_AERY,
                job   = xi.job.DRG,
                level = 1,
            }

            p1 = xi.test.world:spawnPlayer(pConfig)
            p1:setUnkillable(true)

            p2 = xi.test.world:spawnPlayer(pConfig)
            p2:setUnkillable(true)

            p1.actions:inviteToParty(p2)
            p2.actions:acceptPartyInvite()

            p1.entities:moveTo('Fafnir')
            fafnir = p2.entities:moveTo('Fafnir')
            fafnir:spawn()
            fafnir.assert:isAlive()
            fafnir:updateClaim(p1)
        end)

        it('Hurricane Wing hits at 8.499y above', function()
            p1:setPos(fafnir:getXPos(), fafnir:getYPos() - 8.499, fafnir:getZPos())
            fafnir:setTP(3000)
            fafnir:useMobAbility(xi.mobSkill.HURRICANE_WING_1, p1)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)

            assert(p1:getHPP() ~= 100, 'P1 was not hit by Hurricane Wing')
        end)

        it('Hurricane Wing misses at 8.5y above', function()
            p1:setPos(fafnir:getXPos(), fafnir:getYPos() - 8.5, fafnir:getZPos())
            fafnir:setTP(3000)
            fafnir:useMobAbility(xi.mobSkill.HURRICANE_WING_1, p1)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)

            assert(p1:getHPP() == 100, 'P1 was hit by Hurricane Wing')
        end)

        -- Spike Flail is centered on the targeted player, not the mob
        it('Spike Flail hits party member at 7.999y above target', function()
            local m = stub('xi.mobskills.mobPhysicalMove',
                {
                    damage     = 100,
                    hitsLanded = 3,
                    isCritical = false,
                })

            p2:setPos(p1:getXPos(), p1:getYPos() - 7.999, p1:getZPos())
            fafnir:setTP(3000)
            fafnir:useMobAbility(xi.mobSkill.SPIKE_FLAIL_1, p1)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)

            m:called()
            assert(p2:getHPP() ~= 100, 'P2 was not hit by Spike Flail')
        end)

        it('Spike Flail misses party member at 8y above target', function()
            stub('xi.mobskills.mobPhysicalMove',
                {
                    damage     = 100,
                    hitsLanded = 3,
                    isCritical = false,
                })

            p2:setPos(p1:getXPos(), p1:getYPos() - 8.0, p1:getZPos())
            fafnir:setTP(3000)
            fafnir:useMobAbility(xi.mobSkill.SPIKE_FLAIL_1, p1)
            xi.test.world:skipTime(5)
            xi.test.world:skipTime(5)

            assert(p2:getHPP() == 100, 'P2 was hit by Spike Flail')
        end)
    end)
end)
