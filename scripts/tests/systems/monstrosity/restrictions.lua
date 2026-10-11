-----------------------------------
-- Rules a Monipulator plays under, from the JP wiki's Monstrosity pages.
-----------------------------------
local ffi     = require('ffi')
local helpers = require('scripts.tests.systems.monstrosity.helpers')

describe('Monstrosity restrictions', function()
    local newYearMandragora = 256 + xi.monstrosityVariant.NEW_YEAR_MANDRAGORA
    local onyxBee           = 256 + xi.monstrosityVariant.VERMILLION_AND_ONYX_BEE
    local fireballDat       = 343

    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    -- Each family unlocks an instinct at 30, 60 and 90, held as a 2-bit count.
    it('unlocks a level instinct every 30 levels', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 65)

        local data  = player:getMonstrosityData()
        local count = bit.band(bit.rshift(data.instincts[10], 6), 3)
        assert(count == 2, string.format('Lizard at 65 owns %d level instincts', count))
    end)

    it('hides a Monipulator under Gestation from aggressive monsters', function()
        player.assert:hasEffect(xi.effect.GESTATION)

        local mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
        mob:setTrueDetection(true)
        for _ = 1, 10 do
            xi.test.world:skipTime(5)
            xi.test.world:tickEntity(mob)
        end

        player.entities:moveTo('Wild_Rabbit')
        xi.test.world:tickEntity(mob)
        assert(not mob:isEngaged(), 'a monster saw through Gestation')
    end)

    it('cannot attack under Gestation', function()
        local mob = player.entities:moveTo('Tunnel_Worm')
        mob:respawn()
        player.actions:engage(mob)

        assert(not player:isEngaged(), 'attacked under Gestation')
        player.assert:hasEffect(xi.effect.GESTATION)
    end)

    it('cannot use a monster skill under Gestation', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 15)
        -- Zoning grants Gestation again
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player.assert:hasEffect(xi.effect.GESTATION)

        local mob = player.entities:moveTo('Tunnel_Worm')
        mob:respawn()
        player:setTP(3000)
        player.actions:useMonsterSkill(mob, fireballDat)

        assert(player:getTP() == 3000, string.format('Fireball went off under Gestation, TP=%d', player:getTP()))
        player.assert:hasEffect(xi.effect.GESTATION)
    end)

    it('stops infamy at the cap without Belligerency', function()
        player:addCurrency('infamy', 9999)
        helpers.killWorm(player)

        assert(player:getCurrency('infamy') == 10000, string.format('infamy is %d', player:getCurrency('infamy')))
    end)

    it('stops infamy at the higher cap under Belligerency', function()
        player:setBelligerencyFlag(true)
        player:addCurrency('infamy', 49999)
        helpers.killWorm(player)

        assert(player:getCurrency('infamy') == 50000, string.format('infamy is %d', player:getCurrency('infamy')))
    end)

    -- Buburimu, Xarcabard and Uleguerand cap a flagged Monipulator at 30, 60 and 90.
    it('caps the level in a Belligerency zone while flagged', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, 45)
        player:setBelligerencyFlag(true)
        player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

        assert(player:getMainLvl() == 30, string.format('a level 45 Rabbit is level %d in Buburimu', player:getMainLvl()))

        local announced = false
        for _, pkt in pairs(player.packets:getIncoming()) do
            -- A message with no speaker carries 0x8000 in its number.
            if
                pkt.type == 0x02A and
                (pkt.data[0x1A] + pkt.data[0x1B] * 256) % 0x8000 == zones[xi.zone.BUBURIMU_PENINSULA].text.ENTERED_BELLIGERENCY_CAP
            then
                announced = pkt.data[0x08] == 30
            end
        end

        assert(announced, 'the level restriction was not announced')

        player:gotoZone(xi.zone.WEST_RONFAURE)
        assert(player:getMainLvl() == 45, string.format('the cap followed the Rabbit out, level %d', player:getMainLvl()))
    end)

    it('leaves the level alone in a Belligerency zone without the flag', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, 45)
        player:gotoZone(xi.zone.BUBURIMU_PENINSULA)

        assert(player:getMainLvl() == 45, string.format('an unflagged Rabbit is level %d in Buburimu', player:getMainLvl()))
    end)

    it('drops MON behaviour as soon as the job changes away from MON', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 10)
        assert(player:getBaseDelay() == 240, string.format('a Lizard has delay %d', player:getBaseDelay()))

        player:changeJob(xi.job.WAR)
        assert(player:getBaseDelay() == 480, string.format('a WAR kept delay %d', player:getBaseDelay()))
    end)

    it('edits saved progress outside MON without entering it', function()
        player:changeJob(xi.job.WAR)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        xi.monstrosity.setSpeciesLevel(player, xi.monstrositySpecies.LIZARD, 20)

        assert(xi.monstrosity.getSpeciesLevel(player, xi.monstrositySpecies.LIZARD) == 20, 'the Lizard level was not saved')
        assert(player:getBaseDelay() == 480, string.format('a WAR has delay %d', player:getBaseDelay()))
        assert(player:getMonstrositySize() == 0, 'editing saved progress entered MON')
    end)

    -- A Rabbit with no instincts equipped.
    local retailCombat =
    {
        [ 1] = { attack = 19, defence =  26 },
        [10] = { attack = 54, defence =  80 },
        [18] = { attack = 84, defence = 117 },
    }

    for level, retail in pairs(retailCombat) do
        it(string.format('gives a level %d Rabbit close to its retail attack and defence', level), function()
            helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, level)

            local attack  = player:getStat(xi.mod.ATT)
            local defence = player:getStat(xi.mod.DEF)
            assert(math.abs(attack - retail.attack) <= 5, string.format('attack %d, retail %d', attack, retail.attack))
            assert(math.abs(defence - retail.defence) <= 5, string.format('defence %d, retail %d', defence, retail.defence))
        end)
    end

    it('gives no MP to a NIN sub job', function()
        -- New Year Mandragora is MNK/NIN.
        helpers.becomeSpecies(player, xi.monstrositySpecies.MANDRAGORA, newYearMandragora, 35)

        assert(player:getMaxMP() == 0, string.format('MNK/NIN has %d MP', player:getMaxMP()))
    end)

    it('gives an RDM sub job its retail MP', function()
        -- Vermillion and Onyx Bee is WAR/RDM.
        helpers.becomeSpecies(player, xi.monstrositySpecies.BEE, onyxBee, 20)

        assert(player:getMaxMP() == 358, string.format('WAR/RDM 20 has %d MP', player:getMaxMP()))
    end)

    it('gives a PLD main and sub their retail MP', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.CRAB, xi.monstrositySpecies.CRAB, 30)
        assert(player:getMaxMP() == 1002, string.format('PLD/PLD 30 has %d MP', player:getMaxMP()))

        helpers.becomeSpecies(player, xi.monstrositySpecies.CRAB, 256 + xi.monstrosityVariant.VERMILLION_CRAB, 30)
        assert(player:getMaxMP() == 1033, string.format('PLD/RDM 30 has %d MP', player:getMaxMP()))
    end)

    it('casts with the magic skill of its species jobs', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.BEE, onyxBee, 20)
        assert(player:getSkillLevel(xi.skill.ELEMENTAL_MAGIC) > 0, 'a WAR/RDM has no elemental magic skill')

        helpers.becomeSpecies(player, xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 20)
        assert(player:getSkillLevel(xi.skill.ELEMENTAL_MAGIC) == 0, 'a WAR/WAR has elemental magic skill')
    end)

    local function waitSeconds(seconds)
        for _ = 1, seconds do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(player)
        end
    end

    local function startRelinquish()
        player:setMonstrosityEntryData(0, 0, 0, 0, xi.zone.WEST_RONFAURE, xi.job.WAR, xi.job.WAR)
        player:delStatusEffect(xi.effect.GESTATION)
        xi.monstrosity.relinquishOnAbility(player)
    end

    -- Retail counts 4, 3, 2, 1 three seconds apart, then leaves.
    it('leaves Monstrosity when the Relinquish countdown ends', function()
        startRelinquish()
        waitSeconds(15)

        assert(player:getMainJob() == xi.job.WAR, string.format('main job is %d', player:getMainJob()))
    end)

    -- Retail returns a Monipulator to the exact spot it stood on when it entered the passage.
    it('returns to the exact entry position', function()
        player:setMonstrosityEntryData(219.288, -12, 224.175, 255, xi.zone.PORT_WINDURST, xi.job.WAR, xi.job.NIN)
        xi.monstrosity.onMonstrosityReturnToEntrance(player)
        for _ = 1, 3 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(player)
        end

        local pos = player:getPos()
        assert(player:getZoneID() == xi.zone.PORT_WINDURST, string.format('returned to zone %d', player:getZoneID()))
        assert(math.abs(pos.x - 219.288) < 0.01 and math.abs(pos.z - 224.175) < 0.01 and pos.rot == 255,
            string.format('returned to %.3f, %.3f facing %d', pos.x, pos.z, pos.rot))
        assert(player:getMainJob() == xi.job.WAR and player:getSubJob() == xi.job.NIN, 'jobs were not restored')
    end)

    it('returns to the entrance when the death menu times out', function()
        player:setMonstrosityEntryData(219.288, -12, 224.175, 255, xi.zone.PORT_WINDURST, xi.job.WAR, xi.job.NIN)
        player:setHP(0)
        xi.test.world:tickEntity(player)
        xi.test.world:skipTime(3700)
        for _ = 1, 3 do
            xi.test.world:tickEntity(player)
            xi.test.world:skipTime(1)
        end

        assert(player:getZoneID() == xi.zone.PORT_WINDURST, string.format('went to zone %d', player:getZoneID()))
        assert(player:getMainJob() == xi.job.WAR, string.format('main job is %d', player:getMainJob()))
    end)

    it('sends a Monipulator with no recorded entry home as a WAR', function()
        player:setMonstrosityEntryData(0, 0, 0, 0, 0, 0, 0)
        xi.monstrosity.onMonstrosityReturnToEntrance(player)

        assert(player:getMainJob() == xi.job.WAR, string.format('main job is %d', player:getMainJob()))
    end)

    it('stops Relinquish when the player moves', function()
        startRelinquish()
        waitSeconds(4)
        player:setPos(player:getXPos() + 5, player:getYPos(), player:getZPos())
        waitSeconds(15)

        assert(player:getMainJob() == xi.job.MON, 'Relinquish carried on after moving')
    end)

    it('stops Relinquish when a monster uses a skill on the player', function()
        local mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:setUnkillable(true)
        player.entities:moveTo(mob:getID())
        startRelinquish()
        mob:useMobAbility(xi.mobSkill.FOOT_KICK_1, player, 0)
        for _ = 1, 15 do
            xi.test.world:skipTime(1)
            xi.test.world:tickEntity(mob)
            xi.test.world:tickEntity(player)
        end

        assert(player:getMainJob() == xi.job.MON, 'Relinquish carried on after Foot Kick')
    end)

    -- Retail answers a Monipulator at the Fort Ghelsba elevator lever with a bare release.
    it('cannot work a lever outside the Feretory', function()
        player:gotoZone(xi.zone.FORT_GHELSBA)
        player:delStatusEffect(xi.effect.GESTATION)
        local lever = player.entities:moveTo('_3x1')
        player.packets:clear()
        player.actions:trigger(lever)

        for _, pkt in pairs(player.packets:getIncoming()) do
            assert(pkt.type ~= 0x032 and pkt.type ~= 0x034, 'the lever started an event')
        end
    end)

    -- Gestation multiplies speed by 1.5, so a Wamouracampa stays slower than other species.
    it('speeds up by half under Gestation', function()
        player:addStatusEffect(xi.effect.GESTATION, { power = 0, duration = 60, origin = player })
        assert(player:getSpeed() == 75, string.format('Lizard speed is %d', player:getSpeed()))

        helpers.becomeSpecies(player, xi.monstrositySpecies.WAMOURACAMPA, xi.monstrositySpecies.WAMOURACAMPA, 1)
        player:addStatusEffect(xi.effect.GESTATION, { power = 0, duration = 60, origin = player })
        assert(player:getSpeed() == 45, string.format('Wamouracampa speed is %d', player:getSpeed()))
    end)

    it('warns that Gestation is about to wear off', function()
        player:addStatusEffect(xi.effect.GESTATION, { power = 0, duration = 15, tick = 10, origin = player })
        player.packets:clear()
        waitSeconds(12)

        local warned = false
        for _, pkt in pairs(player.packets:getIncoming()) do
            if
                pkt.type == 0x029 and
                pkt.data[0x18] + pkt.data[0x19] * 256 == xi.msg.basic.ABOUT_TO_WEAR_OFF
            then
                warned = true
            end
        end

        assert(warned, 'no warning before Gestation wore off')
    end)

    -- Retail marks a Monipulator in the party packet with 0x8000 and the species.
    it('flags the species in the party packet', function()
        player.packets:clear()
        helpers.sendGameOk(player)

        local flag = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x0DF then
                flag = pkt.data[0x1C] + pkt.data[0x1D] * 256
            end
        end

        local expected = 0x8000 + player:getMonstrosityData().species
        assert(flag == expected, string.format('0x0DF flag %s, expected %d', tostring(flag), expected))
    end)

    -- Retail sends BallistaFlg 0x09 in 0x037 under Belligerency outside the Feretory. Its 0x08 bit is bit 0 of byte 0x37.
    it('shows the Belligerency icon in the status packet', function()
        player:setBelligerencyFlag(true)
        player.packets:clear()
        player:gotoZone(xi.zone.WEST_RONFAURE)

        local shown = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x037 then
                shown = bit.band(pkt.data[0x37], 0x01) ~= 0
            end
        end

        assert(shown, string.format('0x037 shows the Belligerency icon: %s', tostring(shown)))
    end)

    -- Rank follows the infamy held, and is Mon outside Belligerency.
    describe('rank', function()
        local function shownRank()
            local rank = nil
            for _, pkt in pairs(player.packets:getIncoming()) do
                if pkt.type == 0x037 then
                    rank = bit.band(pkt.data[0x5A], 0x03)
                end
            end

            return rank
        end

        it('shows NM in the status packet once infamy passes 10,000 under Belligerency', function()
            player:setBelligerencyFlag(true)
            player:addCurrency('infamy', 9999)
            player.packets:clear()
            helpers.killWorm(player)

            local rank = shownRank()
            assert(rank == 1, string.format('0x037 shows rank %s', tostring(rank)))
        end)

        it('drops to Mon when Belligerency ends', function()
            player:setBelligerencyFlag(true)
            player:addCurrency('infamy', 10500)
            player.packets:clear()
            player:setBelligerencyFlag(false)

            local rank = shownRank()
            assert(rank == 0, string.format('0x037 shows rank %s', tostring(rank)))
        end)

        it('drops to Mon when infamy is spent below 10,001', function()
            player:setBelligerencyFlag(true)
            player:addCurrency('infamy', 10500)
            player.packets:clear()
            player:delCurrency('infamy', 3000)

            local rank = shownRank()
            assert(rank == 0, string.format('0x037 shows rank %s', tostring(rank)))
        end)
    end)

    it('recovers a twentieth of max HP a tick out of combat', function()
        player:setHP(1)
        waitSeconds(4)

        local gained = player:getHP() - 1
        assert(gained >= math.floor(player:getMaxHP() / 20), string.format('gained %d of %d HP', gained, player:getMaxHP()))
    end)

    it('recovers a twentieth of max MP a tick out of combat', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.BEE, onyxBee, 20)
        player:setMP(0)
        waitSeconds(4)

        assert(player:getMP() >= math.floor(player:getMaxMP() / 20), string.format('MP is %d of %d', player:getMP(), player:getMaxMP()))
    end)

    it('recovers no HP while a monster holds enmity', function()
        local mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:addStatusEffect(xi.effect.PETRIFICATION, { power = 1, duration = 600, origin = mob })
        mob:addEnmity(player, 1, 1)
        player:setHP(50)
        waitSeconds(4)

        assert(player:getHP() == 50, string.format('HP rose to %d with a monster on the player', player:getHP()))
    end)

    it('recovers no HP under slip damage', function()
        player:setHP(50)
        player:setMod(xi.mod.REGEN_DOWN, 1)
        waitSeconds(4)

        assert(player:getHP() <= 50, string.format('HP rose to %d under slip damage', player:getHP()))
    end)

    it('never starts Relinquish under slip damage', function()
        player:addStatusEffect(xi.effect.POISON, { power = 1, duration = 60, tick = 3, origin = player })
        startRelinquish()
        waitSeconds(15)

        assert(player:getMainJob() == xi.job.MON, 'Relinquish ran under Poison')
    end)

    it('never takes away infamy held above the cap', function()
        player:addCurrency('infamy', 15000)
        helpers.killWorm(player)

        assert(player:getCurrency('infamy') == 15000, string.format('infamy is %d', player:getCurrency('infamy')))
    end)

    -- Retail HP without merits.
    -- Bee is the JP wiki's +120%, the same as Rabbit.
    local retailHP =
    {
        { name = 'Lizard',     family = xi.monstrositySpecies.LIZARD,          hp = { [1] = 79, [5] = 276, [9] = 463 } },
        { name = 'Rabbit',     family = xi.monstrositySpecies.RABBIT,          hp = { [1] = 72, [2] = 110, [3] = 154, [4] = 200, [5] = 253, [6] = 292, [7] = 334, [8] = 378, [9] = 424 } },
        { name = 'Bee',        family = xi.monstrositySpecies.BEE,             hp = { [1] = 72, [5] = 253, [9] = 424 } },
        { name = 'Mandragora', family = xi.monstrositySpecies.MANDRAGORA,      hp = { [1] = 93 } },
        { name = 'Goobbue',    family = xi.monstrositySpecies.GOOBBUE,         hp = { [1] = 82, [7] = 380, [8] = 430, [9] = 482 } },
        { name = 'Slime',      family = xi.monstrositySpecies.ASTOLTIAN_SLIME, hp = { [1] = 79, [5] = 276, [9] = 463 }, species = 128 + xi.monstrositySpecies.ASTOLTIAN_SLIME },
    }

    for _, species in ipairs(retailHP) do
        it(string.format('gives a %s its retail HP', species.name), function()
            for level, expected in pairs(species.hp) do
                helpers.becomeSpecies(player, species.family, species.species or species.family, level)
                assert(player:getMaxHP() == expected, string.format('%s %d has %d HP, expected %d', species.name, level, player:getMaxHP(), expected))
            end
        end)
    end

    -- Retail Lizard and Rabbit share these. The fit is exact at 1 and up to 2 high later.
    it('gives a Lizard stats close to retail', function()
        local stats    = { xi.mod.STR, xi.mod.DEX, xi.mod.VIT, xi.mod.AGI, xi.mod.INT, xi.mod.MND, xi.mod.CHR }
        local expected =
        {
            [1]  = { 9, 9, 6, 8, 5, 5, 6 },
            [5]  = { 12, 12, 9, 10, 7, 7, 9 },
            [10] = { 17, 16, 13, 15, 11, 11, 12 },
            [15] = { 22, 21, 16, 19, 14, 14, 16 },
        }

        for level, values in pairs(expected) do
            helpers.becomeSpecies(player, xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, level)
            for idx, stat in ipairs(stats) do
                local diff = player:getStat(stat) - values[idx]
                if level == 1 then
                    assert(diff == 0, string.format('level 1 stat %d is %d, retail %d', idx, player:getStat(stat), values[idx]))
                else
                    assert(diff >= -1 and diff <= 2, string.format('level %d stat %d is %d, retail %d', level, idx, player:getStat(stat), values[idx]))
                end
            end
        end
    end)

    local function learnedAbilities(family, level)
        helpers.becomeSpecies(player, family, family, level)
        player.packets:clear()
        -- Rebuilds and resends the command table
        player:changeJob(xi.job.MON)

        local learned = {}
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x0AC then
                for id = 0, 511 do
                    local byte = pkt.data[0x44 + math.floor(id / 8)] or 0
                    if bit.band(byte, bit.lshift(1, id % 8)) ~= 0 then
                        learned[id] = true
                    end
                end
            end
        end

        return learned
    end

    -- Retail: the species' main job abilities at player levels, never Provoke, plus Relinquish.
    it('learns its species main job abilities except Provoke', function()
        local level1 = learnedAbilities(xi.monstrositySpecies.LIZARD, 1)
        assert(level1[xi.jobAbility.MIGHTY_STRIKES] and level1[xi.jobAbility.RELINQUISH], 'level 1 should have Mighty Strikes and Relinquish')
        assert(not level1[xi.jobAbility.BERSERK], 'Berserk is not learned until 15')

        local level20 = learnedAbilities(xi.monstrositySpecies.LIZARD, 20)
        assert(level20[xi.jobAbility.BERSERK], 'level 20 should have Berserk')
        assert(not level20[xi.jobAbility.PROVOKE], 'a Monipulator never learns Provoke')
    end)

    -- Ability id to the level it is learned at.
    local startingSpeciesAbilities =
    {
        {
            name      = 'Rabbit',
            family    = xi.monstrositySpecies.RABBIT,
            abilities =
            {
                [xi.jobAbility.MIGHTY_STRIKES] = 1,
                [xi.jobAbility.RELINQUISH]     = 1,
                [xi.jobAbility.BERSERK]        = 15,
            },
        },
        {
            name      = 'Mandragora',
            family    = xi.monstrositySpecies.MANDRAGORA,
            abilities =
            {
                [xi.jobAbility.HUNDRED_FISTS] = 1,
                [xi.jobAbility.RELINQUISH]    = 1,
                [xi.jobAbility.BOOST]         = 5,
                [xi.jobAbility.DODGE]         = 15,
            },
        },
        {
            name      = 'Bee',
            family    = xi.monstrositySpecies.BEE,
            abilities =
            {
                [xi.jobAbility.MIGHTY_STRIKES] = 1,
                [xi.jobAbility.RELINQUISH]     = 1,
                [xi.jobAbility.BERSERK]        = 15,
            },
        },
    }

    for _, species in ipairs(startingSpeciesAbilities) do
        it(string.format('gives a %s exactly its abilities from level 1 to 15', species.name), function()
            for level = 1, 15 do
                local learned = learnedAbilities(species.family, level)

                for id, learnLevel in pairs(species.abilities) do
                    assert((learned[id] == true) == (level >= learnLevel), string.format('%s %d: ability %d learned is %s', species.name, level, id, tostring(learned[id] == true)))
                end

                for id in pairs(learned) do
                    assert(species.abilities[id] ~= nil, string.format('%s %d: unexpected ability %d', species.name, level, id))
                end
            end
        end)
    end

    -- JP wiki: a Monipulator cannot /heal. The client hides it, so only a crafted 0x0E8 asks.
    it('refuses /heal', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, 30)
        local camp = ffi.new('uint8_t[8]')
        camp[4] = 1
        player.packets:send(0x0E8, camp, assert(ffi.sizeof(camp)))

        assert(player:getAnimation() ~= xi.animation.HEALING, 'a Monipulator started healing')
    end)

    -- The client never offers /mount either.
    it('refuses /mount', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, 30)
        player:addKeyItem(xi.keyItem.CHOCOBO_COMPANION)

        local mount = ffi.new('uint8_t[28]')
        local id    = player:getID()
        for byte = 0, 3 do
            mount[4 + byte] = bit.band(bit.rshift(id, byte * 8), 0xFF)
        end

        mount[8]  = bit.band(player:getTargID(), 0xFF)
        mount[9]  = bit.rshift(player:getTargID(), 8)
        mount[10] = 0x1A
        player.packets:send(0x01A, mount, assert(ffi.sizeof(mount)))

        player.assert.no:hasEffect(xi.effect.MOUNTED)
    end)
end)

-- Retail lists, and lets a Monipulator cast, the learned spells its species' jobs know at the
-- species level. Trusts stay listed but cannot be called.
describe('Monstrosity spellcasting', function()
    local onyxRabbit = 256 + xi.monstrosityVariant.ONYX_RABBIT

    ---@type CClientEntityPair
    local player

    -- Returns how many casts went off. Out-of-combat regen refills MP, so MP can't tell.
    local function cast(spellId, target)
        local casts = 0
        player:addListener('MAGIC_USE', 'TEST_MON_CAST', function()
            casts = casts + 1
        end)

        player:setMP(300)
        player.actions:useSpell(target, spellId)
        for _ = 1, 5 do
            xi.test.world:skipTime(2)
        end

        player:removeListener('TEST_MON_CAST')

        return casts
    end

    -- The spell list goes out once the client reports the zone loaded.
    local function listsSpell(spellId)
        player.packets:clear()
        helpers.sendGameOk(player)

        local listed = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x0AA then
                listed = bit.band(pkt.data[0x04 + math.floor(spellId / 8)] or 0, bit.lshift(1, spellId % 8)) ~= 0
            end
        end

        return listed
    end

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)

        for _, spellId in ipairs({ xi.magic.spell.STONE, xi.magic.spell.CURE, xi.magic.spell.WARP, xi.magic.spell.SHANTOTTO }) do
            player:addSpell(spellId, { silentLog = true })
        end

        -- Onyx Rabbit is WAR/BLM.
        helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, onyxRabbit, 20)
    end)

    it('lists the learned spells its species can cast, and its Trusts', function()
        assert(listsSpell(xi.magic.spell.STONE) == true, 'Stone should be listed')
        assert(listsSpell(xi.magic.spell.SHANTOTTO) == true, 'Shantotto should be listed')
        assert(listsSpell(xi.magic.spell.CURE) == false, 'Cure is not a WAR/BLM spell')
    end)

    it('casts a spell its species knows', function()
        -- Not a Tunnel Worm, which burrows out of reach.
        local mob = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:setAutoAttackEnabled(false)
        player.entities:moveTo(mob:getID())

        assert(cast(xi.magic.spell.STONE, mob) > 0, 'Stone was not cast')
    end)

    it('cannot cast a spell outside its species jobs', function()
        assert(cast(xi.magic.spell.CURE, player) == 0, 'a WAR/BLM cast Cure')
    end)

    it('cannot cast a travel spell its job knows', function()
        assert(cast(xi.magic.spell.WARP, player) == 0, 'a Monipulator cast Warp')
    end)

    it('cannot call a Trust', function()
        cast(xi.magic.spell.SHANTOTTO, player)

        assert(player:getPartySize() == 1, 'a Monipulator called a Trust')
    end)
end)

-- Retail level 10 status screens with no instincts, and a Metal Slime capture from levels 1-10.
-- HP and MP are checked at level 9, below the first HP merit step.
describe('Monstrosity slimes', function()
    ---@type CClientEntityPair
    local player

    local stats = { xi.mod.STR, xi.mod.DEX, xi.mod.VIT, xi.mod.AGI, xi.mod.INT, xi.mod.MND, xi.mod.CHR }

    local slimes =
    {
        { name = 'Slime',       species = 128 + xi.monstrositySpecies.ASTOLTIAN_SLIME, hp = 463, mp = 0,   stats = { 16, 16, 12, 18, 13,  9, 16 }, attack = 53, defence = 79  },
        { name = 'She-Slime',   species = 256 + xi.monstrosityVariant.SHE_SLIME,       hp = 463, mp = 0,   stats = { 16, 16, 12, 18, 13,  9, 16 }, attack = 63, defence = 79  },
        { name = 'Metal Slime', species = 256 + xi.monstrosityVariant.METAL_SLIME,     hp = 7,   mp = 374, stats = { 11, 16, 10, 18, 18, 10, 16 }, attack = 50, defence = 315 },
    }

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    for _, slime in ipairs(slimes) do
        it(string.format('gives a level 9 %s its retail HP and MP', slime.name), function()
            helpers.becomeSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME, slime.species, 9)

            assert(player:getMaxHP() == slime.hp, string.format('%d HP, retail %d', player:getMaxHP(), slime.hp))
            assert(player:getMaxMP() == slime.mp, string.format('%d MP, retail %d', player:getMaxMP(), slime.mp))
        end)

        it(string.format('gives a level 10 %s stats close to retail', slime.name), function()
            helpers.becomeSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME, slime.species, 10)

            for idx, stat in ipairs(stats) do
                local value = player:getStat(stat)
                assert(math.abs(value - slime.stats[idx]) <= 2, string.format('stat %d is %d, retail %d', idx, value, slime.stats[idx]))
            end

            local attack  = player:getStat(xi.mod.ATT)
            local defence = player:getStat(xi.mod.DEF)
            assert(math.abs(attack - slime.attack) <= 5, string.format('attack %d, retail %d', attack, slime.attack))
            assert(math.abs(defence - slime.defence) <= 15, string.format('defence %d, retail %d', defence, slime.defence))
        end)
    end

    -- Retail HP is the base slime's divided by 60, and MP is a full BLM's.
    it('gives a level 1 Metal Slime 1 HP and 94 MP', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME, 256 + xi.monstrosityVariant.METAL_SLIME, 1)

        assert(player:getMaxHP() == 1, string.format('%d HP', player:getMaxHP()))
        assert(player:getMaxMP() == 94, string.format('%d MP', player:getMaxMP()))
    end)

    it('runs Frizz as a Metal Slime', function()
        helpers.becomeSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME, 256 + xi.monstrosityVariant.METAL_SLIME, 10)

        local used = helpers.useMoveOnRabbit(player, 688)
        assert(used == 3127, string.format('expected mob skill 3127, got %s', tostring(used)))
    end)
end)

-- Retail Spriggan, Spriggan.C and Spriggan.G from a levels 1-10 capture, below the first HP merit step.
describe('Monstrosity Spriggans', function()
    ---@type CClientEntityPair
    local player

    local stats = { xi.mod.STR, xi.mod.DEX, xi.mod.VIT, xi.mod.AGI, xi.mod.INT, xi.mod.MND, xi.mod.CHR }

    -- Spriggan.C shares the plain Spriggan's values but for five sixths of its defence.
    local plain =
    {
        [1] = { hp = 72,  mp = 47,  stats = {  9,  8,  7,  7,  6,  6,  6 } },
        [5] = { hp = 249, mp = 117, stats = { 13, 10, 10,  9,  8,  9,  9 } },
        [9] = { hp = 417, mp = 187, stats = { 17, 13, 14, 12, 11, 12, 11 } },
    }

    local spriggans =
    {
        { name = 'Spriggan',   species = 128 + xi.monstrositySpecies.EORZEAN_SPRIGGAN, defence = 46, levels = plain },
        { name = 'Spriggan.C', species = 256 + xi.monstrosityVariant.SPRIGGAN_C,       defence = 39, levels = plain },
        {
            name    = 'Spriggan.G',
            species = 256 + xi.monstrosityVariant.SPRIGGAN_G,
            defence = 44,
            levels  =
            {
                [1] = { hp = 56,  mp = 94,  stats = {  7,  8,  6,  7,  8,  7,  6 } },
                [5] = { hp = 195, mp = 234, stats = { 10, 10,  9,  9, 11, 10,  9 } },
                [9] = { hp = 325, mp = 374, stats = { 13, 13, 12, 12, 15, 13, 11 } },
            },
        },
    }

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    for _, spriggan in ipairs(spriggans) do
        it(string.format('gives a %s its retail HP, MP and stats', spriggan.name), function()
            for level, retail in pairs(spriggan.levels) do
                helpers.becomeSpecies(player, xi.monstrositySpecies.EORZEAN_SPRIGGAN, spriggan.species, level)

                assert(player:getMaxHP() == retail.hp, string.format('level %d has %d HP, retail %d', level, player:getMaxHP(), retail.hp))
                assert(player:getMaxMP() == retail.mp, string.format('level %d has %d MP, retail %d', level, player:getMaxMP(), retail.mp))
                for idx, stat in ipairs(stats) do
                    local value = player:getStat(stat)
                    assert(math.abs(value - retail.stats[idx]) <= 2, string.format('level %d stat %d is %d, retail %d', level, idx, value, retail.stats[idx]))
                end
            end
        end)

        it(string.format('gives a level 5 %s close to its retail defence', spriggan.name), function()
            helpers.becomeSpecies(player, xi.monstrositySpecies.EORZEAN_SPRIGGAN, spriggan.species, 5)

            local defence = player:getStat(xi.mod.DEF)
            assert(math.abs(defence - spriggan.defence) <= 3, string.format('defence %d, retail %d', defence, spriggan.defence))
        end)
    end
end)
