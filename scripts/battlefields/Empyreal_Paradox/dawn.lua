-----------------------------------
-- Area: Empyreal_Paradox
-- Name: Dawn
-- instance 1 Promathia !pos -520 -119 524
-- instance 2 Promathia !pos 521 -0.500 517
-- instance 3 Promathia !pos -519 120 -520
-----------------------------------
local empyrealParadoxID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.EMPYREAL_PARADOX,
    battlefieldId = xi.battlefield.id.DAWN,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = 'TR_Entrance',
    exitNpc       = 'Transcendental_Radiance',
    missionArea   = xi.mission.log_id.COP,
    mission       = xi.mission.id.cop.DAWN,
    requiredVar   = 'Mission[6][840]Status',
    requiredValue = 1,
    hasWipeGrace  = false,

    grantXP = 2000,
    title   = xi.title.AVERTER_OF_THE_APOCALYPSE,
})

local playerCoords =
{
    [1] = { x = -520.000, y = -120.000, z =  493.778, r = 190 },
    [2] = { x =  520.000, y =    0.000, z =  493.778, r = 190 },
    [3] = { x = -520.000, y =  120.000, z = -545.538, r = 190 },
}

local prisheCoords =
{
    [1] = { x = -526.678, y = -120.000, z =  509.175, r = 192 },
    [2] = { x =  513.225, y =    0.000, z =  509.710, r = 192 },
    [3] = { x = -527.256, y =  120.000, z = -533.638, r = 192 },
}

local selhteusCoords =
{
    [1] = { x = -513.769, y = -120.000, z =  509.175, r = 170 },
    [2] = { x =  531.881, y =    0.000, z =  510.375, r = 170 },
    [3] = { x = -506.980, y =  120.000, z = -533.638, r = 170 },
}

function content:setupBattlefield(battlefield)
    local battlefieldArea = battlefield:getArea()
    local initiatorId, _  = battlefield:getInitiator()
    local initiator       = GetPlayerByID(initiatorId)
    if initiator then
        battlefield:setLocalVar('initRace', initiator:getRace())
    end

    local prishe    = battlefield:insertEntity(11, true, true)
    local prishePos = prisheCoords[battlefieldArea]
    prishe:setSpawn(prishePos.x, prishePos.y, prishePos.z, prishePos.r)
    prishe:spawn()

    local selhteus    = battlefield:insertEntity(12, true, true)
    local selhteusPos = selhteusCoords[battlefieldArea]
    selhteus:setSpawn(selhteusPos.x, selhteusPos.y, selhteusPos.z, selhteusPos.r)
    selhteus:spawn()
end

function content:onEventFinishBattlefield(player, csid, option, npc)
    local battlefield     = player:getBattlefield()
    local battlefieldArea = battlefield:getArea()
    local phaseTwoMobId   = empyrealParadoxID.mob.PROMATHIA + (battlefieldArea - 1) * 2 + 1
    local playerPos       = playerCoords[battlefieldArea]

    player:setPos(playerPos.x, playerPos.y, playerPos.z, playerPos.r)

    -- Bail out if anyone else got here first
    if GetMobByID(phaseTwoMobId):isSpawned() then
        return
    end

    -- Spawn Promathia phase 2
    SpawnMob(phaseTwoMobId)
end

function content:onEventFinishWin(player, csid, option, npc)
    player:setPos(540, 0, -514, 63, xi.zone.EMPYREAL_PARADOX)
end

content.groups =
{
    {
        mobIds =
        {
            { empyrealParadoxID.mob.PROMATHIA     },
            { empyrealParadoxID.mob.PROMATHIA + 2 },
            { empyrealParadoxID.mob.PROMATHIA + 4 },
        },

        allDeath = function(battlefield, mob)
            local battlefieldArea = battlefield:getArea()

            -- Reposition Prishe and Selhteus
            local bcnmAllies = battlefield:getAllies()
            for _, ally in pairs(bcnmAllies) do
                if ally:isMob() then
                    ally:resetLocalVars()

                    if ally:getPool() == xi.mobPools.PRISHE_DAWN then
                        local prishePos = prisheCoords[battlefieldArea]
                        ally:setPos(prishePos.x, prishePos.y, prishePos.z, prishePos.r)

                        -- Reset Prishe's engage wait time
                        ally:setLocalVar('[helperNpc]engageWaitTime', 180)
                        ally:setLocalVar('engageWait', GetSystemTime() + 180)

                    elseif ally:getPool() == xi.mobPools.SELHTEUS_DAWN then
                        local selhteusPos = selhteusCoords[battlefieldArea]
                        ally:setPos(selhteusPos.x, selhteusPos.y, selhteusPos.z, selhteusPos.r)
                    end
                end
            end

            local players = battlefield:getPlayers()
            for _, player in pairs(players) do
                player:startEvent(32004, battlefieldArea)
            end
        end,
    },

    {
        mobIds =
        {
            { empyrealParadoxID.mob.PROMATHIA + 1 },
            { empyrealParadoxID.mob.PROMATHIA + 3 },
            { empyrealParadoxID.mob.PROMATHIA + 5 },
        },

        spawned  = false,
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
