-- Coverage for Monstrosity TP moves.
--
-- The client sends a DAT skill id, which the server translates through
-- monstrosity_tp_skills into a mob skill id and a fixed TP cost. Unlike a mob,
-- a Monstrosity player spends only that cost rather than the whole TP bar.
--
-- Values here come from retail captures of a Lizard levelling 1-15:
--   Fireball  (DAT 343 -> mob skill 367) cost 1000 TP (1273 +75 melee -> 348)
--   Secretion (DAT 349 -> mob skill 373) cost  500 TP (669 -> 169)
-- A rejected move answers with msg_basic 88 over BATTLE_MESSAGE and spends nothing.

describe('Monstrosity mobskills', function()
    local lizardSpecies = 43

    local fireballDat   = 343
    local fireballMob   = 367
    local fireballCost  = 1000

    local secretionDat  = 349
    local secretionMob  = 373
    local secretionCost = 500

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
        data.monstrosityId = lizardSpecies
        data.species       = lizardSpecies
        player:setMonstrosityData(data)
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

    it('rejects an unknown DAT skill id and spends nothing', function()
        local usedSkill = watchSkill()
        player:setTP(3000)
        player.actions:useMonsterSkill(target, 9999)

        assert(usedSkill() == nil, 'skill should not have started')
        assert(player:getTP() == 3000, string.format('TP=%d, expected untouched', player:getTP()))
    end)
end)

-- The MON exp curve is its own table, not the standard job curve. These
-- thresholds are read from retail captures (Lizard 1-15, Spriggan 9-40);
-- levels 4 and 5 are where the commonly-cited wiki table is wrong.
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
