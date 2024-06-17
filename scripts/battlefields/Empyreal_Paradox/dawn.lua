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

    grantXP = 2000,
    title   = xi.title.AVERTER_OF_THE_APOCALYPSE,
})

function content:setupBattlefield(battlefield)
    battlefield:setLocalVar('instantKick', 1)
    local baseID = empyrealParadoxID.mob.PROMATHIA + (battlefield:getArea() - 1) * 2
    local pos    = GetMobByID(baseID):getSpawnPos()

    -- TODO: Get table of spawn positions for Allies and set exactly.  Rot value
    -- is not accurate.  lookAt is used to workaround at this time.

    local prishe = battlefield:insertEntity(11, true, true)
    prishe:setSpawn(pos.x - 6, pos.y, pos.z - 21.5, 192)
    prishe:lookAt(pos)
    prishe:spawn()

    local selhteus = battlefield:insertEntity(12, true, true)
    selhteus:setSpawn(pos.x + 10, pos.y, pos.z - 17.5, 172)
    prishe:lookAt(pos)
    selhteus:spawn()
end

function content:onEventFinishBattlefield(player, csid, option, npc)
    local battlefield     = player:getBattlefield()
    local battlefieldArea = battlefield:getArea()
    local phaseTwoMobId   = empyrealParadoxID.mob.PROMATHIA + (battlefieldArea - 1) * 2 + 1

    -- Bail out if anyone else got here first
    if GetMobByID(phaseTwoMobId):isSpawned() then
        return
    end

    -- Set up the Arena for Phase 2
    SpawnMob(phaseTwoMobId)

    -- Reset allies
    local bcnmAllies = battlefield:getAllies()
    for _, ally in pairs(bcnmAllies) do
        ally:resetLocalVars()
        local spawn = ally:getSpawnPos()
        ally:setPos(spawn.x, spawn.y, spawn.z, spawn.rot)
    end
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
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(32004, battlefield:getArea())
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
