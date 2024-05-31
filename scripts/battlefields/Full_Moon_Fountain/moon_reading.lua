-----------------------------------
-- Area: Full Moon Mountain
-- Name: Windurst Mission 9-2 Moon Reading
-----------------------------------
local fullMoonFountainID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.FULL_MOON_FOUNTAIN,
    battlefieldId         = xi.battlefield.id.MOON_READING,
    isMission             = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 1,
    entryNpc              = 'MS_Entrance',
    exitNpc               = 'Moon_Spiral',
    missionArea           = xi.mission.log_id.WINDURST,
    mission               = xi.mission.id.windurst.MOON_READING,
    missionStatusArea     = xi.mission.log_id.WINDURST,
    requiredMissionStatus = 2,
})

function content:onEventFinishBattlefield(player, csid, option, npc)
    local playerCoords =
    {
        [1] = { -400, -201,  419, 61 },
        [2] = {    0,   -1,   10, 61 },
        [3] = {  399,  198, -381, 57 },
    }

    local ajidoCoords =
    {
        [1] = { -403, -201,  413, 58 },
        [2] = {   -3,   -1,    4, 61 },
        [3] = {  397,  198, -395, 64 },
    }

    local battlefield     = player:getBattlefield()
    local battlefieldArea = battlefield:getArea()
    local phaseTwoOffset  = fullMoonFountainID.mob.ACE_OF_CUPS + (battlefield:getArea() - 1) * 6 + 4

    -- Bail out if anyone else got here first
    for phaseTwoMobId = phaseTwoOffset, phaseTwoOffset + 1 do
        if GetMobByID(phaseTwoMobId):isSpawned() then
            return
        end
    end

    -- Set up the Arena for Phase 2
    for phaseTwoMobId = phaseTwoOffset, phaseTwoOffset + 1 do
        SpawnMob(phaseTwoMobId)
    end

    -- Spawn Trion (Ally)
    local ajido = player:getBattlefield():insertEntity(33, true, true)
    player:setPos(unpack(playerCoords[battlefieldArea]))
    ajido:setSpawn(unpack(ajidoCoords[battlefieldArea]))
    ajido:spawn()
end

content.groups =
{
    {
        mobIds =
        {
            {
                fullMoonFountainID.mob.ACE_OF_CUPS,
                fullMoonFountainID.mob.ACE_OF_CUPS + 1,
                fullMoonFountainID.mob.ACE_OF_CUPS + 2,
                fullMoonFountainID.mob.ACE_OF_CUPS + 3,
            },

            {
                fullMoonFountainID.mob.ACE_OF_CUPS + 6,
                fullMoonFountainID.mob.ACE_OF_CUPS + 7,
                fullMoonFountainID.mob.ACE_OF_CUPS + 8,
                fullMoonFountainID.mob.ACE_OF_CUPS + 9,
            },

            {
                fullMoonFountainID.mob.ACE_OF_CUPS + 12,
                fullMoonFountainID.mob.ACE_OF_CUPS + 13,
                fullMoonFountainID.mob.ACE_OF_CUPS + 14,
                fullMoonFountainID.mob.ACE_OF_CUPS + 15,
            },
        },

        superlink = true,
        allDeath  = function(battlefield, mob)
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(32004, 1, 0, 1, 0, 1)
            end
        end,
    },

    {
        mobIds =
        {
            {
                fullMoonFountainID.mob.ACE_OF_CUPS + 4,
                fullMoonFountainID.mob.ACE_OF_CUPS + 5,
            },

            {
                fullMoonFountainID.mob.ACE_OF_CUPS + 10,
                fullMoonFountainID.mob.ACE_OF_CUPS + 11,
            },

            {
                fullMoonFountainID.mob.ACE_OF_CUPS + 16,
                fullMoonFountainID.mob.ACE_OF_CUPS + 17,
            },
        },

        spawned   = false,
        superlink = true,
        allDeath  = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
