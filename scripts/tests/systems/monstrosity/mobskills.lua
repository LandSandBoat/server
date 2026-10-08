-- Monstrosity TP moves. The client sends a DAT skill id, which data/monstrosity.yaml maps to a
-- mob skill id and a fixed TP cost. Unlike a mob, a Monipulator spends only that cost.

describe('Monstrosity mobskills', function()
    local lizardSpecies = xi.monstrositySpecies.LIZARD

    local fireballDat   = 343
    local fireballMob   = 367
    local fireballCost  = 1000

    local secretionDat   = 349
    local secretionMob   = 373
    local secretionCost  = 500
    local secretionLevel = 10

    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local target

    -- Monstrosity is populated by TryPopulateMonstrosityData when a character whose
    -- main job is MON loads, so the job change has to be followed by a zone reload.
    local function becomeLizard()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)

        local data = player:getMonstrosityData()
        data.monstrosityId         = lizardSpecies
        data.species               = lizardSpecies
        data.levels[lizardSpecies] = 15
        player:setMonstrosityData(data)
        player:delStatusEffect(xi.effect.GESTATION)
    end

    -- Records the mob skill id the AI actually entered, which is what proves the
    -- DAT id was translated rather than passed straight through.
    local function watchSkill()
        local used = nil
        player:addListener('WEAPONSKILL_STATE_ENTER', 'TEST_MON_SKILL', function(_, skillId)
            used = skillId
        end)

        return function()
            return used
        end
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        becomeLizard()

        target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        target:setAutoAttackEnabled(false)

        local pos = player:getPos()
        target:setPos(pos.x, pos.y, pos.z)
    end)

    after_each(function()
        if target then
            target:setAutoAttackEnabled(true)
        end
    end)

    it('enters Monstrosity as the requested species', function()
        assert(player:getMainJob() == xi.job.MON, 'main job should be MON')

        local data = player:getMonstrosityData()
        assert(data.species == lizardSpecies, string.format('species=%s', tostring(data.species)))
    end)

    it('translates the DAT skill id to a mob skill id', function()
        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, fireballDat)

        assert(usedSkill() == fireballMob, string.format('expected mob skill %d, got %s', fireballMob, tostring(usedSkill())))
    end)

    it('spends only the listed TP cost, not the whole bar', function()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, fireballDat)

        assert(player:getTP() == 3000 - fireballCost, string.format('TP=%d, expected %d', player:getTP(), 3000 - fireballCost))
    end)

    it('refuses a move below its unlock level', function()
        local data = player:getMonstrosityData()
        data.levels[lizardSpecies] = secretionLevel - 1
        player:setMonstrosityData(data)

        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(player, secretionDat)

        assert(usedSkill() == nil, 'Secretion should still be locked')
        assert(player:getTP() == 3000, string.format('TP=%d, expected untouched', player:getTP()))
    end)

    it('spends a cheaper move for less', function()
        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(player, secretionDat)

        assert(usedSkill() == secretionMob, string.format('expected mob skill %d, got %s', secretionMob, tostring(usedSkill())))
        assert(player:getTP() == 3000 - secretionCost, string.format('TP=%d, expected %d', player:getTP(), 3000 - secretionCost))
    end)

    it('rejects a move the player cannot afford and spends nothing', function()
        local usedSkill = watchSkill()
        player:setTP(fireballCost - 1)
        player.actions:useMonsterSkill(target, fireballDat)

        assert(usedSkill() == nil, 'skill should not have started')
        assert(player:getTP() == fireballCost - 1, string.format('TP=%d, expected untouched', player:getTP()))
    end)

    -- A mob spends its whole bar, so the interrupt penalty overwrites TP outright.
    -- A Monstrosity move only ever spent its cost, so the untouched remainder has to
    -- survive: 1000 spent, a quarter of that handed back, 2000 never at stake.
    it('keeps the unspent TP when a fixed-cost move is interrupted', function()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, fireballDat)
        assert(player:getTP() == 3000 - fireballCost, 'cost should be spent up front')

        player:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = player })
        for _ = 1, 5 do
            xi.test.world:skipTime(3)
        end

        local expected = (3000 - fireballCost) + (fireballCost / 4)
        assert(player:getTP() == expected, string.format('TP=%d, expected %d', player:getTP(), expected))
    end)

    -- Retail answers a refused monster skill with msg_basic 88 over BATTLE_MESSAGE.
    it('answers a refused move with the retail battle message', function()
        player:setTP(0)
        player.packets:clear()
        player.actions:useMonsterSkill(target, fireballDat)

        local messages = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x029 then
                -- MessageNum sits at packet offset 0x18.
                table.insert(messages, pkt.data[0x18] + pkt.data[0x19] * 256)
            end
        end

        assert(#messages > 0, 'no battle message was sent')
        assert(messages[1] == 88, string.format('battle message was %d, expected 88', messages[1]))
    end)

    it('announces a move learned on level up', function()
        player:setLevel(9)
        player.packets:clear()
        player:addExp(1)

        local learned = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if
                pkt.type == 0x029 and
                pkt.data[0x18] + pkt.data[0x19] * 256 == xi.msg.basic.LEARNS_ABILITY
            then
                table.insert(learned, pkt.data[0x0C] + pkt.data[0x0D] * 256)
            end
        end

        assert(#learned == 1 and learned[1] == secretionMob, string.format('learned %s', table.concat(learned, ', ')))
    end)

    it('rejects an unknown DAT skill id and spends nothing', function()
        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, 9999)

        assert(usedSkill() == nil, 'skill should not have started')
        assert(player:getTP() == 3000, string.format('TP=%d, expected untouched', player:getTP()))
    end)
end)

-- MON levels on its own exp curve. Levels 4 and 5 are where the common wiki table is wrong.
describe('Monstrosity exp curve', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    -- setLevel leaves the character one point short of the next level, so a single
    -- point rolls it over and the following exp measures that level's threshold.
    local function thresholdAt(level)
        player:setLevel(level)
        player:addExp(1)
        assert(player:getMainLvl() == level + 1, string.format('did not reach level %d', level + 1))

        local spent = 0
        for _ = 1, 60 do
            if player:getMainLvl() ~= level + 1 then
                break
            end

            player:addExp(50)
            spent = spent + 50
        end

        return spent
    end

    it('needs 600 exp to clear level 4', function()
        local threshold = thresholdAt(3)
        assert(threshold == 600, string.format('level 4 threshold was %d', threshold))
    end)

    it('needs 700 exp to clear level 5', function()
        local threshold = thresholdAt(4)
        assert(threshold == 700, string.format('level 5 threshold was %d', threshold))
    end)

    it('records the new level against the current species on level up', function()
        player:setLevel(6)
        local before = player:getMonstrosityData()
        player:addExp(1)

        local after = player:getMonstrosityData()
        assert(player:getMainLvl() == 7, 'should have levelled to 7')
        assert(after.levels[before.monstrosityId] == 7,
            string.format('species level was %s, expected 7', tostring(after.levels[before.monstrosityId])))
    end)
end)

-- char_jobs only ever holds the level of whichever species was active last, and is
-- zero for a character entering Monstrosity for the first time. char_monstrosity holds
-- a level per species and is the source of truth on load.
describe('Monstrosity levelling entry', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    it('restores the species level on zoning rather than the last job level', function()
        local data = player:getMonstrosityData()
        data.levels[data.monstrosityId] = 7
        player:setMonstrosityData(data)

        player:gotoZone(xi.zone.WEST_RONFAURE)
        assert(player:getMainLvl() == 7, string.format('came back as level %d', player:getMainLvl()))
    end)

    -- Belligerency caps and level sync restrict the level without stopping it rising.
    it('records a level up gained under a level restriction', function()
        player:setLevel(20)
        player:levelRestriction(10)
        player:addExp(5000)

        local data = player:getMonstrosityData()
        player:levelRestriction(0)
        assert(data.levels[data.monstrosityId] > 20, string.format('species level stayed %d', data.levels[data.monstrosityId]))
    end)

    -- !changejob and other GM tools set the level directly rather than through exp.
    it('keeps a level set directly across zoning', function()
        player:setLevel(20)
        player:gotoZone(xi.zone.WEST_RONFAURE)

        assert(player:getMainLvl() == 20, string.format('came back as level %d', player:getMainLvl()))
    end)

    -- Only kills pay infamy, a tenth of the exp rounded down. Records of Eminence exp pays none.
    it('pays a tenth of kill exp as infamy', function()
        local gainedExp = 0
        player:addListener('EXPERIENCE_POINTS', 'TEST_MON_EXP', function(_, _, exp)
            gainedExp = gainedExp + exp
        end)

        local before = player:getCurrency('infamy')
        local mob    = player.entities:moveTo('Tunnel_Worm')
        mob:respawn()
        mob:updateClaim(player)
        mob:takeDamage(mob:getHP(), player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        for _ = 1, 3 do
            xi.test.world:tickEntity(mob)
            xi.test.world:skipTime(1)
        end

        local gained = player:getCurrency('infamy') - before
        assert(gainedExp > 0, 'the kill paid no exp')
        assert(gained == math.floor(gainedExp / 10), string.format('%d exp paid %d infamy', gainedExp, gained))
    end)

    it('pays no infamy for exp from scripts', function()
        local before = player:getCurrency('infamy')
        player:addExp(1000)

        assert(player:getCurrency('infamy') == before, 'scripted exp paid infamy')
    end)
end)

-- A Monipulator is a monster for ecosystem correlation, which drives both Killer effect
-- intimidation and what will aggro it. The chart is scripts/data/entity_correlation.lua:
-- Beast > Lizard > Vermin > Plantoid > Beast.
describe('Monstrosity ecosystem', function()
    local lizardSpecies     = xi.monstrositySpecies.LIZARD
    local mandragoraSpecies = xi.monstrositySpecies.MANDRAGORA

    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    it('takes the ecosystem of the species rather than staying Humanoid', function()
        assert(player:getEcosystem() == xi.ecosystem.BEAST,
            string.format('a starting Rabbit reported ecosystem %d', player:getEcosystem()))

        local data = player:getMonstrosityData()
        data.monstrosityId = lizardSpecies
        data.species       = lizardSpecies
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)

        assert(player:getEcosystem() == xi.ecosystem.LIZARD,
            string.format('a Lizard reported ecosystem %d', player:getEcosystem()))
    end)

    -- Wild Rabbit is a Beast. Plantoid preys on Beast, Beast preys on Lizard.
    local function forceAggressive(name)
        -- Zoning in as a Monipulator grants Gestation, which carries an Invisible flag and
        -- would hide the player from detection entirely.
        player:delStatusEffect(xi.effect.GESTATION)

        local mob = player.entities:moveTo(name)
        mob:respawn()
        mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)

        -- Roam past the post-spawn neutral window so the mob can aggro at all.
        for _ = 1, 10 do
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(mob)
        end

        -- Step into it now that it is able to aggro.
        player.entities:moveTo(name)
        xi.test.world:tickEntity(mob)

        return mob
    end

    local function becomeSpecies(speciesId)
        local data = player:getMonstrosityData()
        data.monstrosityId = speciesId
        data.species       = speciesId
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end

    it('is not aggroed by the ecosystem it preys on', function()
        becomeSpecies(mandragoraSpecies)
        assert(player:getEcosystem() == xi.ecosystem.PLANTOID, 'should be a Plantoid')

        local prey = forceAggressive('Wild_Rabbit')
        assert(prey:getEcosystem() == xi.ecosystem.BEAST, 'Wild Rabbit should be a Beast')
        assert(not prey:isEngaged(), 'a Plantoid preys on Beast, so a Beast should not aggro it')
    end)

    it('is still aggroed by an ecosystem it does not prey on', function()
        assert(player:getEcosystem() == xi.ecosystem.BEAST, 'a starting Rabbit should be a Beast')

        local hunter = forceAggressive('Wild_Rabbit')
        assert(hunter:isEngaged(), 'Beast preys on Lizard, not Beast, so a Beast should still aggro')
    end)
end)

-- Only Spriggan.C has Jittering Jig and Romp. Every Spriggan has Frenetic Flurry.
describe('Monstrosity Spriggan moves', function()
    local sprigganBase = 255
    local sprigganC    = 510

    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local target

    local function becomeSpriggan(speciesCode)
        local data = player:getMonstrosityData()
        data.monstrosityId                                  = xi.monstrositySpecies.EORZEAN_SPRIGGAN
        data.species                                        = speciesCode
        data.levels[xi.monstrositySpecies.EORZEAN_SPRIGGAN] = 30
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:delStatusEffect(xi.effect.GESTATION)
    end

    local function watchSkill()
        local used = nil
        player:addListener('WEAPONSKILL_STATE_ENTER', 'TEST_MON_SKILL', function(_, skillId)
            used = skillId
        end)

        return function()
            return used
        end
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        becomeSpriggan(sprigganC)

        target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        target:setAutoAttackEnabled(false)

        local pos = player:getPos()
        target:setPos(pos.x, pos.y, pos.z)
    end)

    after_each(function()
        if target then
            target:setAutoAttackEnabled(true)
        end
    end)

    it('Jittering Jig boosts attack for a minute at 700 TP', function()
        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(player, 689)

        assert(usedSkill() == 3144, string.format('expected mob skill 3144, got %s', tostring(usedSkill())))
        assert(player:getTP() == 2300, string.format('TP=%d, expected 2300', player:getTP()))

        for _ = 1, 3 do
            xi.test.world:skipTime(2)
        end

        local effect = player:getStatusEffect(xi.effect.ATTACK_BOOST)
        assert(effect, 'should have Attack Boost')
        assert(effect:getDuration() == 60000, string.format('duration was %d ms', effect:getDuration()))
    end)

    for _, move in ipairs({
        { name = 'Romp',            species = sprigganC, dat = 690, mob = 3145, cost = 700  },
        { name = 'Frenetic Flurry', species = sprigganC, dat = 691, mob = 3146, cost = 1500 },
    }) do
        it(string.format('%s runs mob skill %d for %d TP', move.name, move.mob, move.cost), function()
            becomeSpriggan(move.species)
            target = player.entities:moveTo('Wild_Rabbit')

            local usedSkill = watchSkill()
            player:setTP(3000)
            player.actions:useMonsterSkill(target, move.dat)

            assert(usedSkill() == move.mob, string.format('expected mob skill %d, got %s', move.mob, tostring(usedSkill())))
            assert(player:getTP() == 3000 - move.cost, string.format('TP=%d, expected %d', player:getTP(), 3000 - move.cost))
        end)
    end

    it('refuses a move that belongs to another species', function()
        becomeSpriggan(sprigganBase)
        target = player.entities:moveTo('Wild_Rabbit')

        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, 690)

        assert(usedSkill() == nil, 'plain Spriggan should not have Romp')
        assert(player:getTP() == 3000, string.format('TP=%d, expected untouched', player:getTP()))
    end)
end)

-- Every move the starting families carry, with the mob skill it runs.
describe('Monstrosity starting family moves', function()
    ---@type CClientEntityPair
    local player

    local moves =
    {
        [xi.monstrositySpecies.RABBIT] =
        {
            { dat = 257, mob = 257 },
            { dat = 258, mob = 258 },
            { dat = 259, mob = 259 },
            { dat = 314, mob = 323, self = true },
        },
        [xi.monstrositySpecies.MANDRAGORA] =
        {
            { dat = 294, mob = 300 },
            { dat = 295, mob = 301 },
            { dat = 296, mob = 302 },
            { dat = 297, mob = 304, self = true },
            { dat = 298, mob = 305 },
            { dat = 299, mob = 306 },
            { dat = 603, mob = 2410 },
        },
        [xi.monstrositySpecies.LIZARD] =
        {
            { dat = 343, mob = 367 },
            { dat = 344, mob = 368 },
            { dat = 345, mob = 369 },
            { dat = 346, mob = 370 },
            { dat = 347, mob = 371 },
            { dat = 348, mob = 372 },
            { dat = 349, mob = 373, self = true },
        },
        [xi.monstrositySpecies.BEE] =
        {
            { dat = 319, mob = 334 },
            { dat = 320, mob = 335, self = true },
        },
    }

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    for family, list in pairs(moves) do
        for _, move in ipairs(list) do
            it(string.format('family %d DAT %d runs mob skill %d', family, move.dat, move.mob), function()
                local data = player:getMonstrosityData()
                data.monstrosityId  = family
                data.species        = family
                data.levels[family] = 99
                player:setMonstrosityData(data)
                player:gotoZone(xi.zone.WEST_RONFAURE)
                player:delStatusEffect(xi.effect.GESTATION)

                ---@type CTestEntity
                local target = player
                if not move.self then
                    target = player.entities:moveTo('Wild_Rabbit')
                    target:respawn()
                end

                local used = nil
                player:addListener('WEAPONSKILL_STATE_ENTER', 'TEST_MON_SKILL', function(_, skillId)
                    used = skillId
                end)

                player:setTP(3000)
                player.actions:useMonsterSkill(target, move.dat)

                assert(used == move.mob, string.format('expected mob skill %d, got %s', move.mob, tostring(used)))
            end)
        end
    end
end)

describe('Monstrosity Bee moves', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)

        local data = player:getMonstrosityData()
        data.monstrosityId                     = xi.monstrositySpecies.BEE
        data.species                           = xi.monstrositySpecies.BEE
        data.levels[xi.monstrositySpecies.BEE] = 10
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:delStatusEffect(xi.effect.GESTATION)
    end)

    -- JP wiki: Pollen heals a Monipulator for an eighth of its max HP.
    it('heals an eighth of max HP with Pollen', function()
        player:setHP(1)
        player:setTP(3000)
        player.actions:useMonsterSkill(player, 320)
        for _ = 1, 3 do
            xi.test.world:skipTime(2)
        end

        local expected = 1 + math.floor(player:getMaxHP() / 8)
        assert(player:getHP() == expected, string.format('HP is %d of %d, expected %d', player:getHP(), player:getMaxHP(), expected))
    end)
end)

-- The level 15 variants.
describe('Monstrosity variant moves', function()
    ---@type CClientEntityPair
    local player

    local variants =
    {
        { name = 'Onyx Rabbit',             family = xi.monstrositySpecies.RABBIT,     species = 256, dat = 257, mob = 257 },
        { name = 'Korrigan',                family = xi.monstrositySpecies.MANDRAGORA, species = 281, dat = 296, mob = 302 },
        { name = 'Ashen Lizard',            family = xi.monstrositySpecies.LIZARD,     species = 315, dat = 441, mob = 621 },
        { name = 'Vermillion and Onyx Bee', family = xi.monstrositySpecies.BEE,        species = 290, dat = 319, mob = 334 },
    }

    local function becomeVariant(family, species, level)
        local data = player:getMonstrosityData()
        data.monstrosityId  = family
        data.species        = species
        data.levels[family] = level
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:delStatusEffect(xi.effect.GESTATION)
    end

    local function useOn(datSkillId)
        local mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        player.entities:moveTo(mob:getID())

        local used = nil
        player:addListener('WEAPONSKILL_STATE_ENTER', 'TEST_MON_VARIANT_SKILL', function(_, skillId)
            used = skillId
        end)

        player:setTP(3000)
        player.actions:useMonsterSkill(mob, datSkillId)
        player:removeListener('TEST_MON_VARIANT_SKILL')

        return used
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    for _, variant in ipairs(variants) do
        it(string.format('gives %s its first move', variant.name), function()
            becomeVariant(variant.family, variant.species, 15)

            local used = useOn(variant.dat)
            assert(used == variant.mob, string.format('expected mob skill %d, got %s', variant.mob, tostring(used)))
        end)
    end

    -- The JP wiki gives Snow Cloud to Alabaster Rabbit only.
    it('keeps Snow Cloud from a base Rabbit', function()
        becomeVariant(xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, 60)

        assert(useOn(455) == nil, 'a base Rabbit used Snow Cloud')
    end)

    -- The BLM sub job's share of HP is not fitted yet, so this sits a little low.
    it('gives an Ashen Lizard close to its retail HP', function()
        becomeVariant(xi.monstrositySpecies.LIZARD, 315, 15)

        assert(player:getMaxHP() >= 740 and player:getMaxHP() <= 772, string.format('Ashen Lizard 15 has %d HP', player:getMaxHP()))
    end)
end)
