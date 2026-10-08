-- Rules a Monipulator plays under, from the JP wiki's Monstrosity pages.
local ffi = require('ffi')

describe('Monstrosity restrictions', function()
    ---@type CClientEntityPair
    local player

    local function becomeSpecies(family, speciesCode, level)
        local data = player:getMonstrosityData()
        data.monstrosityId  = family
        data.species        = speciesCode
        data.levels[family] = level
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end

    local function killWorm()
        local mob = player.entities:moveTo('Tunnel_Worm')
        mob:respawn()
        mob:updateClaim(player)
        mob:takeDamage(mob:getHP(), player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
        for _ = 1, 3 do
            xi.test.world:tickEntity(mob)
            xi.test.world:skipTime(1)
        end
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
    end)

    -- Each family unlocks an instinct at 30, 60 and 90, held as a 2-bit count.
    it('unlocks a level instinct every 30 levels', function()
        becomeSpecies(xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 65)

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
        becomeSpecies(xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 15)
        player.assert:hasEffect(xi.effect.GESTATION)

        local mob = player.entities:moveTo('Tunnel_Worm')
        mob:respawn()
        player:setTP(3000)
        player.actions:useMonsterSkill(mob, 343)

        assert(player:getTP() == 3000, string.format('Fireball went off under Gestation, TP=%d', player:getTP()))
        player.assert:hasEffect(xi.effect.GESTATION)
    end)

    it('stops infamy at the cap without Belligerency', function()
        player:addCurrency('infamy', 9999)
        killWorm()

        assert(player:getCurrency('infamy') == 10000, string.format('infamy is %d', player:getCurrency('infamy')))
    end)

    it('stops infamy at the higher cap under Belligerency', function()
        player:setBelligerencyFlag(true)
        player:addCurrency('infamy', 49999)
        killWorm()

        assert(player:getCurrency('infamy') == 50000, string.format('infamy is %d', player:getCurrency('infamy')))
    end)

    it('drops MON behaviour as soon as the job changes away from MON', function()
        becomeSpecies(xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, 10)
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

    it('refuses Relinquish off MON', function()
        player:changeJob(xi.job.WAR)
        local relinquish = require('scripts/actions/abilities/relinquish')

        -- The check ignores the ability, and a test has no CAbility to pass.
        ---@diagnostic disable-next-line: param-type-mismatch
        assert(relinquish.onAbilityCheck(player, player, nil) == xi.msg.basic.UNABLE_TO_USE_JA2, 'a WAR could Relinquish')
    end)

    it('never takes away infamy held above the cap', function()
        player:addCurrency('infamy', 15000)
        killWorm()

        assert(player:getCurrency('infamy') == 15000, string.format('infamy is %d', player:getCurrency('infamy')))
    end)

    -- Retail HP without merits.
    -- Bee is the JP wiki's +120%, the same as Rabbit.
    local retailHP =
    {
        { name = 'Lizard',     family = xi.monstrositySpecies.LIZARD,     hp = { [1] = 79, [5] = 276, [9] = 463 } },
        { name = 'Rabbit',     family = xi.monstrositySpecies.RABBIT,     hp = { [1] = 72, [2] = 110, [3] = 154, [4] = 200, [5] = 253, [6] = 292, [7] = 334, [8] = 378, [9] = 424 } },
        { name = 'Bee',        family = xi.monstrositySpecies.BEE,        hp = { [1] = 72, [5] = 253, [9] = 424 } },
        { name = 'Mandragora', family = xi.monstrositySpecies.MANDRAGORA, hp = { [1] = 93 } },
    }

    for _, species in ipairs(retailHP) do
        it(string.format('gives a %s its retail HP', species.name), function()
            for level, expected in pairs(species.hp) do
                becomeSpecies(species.family, species.family, level)
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
            becomeSpecies(xi.monstrositySpecies.LIZARD, xi.monstrositySpecies.LIZARD, level)
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
        becomeSpecies(family, family, level)
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
        assert(level1[16] and level1[382], 'level 1 should have Mighty Strikes and Relinquish')
        assert(not level1[31], 'Berserk is not learned until 15')

        local level20 = learnedAbilities(xi.monstrositySpecies.LIZARD, 20)
        assert(level20[31], 'level 20 should have Berserk')
        assert(not level20[35], 'a Monipulator never learns Provoke')
    end)

    -- Ability id to the level it is learned at.
    local startingSpeciesAbilities =
    {
        { name = 'Rabbit',     family = xi.monstrositySpecies.RABBIT,     abilities = { [16] = 1, [382] = 1, [31] = 15 } },
        { name = 'Mandragora', family = xi.monstrositySpecies.MANDRAGORA, abilities = { [17] = 1, [382] = 1, [39] = 5, [37] = 15 } },
        { name = 'Bee',        family = xi.monstrositySpecies.BEE,        abilities = { [16] = 1, [382] = 1, [31] = 15 } },
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
end)

-- Retail lists, and lets a Monipulator cast, the learned spells its species' jobs know at the
-- species level. Trusts stay listed but cannot be called.
describe('Monstrosity spellcasting', function()
    local onyxRabbit = 256

    ---@type CClientEntityPair
    local player

    -- Casts and reports the MP it cost.
    local function cast(spellId, target)
        player:setMP(300)
        player.actions:useSpell(target, spellId)
        for _ = 1, 5 do
            xi.test.world:skipTime(2)
        end

        return 300 - player:getMP()
    end

    -- The spell list goes out once the client reports the zone loaded.
    local function listsSpell(spellId)
        player.packets:clear()
        local gameOk = ffi.new('uint8_t[12]')
        player.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))

        local listed = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x0AA then
                listed = bit.band(pkt.data[0x04 + math.floor(spellId / 8)] or 0, bit.lshift(1, spellId % 8)) ~= 0
            end
        end

        return listed
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)

        for _, spellId in ipairs({ xi.magic.spell.STONE, xi.magic.spell.CURE, xi.magic.spell.WARP, xi.magic.spell.SHANTOTTO }) do
            player:addSpell(spellId, { silentLog = true })
        end

        -- Onyx Rabbit is WAR/BLM.
        local data = player:getMonstrosityData()
        data.monstrosityId                        = xi.monstrositySpecies.RABBIT
        data.species                              = onyxRabbit
        data.levels[xi.monstrositySpecies.RABBIT] = 20
        player:setMonstrosityData(data)
        player.packets:clear()
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:delStatusEffect(xi.effect.GESTATION)
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

        assert(cast(xi.magic.spell.STONE, mob) > 0, string.format('Stone was not cast, %d MP of %d', player:getMP(), player:getMaxMP()))
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
