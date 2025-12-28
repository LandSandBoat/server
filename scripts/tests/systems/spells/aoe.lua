describe('AoE', function()
    ---@type CClientEntityPair
    local p1
    ---@type CClientEntityPair
    local p2

    before_each(function()
        p1 = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.WEST_RONFAURE,
                job   = xi.job.BLM,
                level = 99,
            })
        p2 = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.WEST_RONFAURE,
                job   = xi.job.BLM,
                level = 99,
            })
        p1.actions:inviteToParty(p2)
        p2.actions:acceptPartyInvite()
    end)

    describe('base cases', function()
        it('returns base type and radius with no modifying effects', function()
        end)

        it('returns base type and radius for non-PC/non-Trust casters', function()
        end)
    end)

    describe('Majesty #pld', function()
        before_each(function()
            p1:changeJob(xi.job.PLD)
            p1:setLevel(99)
            p1:addSpell(xi.magic.spell.CURE)
            p1:addSpell(xi.magic.spell.PROTECT)
            p1:addSpell(xi.magic.spell.SHELL)
            p1.actions:useAbility(p1, xi.jobAbility.MAJESTY)
            xi.test.world:tickEntity(p1)
            p1.assert:hasEffect(xi.effect.MAJESTY)
        end)

        it('converts Cure spells to 10y AoE', function()
            p1:setHP(1)
            p2:setHP(1)
            p1.actions:useSpell(p1, xi.magic.spell.CURE)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            assert(p1:getHP() > 1, 'p1 HP should be greater than 1')
            assert(p2:getHP() > 1, 'p2 HP should be greater than 1')
        end)

        it('converts Protect spells to 10y AoE', function()
            p1.actions:useSpell(p1, xi.magic.spell.PROTECT)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert:hasEffect(xi.effect.PROTECT)
            p2.assert:hasEffect(xi.effect.PROTECT)
        end)

        it('does not affect non-Cure/Protect spells', function()
            p1.actions:useSpell(p1, xi.magic.spell.SHELL)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert:hasEffect(xi.effect.SHELL)
            p2.assert.no:hasEffect(xi.effect.SHELL)
        end)
    end)

    describe('Accession #sch', function()
        before_each(function()
            p1:changeJob(xi.job.SCH)
            p1:setLevel(99)
            p1:changesJob(xi.job.RDM)
            p1:setsLevel(49)
            p1:addSpell(xi.magic.spell.PROTECT)
            p1:addSpell(xi.magic.spell.HASTE)
            p1.actions:useAbility(p1, xi.jobAbility.LIGHT_ARTS)
            xi.test.world:tickEntity(p1)
            p1.actions:useAbility(p1, xi.jobAbility.ACCESSION)
            xi.test.world:tickEntity(p1)
            p1.assert:hasEffect(xi.effect.ACCESSION)
        end)

        it('converts RADIAL_ACCE spells to 10y AoE', function()
            p1.actions:useSpell(p1, xi.magic.spell.PROTECT)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert:hasEffect(xi.effect.PROTECT)
            p2.assert:hasEffect(xi.effect.PROTECT)
        end)

        it('does not affect spells without RADIAL_ACCE type', function()
            p1.actions:useSpell(p1, xi.magic.spell.HASTE)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert:hasEffect(xi.effect.HASTE)
            p2.assert.no:hasEffect(xi.effect.HASTE)
        end)
    end)

    describe('Divine Veil #whm', function()
        before_each(function()
            p1:changeJob(xi.job.WHM)
            p1:setLevel(99)
            p1:addSpell(xi.magic.spell.ERASE)
            p1:addSpell(xi.magic.spell.PARALYNA)
            p1:addSpell(xi.magic.spell.PROTECT)
        end)

        it('converts -na spells to 10y AoE with Divine Seal', function()
            p2:addStatusEffect(xi.effect.PARALYSIS, 1, 0, 60)
            p2.assert:hasEffect(xi.effect.PARALYSIS)
            p1.actions:useAbility(p1, xi.jobAbility.DIVINE_SEAL)
            xi.test.world:tickEntity(p1)
            p1.actions:useSpell(p1, xi.magic.spell.PARALYNA)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p2.assert.no:hasEffect(xi.effect.PARALYSIS)
        end)

        it('converts -na spells to 10y AoE with AOE_NA mod chance', function()
            p2:addStatusEffect(xi.effect.PARALYSIS, 1, 0, 60)
            p2.assert:hasEffect(xi.effect.PARALYSIS)
            p1:addItem(xi.item.YAGRUSH_75)
            p1:equipItem(xi.item.YAGRUSH_75, nil, xi.slot.MAIN)
            p1.actions:useSpell(p1, xi.magic.spell.PARALYNA)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p2.assert.no:hasEffect(xi.effect.PARALYSIS)
        end)

        it('converts Erase to 10y AoE with Divine Seal', function()
            p1:addStatusEffect(xi.effect.SLOW, 1, 0, 60)
            p2:addStatusEffect(xi.effect.SLOW, 1, 0, 60)
            p1.assert:hasEffect(xi.effect.SLOW)
            p2.assert:hasEffect(xi.effect.SLOW)
            p1.actions:useAbility(p1, xi.jobAbility.DIVINE_SEAL)
            xi.test.world:tickEntity(p1)
            p1.actions:useSpell(p1, xi.magic.spell.ERASE)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert.no:hasEffect(xi.effect.SLOW)
            p2.assert.no:hasEffect(xi.effect.SLOW)
        end)

        it('does not convert without Divine Veil trait', function()
            p1:setLevel(49)
            p2:addStatusEffect(xi.effect.PARALYSIS, 1, 0, 60)
            p2.assert:hasEffect(xi.effect.PARALYSIS)
            p1.actions:useAbility(p1, xi.jobAbility.DIVINE_SEAL)
            xi.test.world:tickEntity(p1)
            p1.actions:useSpell(p1, xi.magic.spell.PARALYNA)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p2.assert:hasEffect(xi.effect.PARALYSIS)
        end)

        it('does not convert without Divine Seal or AOE_NA mod', function()
            p2:addStatusEffect(xi.effect.PARALYSIS, 1, 0, 60)
            p2.assert:hasEffect(xi.effect.PARALYSIS)
            p1.actions:useSpell(p1, xi.magic.spell.PARALYNA)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p2.assert:hasEffect(xi.effect.PARALYSIS)
        end)
    end)

    describe('Manifestation #sch', function()
        before_each(function()
            p1:changeJob(xi.job.SCH)
            p1:setLevel(99)
        end)

        it('converts RADIAL_MANI spells to 10y AoE', function()
            p1:addStatusEffect(xi.effect.MANIFESTATION, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.SLEEP)
            assert(spell, 'SLEEP spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[1] == xi.magic.aoe.RADIAL, 'Expected RADIAL type')
            assert(result[2] == 10, 'Expected radius 10')
        end)

        it('does not affect spells without RADIAL_MANI type', function()
            p1:addStatusEffect(xi.effect.MANIFESTATION, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.STONE)
            assert(spell, 'STONE spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[1] ~= xi.magic.aoe.RADIAL or result[2] ~= 10,
                'Should not convert to 10y AoE')
        end)
    end)

    describe('Theurgic Focus #geo', function()
        before_each(function()
            p1:changeJob(xi.job.GEO)
            p1:setLevel(99)
        end)

        it('halves the radius of -ra spells (Fira to Watera)', function()
            p1:addStatusEffect(xi.effect.THEURGIC_FOCUS, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.FIRA)
            assert(spell, 'FIRA spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[1] == xi.magic.aoe.RADIAL, 'Expected RADIAL type')
            assert(result[2] == 5, 'Expected radius 5y')
        end)

        it('does not affect non -ra spells', function()
            p1:addStatusEffect(xi.effect.THEURGIC_FOCUS, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.FIRE)
            assert(spell, 'FIRE spell not found')
            local baseRadius = spell:getRadius()
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[2] == baseRadius, 'Radius should remain unchanged')
        end)
    end)

    describe('Diffusion #blu', function()
        before_each(function()
            p1:changeJob(xi.job.BLU)
            p1:setLevel(99)
        end)

        it('converts DIFFUSION type BLU spells to 10y AoE', function()
            p1:addStatusEffect(xi.effect.DIFFUSION, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.METALLIC_BODY)
            assert(spell, 'METALLIC_BODY spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[1] == xi.magic.aoe.RADIAL, 'Expected RADIAL type')
            assert(result[2] == 10, 'Expected radius 10')
        end)

        it('does not affect spells without DIFFUSION type', function()
            p1:addStatusEffect(xi.effect.DIFFUSION, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.POLLEN)
            assert(spell, 'POLLEN spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[1] ~= xi.magic.aoe.RADIAL or result[2] ~= 10,
                'Should not convert to 10y AoE')
        end)
    end)

    describe('Convergence #blu', function()
        before_each(function()
            p1:changeJob(xi.job.BLU)
            p1:setLevel(99)
        end)

        it('forces offensive BLU magic spells to single target', function()
            p1:addStatusEffect(xi.effect.CONVERGENCE, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.MAELSTROM)
            assert(spell, 'MAELSTROM spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            assert(result[1] == xi.magic.aoe.NONE, 'Expected NONE type (single target)')
            assert(result[2] == 0, 'Expected radius 0')
        end)

        it('does not affect physical BLU spells (ELEMENT_NONE)', function()
            p1:addStatusEffect(xi.effect.CONVERGENCE, 1, 0, 60)
            local spell = GetSpell(xi.magic.spell.WHIRL_OF_RAGE)
            assert(spell, 'WHIRL_OF_RAGE spell not found')
            local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
            -- Physical BLU spells should retain their AoE
            assert(result[1] ~= xi.magic.aoe.NONE, 'Physical AoE spells should not be forced to single target')
        end)
    end)

    describe('Utsusemi AoE #nin', function()
        before_each(function()
            p1:changeJob(xi.job.NIN)
            p1:setLevel(99)
            p1:addSpell(xi.magic.spell.UTSUSEMI_NI)
            p1:addItem(xi.item.SHIHEI, 99)
            p1:setMod(xi.mod.UTSUSEMI_AOE, 1)
        end)

        it('converts Utsusemi spells to 10y AoE with UTSUSEMI_AOE mod', function()
            p1.actions:useSpell(p1, xi.magic.spell.UTSUSEMI_NI)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert:hasEffect(xi.effect.COPY_IMAGE)
            p2.assert:hasEffect(xi.effect.COPY_IMAGE)
        end)

        it('does not affect Utsusemi without the mod', function()
            p1:setMod(xi.mod.UTSUSEMI_AOE, 0)
            p1.actions:useSpell(p1, xi.magic.spell.UTSUSEMI_NI)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p1.assert:hasEffect(xi.effect.COPY_IMAGE)
            p2.assert.no:hasEffect(xi.effect.COPY_IMAGE)
        end)
    end)

    describe('Songs #brd', function()
        before_each(function()
            p1:changeJob(xi.job.BRD)
            p1:setLevel(99)
            p1:addItem(xi.item.GJALLARHORN_99)
            p1:addSpell(xi.magic.spell.MAGES_BALLAD)
        end)

        it('forces single target with Pianissimo effect and removes it after use', function()
            p1.actions:useAbility(p1, xi.jobAbility.PIANISSIMO)
            xi.test.world:tickEntity(p1)
            p1.assert:hasEffect(xi.effect.PIANISSIMO)
            p1.actions:useSpell(p2, xi.magic.spell.MAGES_BALLAD)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(5)
            p2.assert:hasEffect(xi.effect.BALLAD)
            p1.assert.no:hasEffect(xi.effect.BALLAD)
            p1.assert.no:hasEffect(xi.effect.PIANISSIMO)
        end)

        it('returns base radius without String instrument equipped', function()
            p1:setSkillLevel(xi.skill.STRING_INSTRUMENT, 424)
            local s = spy('xi.combat.magicAoE.calculateTypeAndRadius')
            p1.actions:useSpell(p1, xi.magic.spell.MAGES_BALLAD)
            xi.test.world:tickEntity(p1)
            xi.test.world:skipTime(10)
            s:called(1)
            assert(s.calls[1].returned[1] == xi.magic.aoe.RADIAL, 'Expected RADIAL aoe type')
            assert(s.calls[1].returned[2] == 10, 'Expected base radius of 10')
        end)

        it('scales radius from 1.0x to 2.0x based on String skill vs song level cap', function()
            p1:addItem(xi.item.MAPLE_HARP)
            p1:equipItem(xi.item.MAPLE_HARP, nil, xi.slot.RANGED)
            local spell = GetSpell(xi.magic.spell.MAGES_BALLAD)
            assert(spell)
            local testCases =
            {
                { skill = 0,   expectedRadius = 10 },
                { skill = 79,  expectedRadius = 10 },
                { skill = 80,  expectedRadius = 11 },
                { skill = 86,  expectedRadius = 11 },
                { skill = 87,  expectedRadius = 12 },
                { skill = 93,  expectedRadius = 12 },
                { skill = 94,  expectedRadius = 13 },
                { skill = 100, expectedRadius = 13 },
                { skill = 101, expectedRadius = 14 },
                { skill = 107, expectedRadius = 14 },
                { skill = 108, expectedRadius = 15 },
                { skill = 115, expectedRadius = 15 },
                { skill = 116, expectedRadius = 16 },
                { skill = 122, expectedRadius = 16 },
                { skill = 123, expectedRadius = 17 },
                { skill = 129, expectedRadius = 17 },
                { skill = 130, expectedRadius = 18 },
                { skill = 136, expectedRadius = 18 },
                { skill = 137, expectedRadius = 19 },
                { skill = 143, expectedRadius = 19 },
                { skill = 144, expectedRadius = 20 },
                { skill = 424, expectedRadius = 20 },
            }

            for _, tc in ipairs(testCases) do
                p1:setSkillLevel(xi.skill.STRING_INSTRUMENT, tc.skill * 10)
                local result = xi.combat.magicAoE.calculateTypeAndRadius(p1, spell)
                assert(result[1] == xi.magic.aoe.RADIAL,
                    string.format('Skill %d: Expected RADIAL type', tc.skill))
                assert(result[2] == tc.expectedRadius,
                    string.format('Skill %d: Expected radius %d, got %s', tc.skill, tc.expectedRadius, tostring(result[2])))
            end
        end)
    end)
end)
