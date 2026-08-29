describe('Job trait filtering', function()
    local function findMob(player, name)
        for _, mob in ipairs(player:getZone():queryEntitiesByName(name)) do
            if mob:isSpawned() then
                assert(mob:getMainJob() == xi.job.PLD, string.format('%s is not a Paladin', name))
                assert(mob:hasTrait(xi.trait.DEFENSE_BONUS), string.format('%s did not get its Paladin traits', name))

                return mob
            end
        end

        assert(false, string.format('No spawned %s found in %s', name, player:getZone():getName()))
    end

    it('does not give Resist Sleep to a crab', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.KUFTAL_TUNNEL })
        local crab   = findMob(player, 'Robber_Crab')

        assert(not crab:hasTrait(xi.trait.RESIST_SLEEP), 'Robber Crab should not have Resist Sleep')
    end)

    it('gives Resist Sleep to a beastman', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.BEADEAUX })
        local quadav = findMob(player, 'Steel_Quadav')

        assert(quadav:getEcosystem() == xi.ecosystem.BEASTMEN, 'Steel Quadav is not a beastman')
        assert(quadav:hasTrait(xi.trait.RESIST_SLEEP), 'Steel Quadav should have Resist Sleep')
    end)

    it('gives Dragon Killer to a pet Wyvern', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.BEADEAUX, job = xi.job.DRG, level = 99  })
        player:spawnPet(xi.petId.WYVERN)

        local wyvern = player:getPet()

        if wyvern then
            assert(wyvern:hasTrait(xi.trait.DRAGON_KILLER), 'Wyvern should have Dragon Killer from job')
        end
    end)

    it('gives Resist Petrify to a pet Wyvern when master has Wyrm Mail equipped', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.DRG, level = 99  })
        player:changesJob(xi.job.RDM)
        player:setsLevel(49)
        player:setMod(xi.mod.WYVERN_SUBJOB_TRAITS, 1)
        player:spawnPet(xi.petId.WYVERN)

        local wyvern = player:getPet()

        if wyvern then
            assert(wyvern:hasTrait(xi.trait.RESIST_PETRIFY), 'Wyvern should have Resist Petrify from RDM sub job')
        end
    end)

    it('gives Resist Sleep to a player', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.PLD, level = 99 })

        assert(player:hasTrait(xi.trait.RESIST_SLEEP), 'Paladin player should have Resist Sleep')
    end)

    it('gives Resist Sleep to a trust', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 99 })

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
        assert(valaineral:getMainJob() == xi.job.PLD, 'Valaineral is not a Paladin')
        assert(valaineral:hasTrait(xi.trait.RESIST_SLEEP), 'Valaineral should have Resist Sleep')
    end)
end)
