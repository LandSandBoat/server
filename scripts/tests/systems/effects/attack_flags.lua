describe('Status Effect Flags', function()
    -- ATTACK flag: drops on melee/WS/mobskill/petskill emit
    describe('ATTACK flag (Boost)', function()
        ---@type CClientEntityPair
        local player

        ---@type CTestEntity
        local mob

        before_each(function()
            player = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.WEST_RONFAURE,
                job   = xi.job.MNK,
                level = 99,
            })
            player:setUnkillable(true)
            player:setMod(xi.mod.ACC, 1000)

            mob = player.entities:moveTo('Wild_Rabbit')
            mob:respawn()
            mob.assert:isAlive()
        end)

        it('drops on melee attack', function()
            player:addStatusEffect(xi.effect.BOOST, { power = 25, duration = 180, origin = player })
            player.actions:engage(mob)
            for i = 1, 5 do
                xi.test.world:tickEntity(player)
                xi.test.world:skipTime(5)
            end

            player.assert.no:hasEffect(xi.effect.BOOST)
        end)

        it('does not drop on ranged attack', function()
            player:changeJob(xi.job.RNG)
            player:setLevel(99)
            player:setMod(xi.mod.RACC, 1000)
            player:addItem(xi.item.POWER_BOW)
            player:addItem(xi.item.WOODEN_ARROW, 99)
            player:equipItem(xi.item.POWER_BOW)
            player:equipItem(xi.item.WOODEN_ARROW)
            player:addStatusEffect(xi.effect.BOOST, { power = 25, duration = 180, origin = player })
            player.actions:engage(mob)
            player.actions:rangedAttack(mob)
            xi.test.world:skipTime(10)
            player.assert:hasEffect(xi.effect.BOOST)
        end)

        it('drops on weapon skill', function()
            stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
            player:changeJob(xi.job.DNC)
            player:setLevel(99)
            player:addItem(xi.item.TERPSICHORE_99)
            player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
            player:setTP(3000)
            player:addStatusEffect(xi.effect.BOOST, { power = 25, duration = 180, origin = player })
            player.actions:engage(mob)
            player.actions:useWeaponskill(mob, xi.weaponskill.PYRRHIC_KLEOS)
            xi.test.world:skipTime(2)
            player.assert.no:hasEffect(xi.effect.BOOST)
        end)

        it('does not drop on JA on mob (Provoke)', function()
            player:changeJob(xi.job.WAR)
            player:setLevel(99)
            player:addStatusEffect(xi.effect.BOOST, { power = 25, duration = 180, origin = player })
            player.actions:useAbility(mob, xi.jobAbility.PROVOKE)
            xi.test.world:tickEntity(player)
            player.assert:hasEffect(xi.effect.BOOST)
        end)

        it('does not drop when casting spell on mob', function()
            player:changeJob(xi.job.BLM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.STONE)
            player:addStatusEffect(xi.effect.BOOST, { power = 25, duration = 180, origin = player })
            player.actions:useSpell(mob, xi.magic.spell.STONE)
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(10)
            player.assert:hasEffect(xi.effect.BOOST)
        end)
    end)

    -- ON_ATTACK flag: drops on hostile action emit and receive
    describe('ON_ATTACK flag (Mazurka)', function()
        ---@type CClientEntityPair
        local player

        ---@type CTestEntity
        local mob

        before_each(function()
            player = xi.test.world:spawnPlayer(
            {
                zone  = xi.zone.WEST_RONFAURE,
                job   = xi.job.BRD,
                level = 99,
            })
            player:setUnkillable(true)
            player:setMod(xi.mod.ACC, 1000)

            mob = player.entities:moveTo('Wild_Rabbit')
            mob:respawn()
            mob.assert:isAlive()
        end)

        describe('emitting hostile actions', function()
            it('drops on melee attack', function()
                player:changeJob(xi.job.MNK)
                player:setLevel(99)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                player.actions:engage(mob)
                for i = 1, 5 do
                    xi.test.world:tickEntity(player)
                    xi.test.world:skipTime(5)
                end

                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)

            it('drops on ranged attack', function()
                player:changeJob(xi.job.RNG)
                player:setLevel(99)
                player:setMod(xi.mod.RACC, 1000)
                player:addItem(xi.item.POWER_BOW)
                player:addItem(xi.item.WOODEN_ARROW, 99)
                player:equipItem(xi.item.POWER_BOW)
                player:equipItem(xi.item.WOODEN_ARROW)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                player.actions:engage(mob)
                player.actions:rangedAttack(mob)
                xi.test.world:skipTime(10)
                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)

            it('drops on weapon skill', function()
                stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
                player:changeJob(xi.job.DNC)
                player:setLevel(99)
                player:addItem(xi.item.TERPSICHORE_99)
                player:equipItem(xi.item.TERPSICHORE_99, nil, xi.slot.MAIN)
                player:setTP(3000)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                player.actions:engage(mob)
                player.actions:useWeaponskill(mob, xi.weaponskill.PYRRHIC_KLEOS)
                xi.test.world:skipTime(2)
                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)

            it('drops on JA on mob (Provoke)', function()
                player:changeJob(xi.job.WAR)
                player:setLevel(99)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                player.actions:useAbility(mob, xi.jobAbility.PROVOKE)
                xi.test.world:tickEntity(player)
                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)

            it('drops when casting spell on mob', function()
                player:changeJob(xi.job.BLM)
                player:setLevel(99)
                player:addSpell(xi.magic.spell.STONE)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                player.actions:useSpell(mob, xi.magic.spell.STONE)
                xi.test.world:tickEntity(player)
                xi.test.world:skipTime(10)
                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)
        end)

        describe('receiving hostile actions', function()
            it('drops on mob auto-attack', function()
                stub('xi.combat.physicalHitRate.getPhysicalHitRate', 1)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                mob:updateEnmity(player)
                for i = 1, 10 do
                    xi.test.world:tickEntity(mob)
                    xi.test.world:skipTime(5)
                end

                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)

            it('drops when mob casts spell on player', function()
                player:gotoZone(xi.zone.BEHEMOTHS_DOMINION)
                local kb = player.entities:moveTo('King_Behemoth')
                kb:spawn()
                kb.assert:isAlive()
                kb:updateClaim(player)
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                kb:castSpell(xi.magic.spell.METEOR, player)
                xi.test.world:tickEntity(kb)
                xi.test.world:skipTime(10)
                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)

            it('drops when mob uses mobskill on player', function()
                player:gotoZone(xi.zone.BEAUCEDINE_GLACIER_S)
                local ruszor = player.entities:moveTo('Ruszor')
                player:addStatusEffect(xi.effect.MAZURKA, { power = 1, duration = 240, origin = player })
                ruszor:useMobAbility(xi.mobSkill.AQUA_BLAST, player, 0)
                xi.test.world:skipTime(5)
                player.assert.no:hasEffect(xi.effect.MAZURKA)
            end)
        end)
    end)
end)
