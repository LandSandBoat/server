local ffi = require('ffi')

describe('Bard song abilities', function()
    ---@type CClientEntityPair
    local bard
    ---@type CClientEntityPair
    local ally

    -- Merits can only be raised from the player's own Mog House.
    local function raiseMerit(player, merit, ranks)
        player:setNation(xi.nation.BASTOK)
        player:gotoMogHouse(xi.zone.BASTOK_MINES)
        if player:isInEvent() then
            player.events:finish()
        end

        for _ = 1, ranks do
            player:setMerits(5)

            local packet = ffi.new('uint8_t[12]')
            packet[4] = 3 -- Edit mode
            packet[5] = 1 -- Raise
            packet[6] = bit.band(bit.rshift(merit, 1), 0xFF)
            packet[7] = bit.rshift(merit, 9)
            player.packets:send(0x0BE, packet, ffi.sizeof(packet))
        end

        player:gotoZone(xi.zone.GM_HOME)
        if player:isInEvent() then
            player.events:finish()
        end
    end

    local function useAbility(abilityId)
        bard.actions:useAbility(bard, abilityId)
        xi.test.world:tickEntity(bard)
    end

    local function castBallad(target)
        bard.actions:useSpell(target, xi.magic.spell.MAGES_BALLAD)
        xi.test.world:tickEntity(bard)
    end

    before_each(function()
        bard = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.GM_HOME,
                job   = xi.job.BRD,
                level = 75,
            })
        bard:addSpell(xi.magic.spell.MAGES_BALLAD)
    end)

    describe('Nightingale', function()
        it('grants no instant cast chance with one merit', function()
            raiseMerit(bard, xi.merit.NIGHTINGALE, 1)
            useAbility(xi.jobAbility.NIGHTINGALE)

            bard.assert:hasEffect(xi.effect.NIGHTINGALE)
            assert(bard:getStatusEffect(xi.effect.NIGHTINGALE):getPower() == 0, 'expected 0% instant cast chance')
        end)

        it('adds 25% instant cast chance per merit past the first', function()
            raiseMerit(bard, xi.merit.NIGHTINGALE, 5)
            useAbility(xi.jobAbility.NIGHTINGALE)

            bard.assert:hasEffect(xi.effect.NIGHTINGALE)
            assert(bard:getStatusEffect(xi.effect.NIGHTINGALE):getPower() == 100, 'expected 100% instant cast chance')
        end)

        it('casts songs instantly at 100% chance', function()
            bard:addStatusEffect(xi.effect.NIGHTINGALE, { power = 100, duration = 60, origin = bard })

            castBallad(bard)
            xi.test.world:skipTime(1)
            bard.assert:hasEffect(xi.effect.BALLAD)
        end)

        -- Mage's Ballad is an 8 second cast.
        it('halves song cast time when the instant cast does not proc', function()
            bard:addStatusEffect(xi.effect.NIGHTINGALE, { power = 0, duration = 60, origin = bard })

            castBallad(bard)
            xi.test.world:skipTime(3)
            bard.assert.no:hasEffect(xi.effect.BALLAD)

            xi.test.world:skipTime(2)
            bard.assert:hasEffect(xi.effect.BALLAD)
        end)
    end)

    describe('Troubadour', function()
        -- Smallest bonus magic accuracy at which a song lands unresisted.
        local function requiredBonusMacc()
            for bonusMacc = 0, 2000 do
                local resist = xi.combat.magicHitRate.calculateResistRate(bard, ally,
                    {
                        magicalElement = xi.element.LIGHT,
                        skillType      = xi.skill.SINGING,
                        bonusMacc      = bonusMacc,
                    })

                if resist == 1 then
                    return bonusMacc
                end
            end

            error('song never landed unresisted')
        end

        before_each(function()
            ally = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
            ally:setMod(xi.mod.MEVA, 1000)

            -- A resist roll of 0.5 fails exactly when magic hit rate is under 50%.
            stub('math.randomFloat', 0.5)
        end)

        it('grants no song accuracy with one merit', function()
            raiseMerit(bard, xi.merit.TROUBADOUR, 1)
            useAbility(xi.jobAbility.TROUBADOUR)

            bard.assert:hasEffect(xi.effect.TROUBADOUR)
            assert(bard:getStatusEffect(xi.effect.TROUBADOUR):getPower() == 0, 'expected no song accuracy')
        end)

        it('adds 64 song accuracy per merit past the first', function()
            raiseMerit(bard, xi.merit.TROUBADOUR, 5)
            useAbility(xi.jobAbility.TROUBADOUR)

            bard.assert:hasEffect(xi.effect.TROUBADOUR)
            assert(bard:getStatusEffect(xi.effect.TROUBADOUR):getPower() == 256, 'expected 256 song accuracy')
        end)

        it('adds its power to song magic accuracy', function()
            local baseline = requiredBonusMacc()

            bard:addStatusEffect(xi.effect.TROUBADOUR, { power = 256, duration = 60, origin = bard })
            local withTroubadour = requiredBonusMacc()

            assert(baseline - withTroubadour == 256,
                string.format('expected 256 song accuracy, got %d', baseline - withTroubadour))
        end)

        it('adds no song magic accuracy at zero power', function()
            local baseline = requiredBonusMacc()

            bard:addStatusEffect(xi.effect.TROUBADOUR, { power = 0, duration = 60, origin = bard })

            assert(requiredBonusMacc() == baseline, 'expected song accuracy to be unchanged')
        end)
    end)

    describe('Pianissimo', function()
        before_each(function()
            ally = xi.test.world:spawnPlayer({ zone = xi.zone.GM_HOME })
            bard.actions:inviteToParty(ally)
            ally.actions:acceptPartyInvite()
        end)

        it('halves song cast time', function()
            useAbility(xi.jobAbility.PIANISSIMO)

            bard.assert:hasEffect(xi.effect.PIANISSIMO)
            assert(bard:getStatusEffect(xi.effect.PIANISSIMO):getPower() == 50, 'expected 50% cast time reduction')

            castBallad(ally)
            xi.test.world:skipTime(3)
            ally.assert.no:hasEffect(xi.effect.BALLAD)

            xi.test.world:skipTime(2)
            ally.assert:hasEffect(xi.effect.BALLAD)
        end)

        it('leaves song cast time unchanged at zero power', function()
            bard:addStatusEffect(xi.effect.PIANISSIMO, { power = 0, duration = 60, origin = bard })

            castBallad(ally)
            xi.test.world:skipTime(5)
            ally.assert.no:hasEffect(xi.effect.BALLAD)

            xi.test.world:skipTime(4)
            ally.assert:hasEffect(xi.effect.BALLAD)
        end)
    end)
end)
