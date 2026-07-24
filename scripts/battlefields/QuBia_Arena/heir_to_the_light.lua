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
    -- TODO: On retail the loss event plays with params { [0] = 70, [2] = 4, [6] = zone } and mode
    -- flags 4360 (captured), displaying "You were unable to protect Prince Trion. Now leaving the
    -- battlefield." during the exit fade.  Sending the params works, but repeat viewers get a
    -- client-side skip prompt, and declining it softlocks the client: the reply to the resulting
    -- GP_CLI_COMMAND_EVENTENDXZY update sends position packets retail does not (unhandled updates
    -- default to a position update in luautils::OnEventUpdate).  Add lossEventParams once that
    -- reply is fixed.
})

function content:onEventFinishBattlefield(player, csid, option, npc)
    local playerCoords =
    {
        [1] = { -398.196, -201.625,  416.836, 68 },
        [2] = {    1.877,   -1.625,   16.935, 68 },
        [3] = {  401.832,  198.375, -382.841, 68 },
    }

    local trionCoords =
    {
        [1] = { -399.92, -201.62,  411.64, 63 },
        [2] = {    0.08,   -1.62,   11.64, 63 },
        [3] = {  400.10,  198.37, -388.32, 63 },
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
            -- Simultaneous kills invoke this once per death; play the cutscene only once.
            if battlefield:getLocalVar('arrivalCS') == 1 then
                return
            end

            battlefield:setLocalVar('arrivalCS', 1)

            local battlefieldArea = battlefield:getArea()
            local players         = battlefield:getPlayers()

            for _, player in pairs(players) do
                if
                    player:getCharVar('Mission[0][23]Intro') == 1 or
                    player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT)
                then
                    player:startEvent(32005, battlefieldArea, 0, 4, 0, 15)
                else
                    player:startEvent(32004, battlefieldArea, 0, 4)
                end
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

        spawned   = false,
        superlink = true,
        allDeath  = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
