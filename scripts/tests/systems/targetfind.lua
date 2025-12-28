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

        -- move wyverns to their masters
        wyv1:setPos(p1:getPos())
        wyv2:setPos(p2:getPos())
        wyv3:setPos(p3:getPos())

        -- Use Spike Flail
        fafnir:setTP(3000)
        fafnir:useMobAbility(952, p1)
        -- Give some time for the AI to progress through Prepare and Complete
        xi.test.world:skipTime(5)
        xi.test.world:skipTime(5)

        -- P1 and P2 should get hit. P3 should not.
        m:called()
        assert(p1:getHPP() ~= 100, 'P1 was not hit by Spike Flail')
        assert(p2:getHPP() ~= 100, 'P2 was not hit by Spike Flail')
        assert(p3:getHPP() == 100, 'P3 was hit by Spike Flail')

        -- Same for their wyverns!
        assert(wyv1:getHPP() ~= 100, 'P1 Wyvern was not hit by Spike Flail')
        assert(wyv2:getHPP() ~= 100, 'P2 Wyvern was not hit by Spike Flail')
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

        -- move wyverns to their masters
        wyv1:setPos(p1:getPos())
        wyv2:setPos(p2:getPos())
        wyv3:setPos(p3:getPos())

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
        m:called()
        assert(p1:getHPP() ~= 100, 'P1 was not hit by Spike Flail')
        assert(p2:getHPP() ~= 100, 'P2 was not hit by Spike Flail')
        assert(p3:getHPP() ~= 100, 'P3 was not hit by Spike Flail')

        -- Same for their wyverns!
        assert(wyv1:getHPP() ~= 100, 'P1 Wyvern was not hit by Spike Flail')
        assert(wyv2:getHPP() ~= 100, 'P2 Wyvern was not hit by Spike Flail')
        assert(wyv3:getHPP() ~= 100, 'P3 Wyvern was not hit by Spike Flail')
    end)

    it('King Behemoth Meteor hits everyone (MOBMOD_AOE_HIT_ALL)', function()
        ---@type CClientEntityPair
        local charA, charB

        -- Spawn two chars in Behemoth's Dominion
        local pConfig =
        {
            zone  = xi.zone.BEHEMOTHS_DOMINION,
            job   = xi.job.WAR,
            level = 75,
        }

        charA = xi.test.world:spawnPlayer(pConfig)
        charA:setUnkillable(true)

        charB = xi.test.world:spawnPlayer(pConfig)
        charB:setUnkillable(true)

        -- Move both players to King Behemoth
        charA.entities:moveTo('King_Behemoth')
        local kb = charB.entities:moveTo('King_Behemoth')

        -- Spawn King Behemoth and claim it with charA only
        kb:spawn()
        kb.assert:isAlive()
        kb:updateClaim(charA)

        -- Make King Behemoth cast Meteor on charA and assert both got hit
        kb:castSpell(xi.magic.spell.METEOR, charA)
        xi.test.world:tickEntity(kb)
        xi.test.world:skipTime(10)

        assert(charA:getHPP() ~= 100, 'CharA was not hit by Meteor')
        assert(charB:getHPP() ~= 100, 'CharB was not hit by Meteor')
    end)

    it('Qultada trust Corsair Roll affects master and party', function()
        local pConfig =
        {
            zone  = xi.zone.WEST_RONFAURE,
            job   = xi.job.SMN,
            level = 99,
        }

        local player = xi.test.world:spawnPlayer(pConfig)
        player:setGMLevel(3)
        player:setVisibleGMLevel(3)
        player:spawnPet(xi.petId.TITAN)
        local titan = player:getPet()
        assert(titan, 'Titan was not summoned')

        local partyMember = xi.test.world:spawnPlayer(pConfig)
        partyMember:setPos(player:getXPos(), player:getYPos(), player:getZPos())
        player.actions:inviteToParty(partyMember)
        partyMember.actions:acceptPartyInvite()

        local stranger = xi.test.world:spawnPlayer(pConfig)
        stranger:setPos(player:getXPos(), player:getYPos(), player:getZPos())

        player:addSpell(xi.magic.spell.QULTADA)
        player.actions:useSpell(player, xi.magic.spell.QULTADA)
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(10)

        local qultada = nil
        for _, member in ipairs(player:getPartyWithTrusts()) do
            if member:getName() == 'qultada' then
                qultada = member
                break
            end
        end

        assert(qultada, 'Qultada was not summoned')

        qultada:useJobAbility(xi.ja.CORSAIRS_ROLL, qultada)
        xi.test.world:tickEntity(qultada)
        xi.test.world:skipTime(5)

        assert(qultada:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Qultada does not have Corsair Roll')
        assert(player:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Player does not have Corsair Roll')
        assert(partyMember:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Party member does not have Corsair Roll')
        assert(not stranger:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Stranger incorrectly has Corsair Roll')
        assert(not titan:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Titan incorrectly has Corsair Roll')
    end)

    it('Player Corsair Roll affects self and party', function()
        local pConfig =
        {
            zone  = xi.zone.WEST_RONFAURE,
            job   = xi.job.COR,
            sjob  = xi.job.SMN,
            level = 99,
        }

        local player = xi.test.world:spawnPlayer(pConfig)
        player:addLearnedAbility(xi.ja.CORSAIRS_ROLL)
        player:spawnPet(xi.petId.CARBUNCLE)
        local carby = player:getPet()
        assert(carby, 'Carbuncle was not summoned')

        local partyMember = xi.test.world:spawnPlayer(pConfig)
        partyMember:setPos(player:getXPos(), player:getYPos(), player:getZPos())
        player.actions:inviteToParty(partyMember)
        partyMember.actions:acceptPartyInvite()

        local stranger = xi.test.world:spawnPlayer(pConfig)
        stranger:setPos(player:getXPos(), player:getYPos(), player:getZPos())

        player.actions:useAbility(player, xi.ja.CORSAIRS_ROLL)
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(5)

        assert(player:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Player does not have Corsair Roll')
        assert(partyMember:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Party member does not have Corsair Roll')
        assert(not stranger:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Stranger incorrectly has Corsair Roll')
        assert(not carby:hasStatusEffect(xi.effect.CORSAIRS_ROLL), 'Carbuncle incorrectly has Corsair Roll')
    end)

    it('Valaineral trust Majesty + Cure III heals party', function()
        local pConfig =
        {
            zone  = xi.zone.WEST_RONFAURE,
            job   = xi.job.WAR,
            level = 99,
        }

        local player = xi.test.world:spawnPlayer(pConfig)
        player:setGMLevel(3)
        player:setVisibleGMLevel(3)

        local stranger = xi.test.world:spawnPlayer(pConfig)

        player:addSpell(xi.magic.spell.VALAINERAL)
        player.actions:useSpell(player, xi.magic.spell.VALAINERAL)
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(10)

        local valaineral = nil
        for _, member in ipairs(player:getPartyWithTrusts()) do
            if member:getName() == 'valaineral' then
                valaineral = member
                break
            end
        end

        assert(valaineral, 'Valaineral was not summoned')

        player:setHP(1)
        stranger:setHP(1)
        stranger:setPos(player:getXPos(), player:getYPos(), player:getZPos())

        valaineral:useJobAbility(xi.ja.MAJESTY, valaineral)
        xi.test.world:tickEntity(valaineral)
        xi.test.world:skipTime(3)

        valaineral:castSpell(xi.magic.spell.CURE_III, valaineral)
        xi.test.world:tickEntity(valaineral)
        xi.test.world:skipTime(10)

        assert(player:getHP() > 1, 'Player was not healed by Valaineral Cure III')
        assert(stranger:getHP() == 1, 'Stranger was incorrectly healed by Valaineral Cure III')
    end)
end)
