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

-- Reports the zone loaded, which is when the server sends the Monstrosity data and spell list.
---@param player CClientEntityPair
function helpers.sendGameOk(player)
    local gameOk = ffi.new('uint8_t[12]')
    player.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))
end

return helpers
