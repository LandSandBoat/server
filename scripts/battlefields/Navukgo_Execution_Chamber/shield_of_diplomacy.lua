-----------------------------------
-- Area: Navukgo Execution Chamber
-- BCNM: TOAU-22 Shield of Diplomacy
-----------------------------------
local navukgoID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.NAVUKGO_EXECUTION_CHAMBER,
    battlefieldId         = xi.battlefield.id.SHIELD_OF_DIPLOMACY,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 99,
    timeLimit             = utils.minutes(30),
    index                 = 4,
    allowedAreas          = set{ 1 },
    entryNpc              = '_1s0',
    exitNpcs              = { '_1s1', '_1s2', '_1s3' },
    missionArea           = xi.mission.log_id.TOAU,
    mission               = xi.mission.id.toau.SHIELD_OF_DIPLOMACY,
    missionStatusArea     = xi.mission.log_id.TOAU,
    requiredMissionStatus = 2,
})

function content:setupBattlefield(battlefield)
    -- NOTE: Like Khimaira, Karababa only has a valid position for area one, and will need to be added
    -- if future areas are enabled.

    -- TODO: Karababa does not appear to contain spell lists as well.  Currently has a standback behavior,
    -- and will melee if Khimaira is brought into range.
    local karababaCoords =
    {
        [1] = { 361.488, -116.500, 382.511, 0 },
        [2] = {       0,        0,       0, 0 },
        [3] = {       0,        0,       0, 0 },
    }

    local karababa = battlefield:insertEntity(8, true, true)
    karababa:setSpawn(unpack(karababaCoords[battlefield:getArea()]))
    karababa:spawn()
end

content.groups =
{
    {
        mobIds =
        {
            { navukgoID.mob.KHIMAIRA_13     },
            { navukgoID.mob.KHIMAIRA_13 + 2 },
            { navukgoID.mob.KHIMAIRA_13 + 4 },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
