describe('Job traits', function()
    it('grants a rank at its level', function()
        local below = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 29 })
        local at    = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 30 })

        assert(not below:hasTrait(xi.trait.ATTACK_BONUS), 'Warrior 29 should not have Attack Bonus')
        assert(at:hasTrait(xi.trait.ATTACK_BONUS), 'Warrior 30 should have Attack Bonus')
    end)

    it('grants a support job trait at the support job level', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.WAR, level = 30 })
        player:changesJob(xi.job.THF)
        player:setsLevel(15)

        assert(player:hasTrait(xi.trait.TREASURE_HUNTER), 'WAR/THF15 should have Treasure Hunter')
    end)

    it('grants a rank that has no lower ranks', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.THF, level = 45 })

        assert(player:hasTrait(xi.trait.TREASURE_HUNTER_II), 'Thief 45 should have Treasure Hunter II')
    end)

    it('applies the highest rank', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.DNC, level = 99 })

        assert(player:getMod(xi.mod.SKILLCHAINBONUS) == 23, string.format('Dancer 99 Skillchain Bonus is %d, expected 23', player:getMod(xi.mod.SKILLCHAINBONUS)))
    end)

    it('withholds a merit trait until the merit is upgraded', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.MNK, level = 99 })

        assert(not player:hasTrait(xi.trait.INVIGORATE), 'Monk without the merit should not have Invigorate')
    end)

    it('grants a blue magic trait from set spells', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, job = xi.job.BLU, level = 75 })

        assert(not player:hasTrait(xi.trait.BEAST_KILLER), 'Blue Mage without set spells should not have Beast Killer')

        player:addSpell(xi.magic.spell.SPROUT_SMACK)
        player:addSpell(xi.magic.spell.WILD_OATS)
        player.actions:setBlueSpells({ xi.magic.spell.SPROUT_SMACK, xi.magic.spell.WILD_OATS })

        assert(player:hasTrait(xi.trait.BEAST_KILLER), 'Blue Mage with Sprout Smack and Wild Oats set should have Beast Killer')
        assert(player:getMod(xi.mod.BEAST_KILLER) == 8, string.format('Beast Killer is %d, expected 8', player:getMod(xi.mod.BEAST_KILLER)))
    end)
end)
