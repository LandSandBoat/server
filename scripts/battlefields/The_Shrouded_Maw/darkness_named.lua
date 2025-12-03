-----------------------------------
-- Darkness Named
-- The Shrouded Maw mission battlefield
-----------------------------------
local shroudedMawID = zones[xi.zone.THE_SHROUDED_MAW]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.THE_SHROUDED_MAW,
    battlefieldId = xi.battlefield.id.DARKNESS_NAMED,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 40,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = 'MC_Entrance',
    exitNpc       = 'Memento_Circle',
    missionArea   = xi.mission.log_id.COP,
    mission       = xi.mission.id.cop.DARKNESS_NAMED,
    requiredVar   = 'Mission[6][358]Status',
    requiredValue = 4,

    grantXP = 1000,
})

function content:setupBattlefield(battlefield)
    local tileOffset = shroudedMawID.npc.DARKNESS_NAMED_TILE_OFFSET + (battlefield:getArea() - 1) * 8

    for tileId = tileOffset, tileOffset + 7 do
        GetNPCByID(tileId):setAnimation(xi.anim.CLOSE_DOOR)
    end
end

-- Arena boundaries: Defined like regular rectangular regions.
local arenaBoxes =
{
-- [area] = { x(min), x(max), y(min), y(max), z(min), z(max) }
    [1] = { -250, -230, -46, -25,  275,  294 }, -- Area 1
    [2] = {  -10,   10,   0,  13,   -6,   14 }, -- Area 2
    [3] = {  270,  290,  35,  52, -286, -266 }, -- Area 3
}

local isPlayerInArenaBox = function(player, area)
    local playerX = player:getXPos()
    local playerY = player:getYPos()
    local playerZ = player:getZPos()
    local xCheck  = playerX >= area[1] and playerX <= area[2]
    local yCheck  = playerY >= area[3] and playerY <= area[4]
    local zCheck  = playerZ >= area[5] and playerZ <= area[6]

    return xCheck and yCheck and zCheck
end

local handleDiremiteEnmityReset = function(diremite, battlefield)
    if not diremite:isAlive() or not diremite:isEngaged() then
        return
    end

    -- Did a player fall out of the arena?
    local box = arenaBoxes[battlefield:getArea()]
    local players = battlefield:getPlayers()
    local allPlayersInArena = true

    for _, player in ipairs(players) do
        local inArena = isPlayerInArenaBox(player, box)
        local wasInPit = player:getLocalVar('inDiremitePit') == 1

        if not inArena then
            allPlayersInArena = false
            -- Mark player as in pit
            if not wasInPit then
                player:setLocalVar('inDiremitePit', 1)
            end
        -- Player is in arena - reset enmity if they just came from pit
        elseif wasInPit then
            diremite:resetEnmity(player)
            player:setLocalVar('inDiremitePit', 0)
        end
    end

    -- If all players are in the arena, disengage the Diremite completely
    -- Diremites despawn if too far from spawn, controlled in diremite.lua
    if allPlayersInArena then
        diremite:disengage()
    end
end

-- Diremites respawn 10 seconds after death
local handleDiremiteRespawn = function(diremite)
    if not diremite:isAlive() then
        local deathTime = diremite:getLocalVar('deathTime')

        if deathTime > 0 and (GetSystemTime() - deathTime) >= 10 then
            diremite:setLocalVar('deathTime', 0)
            SpawnMob(diremite:getID())
        end
    end
end

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local areaOffset = (battlefield:getArea() - 1) * 7
    local baseID = shroudedMawID.mob.DIABOLOS + areaOffset

    -- Check Diremites (offsets 1-6 from base)
    for i = 1, 6 do
        local diremite = GetMobByID(baseID + i)
        if diremite then
            handleDiremiteRespawn(diremite)
            handleDiremiteEnmityReset(diremite, battlefield)
        end
    end
end

content.groups =
{
    {
        mobIds =
        {
            { shroudedMawID.mob.DIABOLOS      },
            { shroudedMawID.mob.DIABOLOS + 7  },
            { shroudedMawID.mob.DIABOLOS + 14 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },

    {
        mobIds =
        {
            {
                shroudedMawID.mob.DIABOLOS + 1,
                shroudedMawID.mob.DIABOLOS + 2,
                shroudedMawID.mob.DIABOLOS + 3,
                shroudedMawID.mob.DIABOLOS + 4,
                shroudedMawID.mob.DIABOLOS + 5,
                shroudedMawID.mob.DIABOLOS + 6,
            },

            {
                shroudedMawID.mob.DIABOLOS + 8,
                shroudedMawID.mob.DIABOLOS + 9,
                shroudedMawID.mob.DIABOLOS + 10,
                shroudedMawID.mob.DIABOLOS + 11,
                shroudedMawID.mob.DIABOLOS + 12,
                shroudedMawID.mob.DIABOLOS + 13,
            },

            {
                shroudedMawID.mob.DIABOLOS + 15,
                shroudedMawID.mob.DIABOLOS + 16,
                shroudedMawID.mob.DIABOLOS + 17,
                shroudedMawID.mob.DIABOLOS + 18,
                shroudedMawID.mob.DIABOLOS + 19,
                shroudedMawID.mob.DIABOLOS + 20,
            },
        },

        superlink = true,
    },
}

return content:register()
