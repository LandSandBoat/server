-----------------------------------
-- Heir to the Light
-- Qu'Bia Arena mission battlefield
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.QUBIA_ARENA,
    battlefieldId         = xi.battlefield.id.HEIR_TO_THE_LIGHT,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 75,
    timeLimit             = utils.minutes(30),
    index                 = 4,
    entryNpc              = 'BC_Entrance',
    exitNpc               = 'Burning_Circle',
    missionArea           = xi.mission.log_id.SANDORIA,
    mission               = xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT,
    missionStatusArea     = xi.mission.log_id.SANDORIA,
    requiredMissionStatus = 3,
})

function content:onEventFinishBattlefield(player, csid, option, npc)
    local playerCoords =
    {
        [1] = { -400, -201,  419, 61 },
        [2] = {    0,   -1,   10, 61 },
        [3] = {  399,  198, -381, 57 },
    }

    local trionCoords =
    {
        [1] = { -403, -201,  413, 58 },
        [2] = {   -3,   -1,    4, 61 },
        [3] = {  397,  198, -395, 64 },
    }

    local battlefield     = player:getBattlefield()
    local battlefieldArea = battlefield:getArea()
    local phaseTwoOffset  = qubiaID.mob.WARLORD_ROJGNOJ + (battlefield:getArea() - 1) * 14

    -- Bail out if anyone else got here first
    for phaseTwoMobId = phaseTwoOffset, phaseTwoOffset + 2 do
        if GetMobByID(phaseTwoMobId):isSpawned() then
            return
        end
    end

    -- Set up the Arena for Phase 2
    for phaseTwoMobId = phaseTwoOffset, phaseTwoOffset + 2 do
        SpawnMob(phaseTwoMobId)
    end

    -- Spawn Trion (Ally)
    local trion = player:getBattlefield():insertEntity(75, true, true)
    player:setPos(unpack(playerCoords[battlefieldArea]))
    trion:setSpawn(unpack(trionCoords[battlefieldArea]))
    trion:spawn()
end

content.groups =
{
    -- Phase 1
    {
        mobIds =
        {
            {
                qubiaID.mob.WARLORD_ROJGNOJ + 3,
                qubiaID.mob.WARLORD_ROJGNOJ + 4,
                qubiaID.mob.WARLORD_ROJGNOJ + 5,
                qubiaID.mob.WARLORD_ROJGNOJ + 6,
                qubiaID.mob.WARLORD_ROJGNOJ + 7,
                qubiaID.mob.WARLORD_ROJGNOJ + 8,
                qubiaID.mob.WARLORD_ROJGNOJ + 9,
                qubiaID.mob.WARLORD_ROJGNOJ + 10,
                qubiaID.mob.WARLORD_ROJGNOJ + 11,
                qubiaID.mob.WARLORD_ROJGNOJ + 12,
                qubiaID.mob.WARLORD_ROJGNOJ + 13,
            },

            {
                qubiaID.mob.WARLORD_ROJGNOJ + 17,
                qubiaID.mob.WARLORD_ROJGNOJ + 18,
                qubiaID.mob.WARLORD_ROJGNOJ + 19,
                qubiaID.mob.WARLORD_ROJGNOJ + 20,
                qubiaID.mob.WARLORD_ROJGNOJ + 21,
                qubiaID.mob.WARLORD_ROJGNOJ + 22,
                qubiaID.mob.WARLORD_ROJGNOJ + 23,
                qubiaID.mob.WARLORD_ROJGNOJ + 24,
                qubiaID.mob.WARLORD_ROJGNOJ + 25,
                qubiaID.mob.WARLORD_ROJGNOJ + 26,
                qubiaID.mob.WARLORD_ROJGNOJ + 27,
            },

            {
                qubiaID.mob.WARLORD_ROJGNOJ + 31,
                qubiaID.mob.WARLORD_ROJGNOJ + 32,
                qubiaID.mob.WARLORD_ROJGNOJ + 33,
                qubiaID.mob.WARLORD_ROJGNOJ + 34,
                qubiaID.mob.WARLORD_ROJGNOJ + 35,
                qubiaID.mob.WARLORD_ROJGNOJ + 36,
                qubiaID.mob.WARLORD_ROJGNOJ + 37,
                qubiaID.mob.WARLORD_ROJGNOJ + 38,
                qubiaID.mob.WARLORD_ROJGNOJ + 39,
                qubiaID.mob.WARLORD_ROJGNOJ + 40,
                qubiaID.mob.WARLORD_ROJGNOJ + 41,
            },
        },

        superlink = true,
        allDeath  = function(battlefield, mob)
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(32004, 0, 0, 4)
            end
        end,
    },

    {
        mobIds =
        {
            {
                qubiaID.mob.WARLORD_ROJGNOJ,
                qubiaID.mob.WARLORD_ROJGNOJ + 1,
                qubiaID.mob.WARLORD_ROJGNOJ + 2,
            },

            {
                qubiaID.mob.WARLORD_ROJGNOJ + 14,
                qubiaID.mob.WARLORD_ROJGNOJ + 15,
                qubiaID.mob.WARLORD_ROJGNOJ + 16,
            },

            {
                qubiaID.mob.WARLORD_ROJGNOJ + 28,
                qubiaID.mob.WARLORD_ROJGNOJ + 29,
                qubiaID.mob.WARLORD_ROJGNOJ + 30,
            },
        },

        spawned  = false,
        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
