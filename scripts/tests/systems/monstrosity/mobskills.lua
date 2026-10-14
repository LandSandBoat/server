-----------------------------------
-- Monstrosity TP moves. The client sends a DAT skill id, which data/monstrosity.yaml maps to a
-- mob skill id and a fixed TP cost. Unlike a mob, a Monipulator spends only that cost.
-----------------------------------
local ffi     = require('ffi')
local helpers = require('scripts.tests.systems.monstrosity.helpers')

describe('Monstrosity mobskills', function()
    local lizardSpecies = xi.monstrositySpecies.LIZARD

    local fireballDat  = 343
    local fireballMob  = xi.mobSkill.FIREBALL_1
    local fireballCost = 1000

    local secretionDat   = 349
    local secretionMob   = xi.mobSkill.SECRETION_1
    local secretionCost  = 500
    local secretionLevel = 10

    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local target

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        helpers.becomeSpecies(player, lizardSpecies, lizardSpecies, 15)

        target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        target:setAutoAttackEnabled(false)

        local pos = player:getPos()
        target:setPos(pos.x, pos.y, pos.z)
    end)

    after_each(function()
        target:setAutoAttackEnabled(true)
    end)

    it('translates the DAT skill id and spends only the listed TP cost', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(target, fireballDat)
        helpers.waitForMove(player)

        assert(usedSkill() == fireballMob, string.format('expected mob skill %d, got %s', fireballMob, tostring(usedSkill())))
        helpers.assertSpent(player, 3000, fireballCost)
    end)

    it('refuses a move below its unlock level', function()
        local data = player:getMonstrosityData()
        data.levels[lizardSpecies] = secretionLevel - 1
        player:setMonstrosityData(data)

        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(player, secretionDat)

        assert(usedSkill() == nil, 'Secretion should still be locked')
        assert(player:getTP() == 3000, string.format('TP=%d, expected untouched', player:getTP()))
    end)

    it('spends a cheaper move for less', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(player, secretionDat)
        helpers.waitForMove(player)

        assert(usedSkill() == secretionMob, string.format('expected mob skill %d, got %s', secretionMob, tostring(usedSkill())))
        helpers.assertSpent(player, 3000, secretionCost)
    end)

    it('rejects a move the player cannot afford and spends nothing', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(fireballCost - 1)
        player.actions:useMonsterSkill(target, fireballDat)

        assert(usedSkill() == nil, 'skill should not have started')
        assert(player:getTP() == fireballCost - 1, string.format('TP=%d, expected untouched', player:getTP()))
    end)

    -- JP wiki: Meikyo Shisui makes only the next move free.
    it('uses one move for free under Meikyo Shisui', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(0)
        player:addStatusEffect(xi.effect.MEIKYO_SHISUI, { power = 1, duration = 30, origin = player })
        player.actions:useMonsterSkill(target, fireballDat)
        helpers.waitForMove(player)

        assert(usedSkill() == fireballMob, string.format('expected mob skill %d, got %s', fireballMob, tostring(usedSkill())))
        assert(not player:hasStatusEffect(xi.effect.MEIKYO_SHISUI), 'Meikyo Shisui outlived the free move')
    end)

    it('spends no TP on a move under Meikyo Shisui', function()
        player:setTP(1500)
        player:addStatusEffect(xi.effect.MEIKYO_SHISUI, { power = 1, duration = 30, origin = player })
        player.actions:useMonsterSkill(target, fireballDat)
        helpers.waitForMove(player)

        assert(player:getTP() >= 1500, string.format('TP fell to %d', player:getTP()))
    end)

    -- Retail takes the TP when the move fires. A move cancelled while readying costs nothing.
    it('charges nothing for an interrupted move', function()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, fireballDat)
        assert(player:getTP() == 3000, 'TP was charged while readying')

        player:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = player })
        for _ = 1, 5 do
            xi.test.world:skipTime(3)
        end

        assert(player:getTP() == 3000, string.format('TP=%d, expected 3000', player:getTP()))
    end)

    it('refunds nothing for an interrupted free move', function()
        player:setTP(500)
        player:addStatusEffect(xi.effect.MEIKYO_SHISUI, { power = 1, duration = 30, origin = player })
        player.actions:useMonsterSkill(target, fireballDat)
        player:addStatusEffect(xi.effect.SLEEP_I, { power = 1, duration = 60, origin = player })
        for _ = 1, 5 do
            xi.test.world:skipTime(3)
        end

        assert(player:getTP() == 500, string.format('TP=%d, expected 500', player:getTP()))
    end)

    -- Retail answers a refused monster skill with a BATTLE_MESSAGE.
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
        assert(messages[1] == xi.msg.basic.UNABLE_TO_USE_JA2, string.format('battle message was %d', messages[1]))
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
        local usedSkill = helpers.watchSkill(player)
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
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
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
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
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
        local before    = player:getCurrency('infamy')
        local gainedExp = helpers.killWorm(player)
        local gained = player:getCurrency('infamy') - before
        assert(gainedExp > 0, 'the kill paid no exp')
        assert(gained == math.floor(gainedExp / 10), string.format('%d exp paid %d infamy', gainedExp, gained))
    end)

    -- Retail took record 65 with 0x10C and counted a kill as a Monipulator.
    it('counts kills toward Mons.: Total Monsters Vanquished', function()
        local record = ffi.new('uint8_t[8]')
        record[0x04] = 65
        player.packets:send(0x10C, record, assert(ffi.sizeof(record)))
        assert(player:hasEminenceRecord(65), 'precondition: the record was not taken')

        helpers.killWorm(player)

        assert(player:getEminenceProgress(65) == 1, string.format('progress is %s', tostring(player:getEminenceProgress(65))))
    end)

    it('pays no infamy for exp from scripts', function()
        local before = player:getCurrency('infamy')
        player:addExp(1000)

        assert(player:getCurrency('infamy') == before, 'scripted exp paid infamy')
    end)
end)

-- Retail Crab levelling: Bubble Curtain at 10, then at 30 the Toad, Scissor Guard and the first instinct.
-- The client draws its lightbulb on the learn message, so it goes out even for moves still disabled here.
describe('Monstrosity level up messages', function()
    ---@type CClientEntityPair
    local player

    local function battleMessages()
        local messages = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x029 then
                table.insert(messages, { message = pkt.data[0x18] + pkt.data[0x19] * 256, param = pkt.data[0x0C] + pkt.data[0x0D] * 256 })
            end
        end

        return messages
    end

    local function levelTo(level)
        player:setLevel(level - 1)
        player.packets:clear()
        player:addExp(1)
    end

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        helpers.becomeSpecies(player, xi.monstrositySpecies.CRAB, xi.monstrositySpecies.CRAB, 1)
    end)

    it('announces Bubble Curtain at Crab level 10', function()
        levelTo(10)

        local messages = battleMessages()
        assert(#messages == 1 and messages[1].message == xi.msg.basic.LEARNS_ABILITY and messages[1].param == 443,
            string.format('%d messages, first %s', #messages, messages[1] and messages[1].message or 'none'))
    end)

    it('unlocks the Toad and an instinct at Crab level 30, in retail order', function()
        -- Owned on retail from level 15.
        xi.monstrosity.unlockVariant(player, xi.monstrosityVariant.VERMILLION_CRAB)
        levelTo(30)

        local order = {}
        for _, entry in ipairs(battleMessages()) do
            table.insert(order, entry.message)
        end

        local expected = { xi.msg.basic.POSSESS_NEW_MONSTER, xi.msg.basic.LEARNS_ABILITY, xi.msg.basic.LEARNED_NEW_INSTINCT }
        assert(table.concat(order, ',') == table.concat(expected, ','), string.format('messages were %s', table.concat(order, ',')))
        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.TOAD), 'the Toad should be unlocked')
    end)

    it('announces the rise to NM rank under Belligerency', function()
        player:setBelligerencyFlag(true)
        player:addCurrency('infamy', 9999)
        player.packets:clear()
        helpers.killWorm(player)

        local announced = false
        for _, entry in ipairs(battleMessages()) do
            announced = announced or entry.message == xi.msg.basic.NEWFOUND_PUISSANCE
        end

        assert(announced, 'crossing 10,000 infamy was not announced')
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
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    it('takes the ecosystem of the species rather than staying Humanoid', function()
        assert(player:getEcosystem() == xi.ecosystem.BEAST,
            string.format('a starting Rabbit reported ecosystem %d', player:getEcosystem()))

        helpers.becomeSpecies(player, lizardSpecies, lizardSpecies, 1)

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

    it('is not aggroed by the ecosystem it preys on', function()
        helpers.becomeSpecies(player, mandragoraSpecies, mandragoraSpecies, 1)
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

describe('Monstrosity Crab moves', function()
    local bigScissorsDat = 396
    local bigScissors    = 444

    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        helpers.becomeSpecies(player, xi.monstrositySpecies.CRAB, xi.monstrositySpecies.CRAB, 1)
    end)

    it('runs Big Scissors', function()
        local target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        local pos = player:getPos()
        target:setPos(pos.x, pos.y, pos.z)

        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(target, bigScissorsDat)

        assert(usedSkill() == bigScissors, string.format('expected mob skill %d, got %s', bigScissors, tostring(usedSkill())))
    end)
end)

-- Only Spriggan.C has Jittering Jig and Romp. Spriggan and Spriggan.G have Frenetic Flurry.
describe('Monstrosity Spriggan moves', function()
    local sprigganBase = 255
    local sprigganC    = 256 + xi.monstrosityVariant.SPRIGGAN_C
    local jigDat       = 689
    local rompDat      = 690
    local flurryDat    = 691

    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local target

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        helpers.becomeSpecies(player, xi.monstrositySpecies.EORZEAN_SPRIGGAN, sprigganC, 30)

        target = player.entities:moveTo('Wild_Rabbit')
        target:respawn()
        target:setAutoAttackEnabled(false)

        local pos = player:getPos()
        target:setPos(pos.x, pos.y, pos.z)
    end)

    after_each(function()
        target:setAutoAttackEnabled(true)
    end)

    it('Jittering Jig boosts attack for a minute at 700 TP', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(player, jigDat)
        helpers.waitForMove(player)

        assert(usedSkill() == 3144, string.format('expected mob skill 3144, got %s', tostring(usedSkill())))
        helpers.assertSpent(player, 3000, 700)

        for _ = 1, 3 do
            xi.test.world:skipTime(2)
        end

        local effect = player:getStatusEffect(xi.effect.ATTACK_BOOST)
        assert(effect, 'should have Attack Boost')
        assert(effect:getDuration() == 60000, string.format('duration was %d ms', effect:getDuration()))
    end)

    it('Romp runs mob skill 3145 for 700 TP', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(target, rompDat)
        helpers.waitForMove(player)

        assert(usedSkill() == 3145, string.format('expected mob skill 3145, got %s', tostring(usedSkill())))
        helpers.assertSpent(player, 3000, 700)
    end)

    it('Frenetic Flurry runs mob skill 3146 for 1500 TP as a plain Spriggan', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.EORZEAN_SPRIGGAN, sprigganBase, 30)
        target = player.entities:moveTo('Wild_Rabbit')

        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(target, flurryDat)
        helpers.waitForMove(player)

        assert(usedSkill() == 3146, string.format('expected mob skill 3146, got %s', tostring(usedSkill())))
        helpers.assertSpent(player, 3000, 1500)
    end)

    it('refuses Frenetic Flurry as a Spriggan.C', function()
        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(target, flurryDat)

        assert(usedSkill() == nil, 'Spriggan.C should not have Frenetic Flurry')
    end)

    it('refuses a move that belongs to another species', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.EORZEAN_SPRIGGAN, sprigganBase, 30)
        target = player.entities:moveTo('Wild_Rabbit')

        local usedSkill = helpers.watchSkill(player)
        player:setTP(3000)
        player.actions:useMonsterSkill(target, rompDat)

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
            { dat = 257, mob = xi.mobSkill.FOOT_KICK_1                },
            { dat = 258, mob = xi.mobSkill.DUST_CLOUD_1               },
            { dat = 259, mob = xi.mobSkill.WHIRL_CLAWS_1              },
            { dat = 314, mob = xi.mobSkill.WILD_CARROT_1, self = true },
        },
        [xi.monstrositySpecies.MANDRAGORA] =
        {
            { dat = 294, mob = xi.mobSkill.HEAD_BUTT_1                   },
            { dat = 295, mob = xi.mobSkill.DREAM_FLOWER_1                },
            { dat = 296, mob = xi.mobSkill.WILD_OATS_1                   },
            { dat = 297, mob = xi.mobSkill.PHOTOSYNTHESIS_1, self = true },
            { dat = 298, mob = xi.mobSkill.LEAF_DAGGER_1                 },
            { dat = 299, mob = xi.mobSkill.SCREAM_1                      },
            { dat = 603, mob = 2410                                      },
        },
        [xi.monstrositySpecies.LIZARD] =
        {
            { dat = 343, mob = xi.mobSkill.FIREBALL_1               },
            { dat = 344, mob = xi.mobSkill.BLOCKHEAD_1              },
            { dat = 345, mob = xi.mobSkill.BRAIN_CRUSH_1            },
            { dat = 346, mob = xi.mobSkill.BALEFUL_GAZE_LIZARD      },
            { dat = 347, mob = xi.mobSkill.PLAGUE_BREATH_1          },
            { dat = 348, mob = xi.mobSkill.INFRASONICS_1            },
            { dat = 349, mob = xi.mobSkill.SECRETION_1, self = true },
        },
        [xi.monstrositySpecies.BEE] =
        {
            { dat = 319, mob = 334 },
            { dat = 320, mob = 335, self = true },
        },
    }

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    for family, list in pairs(moves) do
        for _, move in ipairs(list) do
            it(string.format('family %d DAT %d runs mob skill %d', family, move.dat, move.mob), function()
                helpers.becomeSpecies(player, family, family, 99)

                ---@type CTestEntity
                local target = player
                if not move.self then
                    target = player.entities:moveTo('Wild_Rabbit')
                    target:respawn()
                end

                local usedSkill = helpers.watchSkill(player)
                player:setTP(3000)
                player.actions:useMonsterSkill(target, move.dat)

                assert(usedSkill() == move.mob, string.format('expected mob skill %d, got %s', move.mob, tostring(usedSkill())))
            end)
        end
    end
end)

describe('Monstrosity Bee moves', function()
    local pollenDat = 320

    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        helpers.becomeSpecies(player, xi.monstrositySpecies.BEE, xi.monstrositySpecies.BEE, 10)
    end)

    -- JP wiki: Pollen heals a Monipulator for an eighth of its max HP.
    it('heals an eighth of max HP with Pollen', function()
        helpers.engageDummy(player)
        player:setHP(1)
        player:setTP(3000)
        player.actions:useMonsterSkill(player, pollenDat)
        for _ = 1, 3 do
            xi.test.world:skipTime(2)
        end

        local expected = 1 + math.floor(player:getMaxHP() / 8)
        assert(player:getHP() == expected, string.format('HP is %d of %d, expected %d', player:getHP(), player:getMaxHP(), expected))
    end)

    it('gives Hundred Fists for 20 seconds with Frenzy Pollen', function()
        local frenzyPollenDat = 549
        helpers.becomeSpecies(player, xi.monstrositySpecies.BEE, 256 + xi.monstrosityVariant.VERMILLION_AND_ONYX_BEE, 30)
        player:setTP(3000)
        player.actions:useMonsterSkill(player, frenzyPollenDat)
        for _ = 1, 3 do
            xi.test.world:skipTime(2)
        end

        player.assert:hasEffect(xi.effect.HUNDRED_FISTS)
        local duration = player:getStatusEffect(xi.effect.HUNDRED_FISTS):getDuration()
        assert(duration == 20000, string.format('Hundred Fists lasts %d ms', duration))
    end)
end)

-- The level 15 variants.
describe('Monstrosity variant moves', function()
    ---@type CClientEntityPair
    local player

    local onyxRabbit   = 256 + xi.monstrosityVariant.ONYX_RABBIT
    local korrigan     = 256 + xi.monstrosityVariant.KORRIGAN
    local ashenLizard  = 256 + xi.monstrosityVariant.ASHEN_LIZARD
    local onyxBee      = 256 + xi.monstrosityVariant.VERMILLION_AND_ONYX_BEE
    local snowCloudDat = 455

    local variants =
    {
        { name = 'Onyx Rabbit',             family = xi.monstrositySpecies.RABBIT,     species = onyxRabbit,  dat = 257, mob = xi.mobSkill.FOOT_KICK_1 },
        { name = 'Korrigan',                family = xi.monstrositySpecies.MANDRAGORA, species = korrigan,    dat = 296, mob = xi.mobSkill.WILD_OATS_1 },
        { name = 'Ashen Lizard',            family = xi.monstrositySpecies.LIZARD,     species = ashenLizard, dat = 441, mob = 621                     },
        { name = 'Vermillion and Onyx Bee', family = xi.monstrositySpecies.BEE,        species = onyxBee,     dat = 319, mob = 334                     },
    }

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    for _, variant in ipairs(variants) do
        it(string.format('gives %s its first move', variant.name), function()
            helpers.becomeSpecies(player, variant.family, variant.species, 15)

            local used = helpers.useMoveOnRabbit(player, variant.dat)
            assert(used == variant.mob, string.format('expected mob skill %d, got %s', variant.mob, tostring(used)))
        end)
    end

    -- The JP wiki gives Snow Cloud to Alabaster Rabbit only.
    it('keeps Snow Cloud from a base Rabbit', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, 60)

        assert(helpers.useMoveOnRabbit(player, snowCloudDat) == nil, 'a base Rabbit used Snow Cloud')
    end)

    -- The BLM sub job's share of HP is not fitted yet, so this sits a little low.
    it('gives an Ashen Lizard close to its retail HP', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.LIZARD, ashenLizard, 15)

        assert(player:getMaxHP() >= 740 and player:getMaxHP() <= 772, string.format('Ashen Lizard 15 has %d HP', player:getMaxHP()))
    end)
end)

-- Retail Goobbue moves, from level 1-26 captures.
describe('Monstrosity Goobbue moves', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    local moves =
    {
        { name = 'Beatdown', level = 1,  dat = 437, mob = 583 },
        { name = 'Uppercut', level = 10, dat = 438, mob = 584 },
        { name = 'Blow',     level = 20, dat = 436, mob = 581 },
    }

    for _, move in ipairs(moves) do
        it(string.format('runs %s at level %d', move.name, move.level), function()
            helpers.becomeSpecies(player, xi.monstrositySpecies.GOOBBUE, xi.monstrositySpecies.GOOBBUE, move.level)

            local used = helpers.useMoveOnRabbit(player, move.dat)
            assert(used == move.mob, string.format('expected mob skill %d, got %s', move.mob, tostring(used)))
        end)
    end
end)

-- Fighting Stance swaps a Wamouracampa to its Coiled form and back. The client reads the form from 0x037.
describe('Monstrosity Fighting Stance', function()
    local stanceDat = 684
    local coiled    = 256 + xi.monstrosityVariant.COILED_WAMOURACAMPA

    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
        helpers.becomeSpecies(player, xi.monstrositySpecies.WAMOURACAMPA, xi.monstrositySpecies.WAMOURACAMPA, 10)
    end)

    local function shownSpecies()
        local species = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x037 then
                species = bit.band(pkt.data[0x54] + pkt.data[0x55] * 256, 0x7FFF)
            end
        end

        return species
    end

    it('shows the Coiled form for 300 TP, then the base form again', function()
        player:setTP(1000)
        player.packets:clear()
        player.actions:useMonsterSkill(player, stanceDat)

        assert(player:getTP() == 700, string.format('TP is %d', player:getTP()))
        local shown = shownSpecies()
        assert(shown == coiled, string.format('0x037 shows species %s', tostring(shown)))

        for _ = 1, 3 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(player)
        end

        player.packets:clear()
        player.actions:useMonsterSkill(player, stanceDat)
        shown = shownSpecies()
        assert(shown == xi.monstrositySpecies.WAMOURACAMPA, string.format('0x037 shows species %s', tostring(shown)))
    end)

    it('drops the stance on a species change', function()
        player:setTP(1000)
        player.actions:useMonsterSkill(player, stanceDat)
        helpers.becomeSpecies(player, xi.monstrositySpecies.WAMOURACAMPA, xi.monstrositySpecies.WAMOURACAMPA, 10)

        player.packets:clear()
        player:setTP(1000)
        player.actions:useMonsterSkill(player, stanceDat)
        assert(shownSpecies() == coiled, 'the stance carried over the species change')
    end)

    it('walks slower than other species', function()
        assert(player:getBaseSpeed() == 30, string.format('base speed is %d', player:getBaseSpeed()))
    end)
end)
