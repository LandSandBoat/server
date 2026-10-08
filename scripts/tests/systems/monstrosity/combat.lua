-- Monipulator melee, kill exp, levelling and level unlocks.

describe('Monstrosity combat', function()
    ---@type CClientEntityPair
    local player

    local function becomeSpecies(family, level)
        local data = player:getMonstrosityData()
        data.monstrosityId  = family
        data.species        = family
        data.levels[family] = level
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:delStatusEffect(xi.effect.GESTATION)
    end

    local function currentExp()
        local exp = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x061 then
                exp = pkt.data[0x10] + pkt.data[0x11] * 256
            end
        end

        return exp
    end

    -- Tunnel Worms count two levels lower for exp.
    local function killWorm(mobLevel)
        local gained = 0
        player:addListener('EXPERIENCE_POINTS', 'TEST_MON_KILL_EXP', function(_, _, exp)
            gained = gained + exp
        end)

        local mob = player.entities:moveTo('Tunnel_Worm')
        mob:respawn()
        mob:setMobLevel(mobLevel)
        mob:setMod(xi.mod.EXP_LVL_MOD, -2)
        mob:updateClaim(player)
        mob:takeDamage(mob:getHP(), player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        for _ = 1, 3 do
            xi.test.world:tickEntity(mob)
            xi.test.world:skipTime(1)
        end

        player:removeListener('TEST_MON_KILL_EXP')
        return gained
    end

    -- Melee for a fixed span against a target that never fights back or dies.
    -- The harness swings at 3/4 of the real delay: a bare-handed human gets 6 rounds in 36 s.
    local function fight(family, seconds)
        becomeSpecies(family, 1)

        local mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:setUnkillable(true)
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)
        player:setTP(0)
        player.packets:clear()
        player.actions:engage(mob)

        for _ = 1, seconds do
            -- The target roams
            player.entities:moveTo(mob:getID())
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(player)
        end

        local rounds = {}
        for _, action in pairs(player.packets:actionPackets()) do
            if
                action.m_uID == player:getID() and
                action.cmd_no == xi.action.category.BASIC_ATTACK
            then
                table.insert(rounds, action.target[1].result)
            end
        end

        local landed = 0
        for _, swings in ipairs(rounds) do
            for _, swing in ipairs(swings) do
                if swing.miss == 0 then
                    landed = landed + 1
                end
            end
        end

        return rounds, landed
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    -- Retail swings twice a round, right fist then left.
    it('swings a Mandragora twice a round for 61 TP a hit', function()
        local rounds, landed = fight(xi.monstrositySpecies.MANDRAGORA, 36)

        assert(#rounds >= 6 and #rounds <= 9, string.format('Mandragora attacked %d times in 36 s', #rounds))
        for idx, swings in ipairs(rounds) do
            assert(#swings == 2, string.format('round %d had %d swings', idx, #swings))
            assert(swings[1].sub_kind == 1 and swings[2].sub_kind == 0, string.format('round %d animated %d then %d', idx, swings[1].sub_kind, swings[2].sub_kind))
        end

        assert(player:getTP() == landed * 61, string.format('%d hits gave %d TP', landed, player:getTP()))
    end)

    -- Retail swings once a round.
    local singleSwingSpecies =
    {
        { 'Rabbit', xi.monstrositySpecies.RABBIT },
        { 'Lizard', xi.monstrositySpecies.LIZARD },
        { 'Bee',    xi.monstrositySpecies.BEE    },
    }

    for _, species in ipairs(singleSwingSpecies) do
        it(string.format('swings a %s once a round for 75 TP a hit', species[1]), function()
            local rounds, landed = fight(species[2], 36)

            assert(#rounds >= 10 and #rounds <= 13, string.format('%s attacked %d times in 36 s', species[1], #rounds))
            for idx, swings in ipairs(rounds) do
                assert(#swings == 1, string.format('round %d had %d swings', idx, #swings))
            end

            assert(player:getTP() == landed * 75, string.format('%d hits gave %d TP', landed, player:getTP()))
        end)
    end

    -- Retail base exp. The mob level passed is two over the level it counts as.
    local killExp =
    {
        { level =  1, mob = 1, exp = 160 },
        { level =  2, mob = 1, exp = 140 },
        { level =  3, mob = 1, exp = 130 },
        { level =  8, mob = 1, exp =   0 },
        { level = 14, mob = 7, exp =  80 },
        { level = 15, mob = 9, exp =  90 },
    }

    for _, case in ipairs(killExp) do
        it(string.format('pays %d exp at level %d for a level %d kill', case.exp, case.level, case.mob - 2), function()
            becomeSpecies(xi.monstrositySpecies.LIZARD, case.level)

            local gained = killWorm(case.mob)
            assert(gained == case.exp, string.format('paid %d exp', gained))
        end)
    end

    it('levels up from kill exp and carries the rest over', function()
        becomeSpecies(xi.monstrositySpecies.LIZARD, 1)
        -- One short of level 2
        player:setLevel(1)

        killWorm(1)

        assert(player:getMainLvl() == 2, string.format('level is %d', player:getMainLvl()))
        assert(player:getMonstrosityData().levels[xi.monstrositySpecies.LIZARD] == 2, 'Lizard level was not recorded')
        assert(currentExp() == 159, string.format('exp is %s', tostring(currentExp())))
    end)

    it('levels a Rabbit from 1 to 15 on kills alone', function()
        becomeSpecies(xi.monstrositySpecies.RABBIT, 1)

        for _ = 1, 200 do
            if player:getMainLvl() >= 15 then
                break
            end

            -- An even match for the current level.
            killWorm(player:getMainLvl() + 2)
        end

        assert(player:getMainLvl() == 15, string.format('stopped at level %d', player:getMainLvl()))
        assert(player:getMonstrosityData().levels[xi.monstrositySpecies.RABBIT] == 15, 'Rabbit level was not recorded')
    end)

    -- Level 15 variants (JP wiki, BG).
    local levelUnlocks =
    {
        { name = 'Rabbit',     family = xi.monstrositySpecies.RABBIT,     variant = xi.monstrosityVariant.ONYX_RABBIT             },
        { name = 'Mandragora', family = xi.monstrositySpecies.MANDRAGORA, variant = xi.monstrosityVariant.KORRIGAN                },
        { name = 'Lizard',     family = xi.monstrositySpecies.LIZARD,     variant = xi.monstrosityVariant.ASHEN_LIZARD            },
        { name = 'Bee',        family = xi.monstrositySpecies.BEE,        variant = xi.monstrosityVariant.VERMILLION_AND_ONYX_BEE },
    }

    for _, unlock in ipairs(levelUnlocks) do
        it(string.format('unlocks a variant and says so when a %s reaches 15', unlock.name), function()
            becomeSpecies(unlock.family, 14)
            assert(not xi.monstrosity.hasUnlockedVariant(player, unlock.variant), 'owned the variant at 14')

            -- One short of 15
            player:setLevel(14)
            player.packets:clear()
            player:addExp(1)

            assert(player:getMainLvl() == 15, string.format('level is %d', player:getMainLvl()))
            assert(xi.monstrosity.hasUnlockedVariant(player, unlock.variant), 'variant was not unlocked')

            local announced = 0
            for _, pkt in pairs(player.packets:getIncoming()) do
                if pkt.type == 0x029 and pkt.data[0x18] + pkt.data[0x19] * 256 == 677 then
                    assert(pkt.data[0x0C] == 32, string.format('first parameter was %d', pkt.data[0x0C]))
                    announced = announced + 1
                end
            end

            assert(announced == 1, string.format('announced %d unlocks', announced))
        end)
    end

    it('grants a level unlock reached before it existed on zoning', function()
        becomeSpecies(xi.monstrositySpecies.LIZARD, 30)

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.ASHEN_LIZARD), 'Ashen Lizard was not granted')
        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.BUGARD), 'Bugard was not granted')
    end)

    -- JP wiki: a Monipulator never earns gil.
    it('pays a Monipulator no gil where a normal player gets some', function()
        xi.test.world:setSetting('map.ALL_MOBS_GIL_BONUS', 1)
        becomeSpecies(xi.monstrositySpecies.LIZARD, 5)

        local gil = player:getGil()
        killWorm(5)
        assert(player:getGil() == gil, string.format('a Monipulator earned %d gil', player:getGil() - gil))

        player:changeJob(xi.job.WAR)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        killWorm(5)
        assert(player:getGil() > gil, 'the normal player earned no gil either')
    end)

    -- Retail refreshes the infamy in the Monstrosity menu on every kill.
    it('sends the new infamy after a kill that does not level up', function()
        becomeSpecies(xi.monstrositySpecies.LIZARD, 5)
        player.packets:clear()

        killWorm(1)

        local infamy = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x063 and pkt.data[0x04] == 3 then
                infamy = pkt.data[0x12] + pkt.data[0x13] * 256
            end
        end

        assert(player:getCurrency('infamy') > 0, 'the kill paid no infamy')
        assert(infamy == player:getCurrency('infamy'), string.format('0x063 infamy %s, currency %d', tostring(infamy), player:getCurrency('infamy')))
    end)
end)
