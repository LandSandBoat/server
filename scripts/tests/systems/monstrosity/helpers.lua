-----------------------------------
-- Monipulator setup and packet readers shared by the Monstrosity tests.
-----------------------------------
local ffi = require('ffi')

local helpers = {}

-- Monstrosity data loads when a character whose main job is MON enters a zone, so the job
-- change has to be followed by a zone reload.
---@param zone xi.zone
---@return CClientEntityPair
function helpers.spawnMonipulator(zone)
    xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)

    local player = xi.test.world:spawnPlayer({ zone = zone })
    player:changeJob(xi.job.MON)
    player:gotoZone(zone)

    return player
end

-- Zones back in as the species with Gestation removed. A variant's species code is 256 plus
-- its variant id.
---@param player CClientEntityPair
---@param family integer
---@param speciesCode integer
---@param level integer
function helpers.becomeSpecies(player, family, speciesCode, level)
    local data = player:getMonstrosityData()
    data.monstrosityId  = family
    data.species        = speciesCode
    data.levels[family] = level
    player:setMonstrosityData(data)
    player:gotoZone(xi.zone.WEST_RONFAURE)
    player:delStatusEffect(xi.effect.GESTATION)
end

-- Being engaged stops the out-of-combat HP recovery, so HP checks stay exact. The rabbit can't fight back.
---@param player CClientEntityPair
function helpers.engageDummy(player)
    local mob = player.entities:moveTo('Wild_Rabbit')
    mob:respawn()
    mob:setUnkillable(true)
    mob:addStatusEffect(xi.effect.PETRIFICATION, { power = 1, duration = 600, origin = mob })
    player.actions:engage(mob)
end

-- A Monstrosity move pays its TP when it fires, after the ready time.
---@param player CClientEntityPair
function helpers.waitForMove(player)
    for _ = 1, 4 do
        xi.test.world:skipTime(1)
        xi.test.world:tickEntity(player)
    end
end

-- A move that lands returns some TP, more for a multi-hit move, so the bar ends at least the cost below the start.
-- A damaging move returns about 75 TP a hit, and 200 covers a two-hit move.
---@param player CClientEntityPair
---@param start integer
---@param cost integer
function helpers.assertSpent(player, start, cost)
    local tp = player:getTP()
    assert(tp >= start - cost and tp < start - cost + 200, string.format('TP=%d after a %d TP move from %d', tp, cost, start))
end

-- Returns the exp the kill paid. A mob level also makes the worm count two levels lower.
---@param player CClientEntityPair
---@param mobLevel integer?
---@return integer
function helpers.killWorm(player, mobLevel)
    local gained = 0
    player:addListener('EXPERIENCE_POINTS', 'TEST_MON_KILL_EXP', function(_, _, exp)
        gained = gained + exp
    end)

    local mob = player.entities:moveTo('Tunnel_Worm')
    mob:respawn()
    if mobLevel then
        mob:setMobLevel(mobLevel)
        mob:setMod(xi.mod.EXP_LVL_MOD, -2)
    end

    mob:updateClaim(player)
    mob:takeDamage(mob:getHP(), player, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    for _ = 1, 3 do
        xi.test.world:tickEntity(mob)
        xi.test.world:skipTime(1)
    end

    player:removeListener('TEST_MON_KILL_EXP')

    return gained
end

-- Returns a getter for the mob skill id the AI entered, which proves the DAT id was
-- translated rather than passed straight through.
---@param player CClientEntityPair
---@return fun(): integer?
function helpers.watchSkill(player)
    local used = nil
    player:addListener('WEAPONSKILL_STATE_ENTER', 'TEST_MON_SKILL', function(_, skillId)
        used = skillId
    end)

    return function()
        return used
    end
end

-- Uses a move on a fresh Wild Rabbit with full TP. Returns the mob skill id the AI entered, if any.
---@param player CClientEntityPair
---@param datSkillId integer
---@return integer?
function helpers.useMoveOnRabbit(player, datSkillId)
    local mob = player.entities:moveTo('Wild_Rabbit')
    mob:respawn()
    player.entities:moveTo(mob:getID())

    local usedSkill = helpers.watchSkill(player)
    player:setTP(3000)
    player.actions:useMonsterSkill(mob, datSkillId)
    player:removeListener('TEST_MON_SKILL')

    return usedSkill()
end

-- exp_now in the last CLISTATUS received.
---@param player CClientEntityPair
---@return integer?
function helpers.currentExp(player)
    local exp = nil
    for _, pkt in pairs(player.packets:getIncoming()) do
        if pkt.type == 0x061 then
            exp = pkt.data[0x10] + pkt.data[0x11] * 256
        end
    end

    return exp
end

-- The first param of every event update the server sent since the last clear.
---@param player CClientEntityPair
---@return integer[]
function helpers.updateReplies(player)
    local replies = {}
    for _, pkt in pairs(player.packets:getIncoming()) do
        if pkt.type == 0x05C then
            table.insert(replies, pkt.data[0x04] + pkt.data[0x05] * 0x100 + pkt.data[0x06] * 0x10000 + pkt.data[0x07] * 0x1000000)
        end
    end

    return replies
end

-- Reports the zone loaded, which is when the server sends the Monstrosity data and spell list.
---@param player CClientEntityPair
function helpers.sendGameOk(player)
    local gameOk = ffi.new('uint8_t[12]')
    player.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))
end

return helpers
