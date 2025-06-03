-----------------------------------
-- Those Who Lurk in Shadows (III)
-- Qu'Bia Arena mission battlefield
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.QUBIA_ARENA,
    battlefieldId         = xi.battlefield.id.THOSE_WHO_LURK_IN_SHADOWS,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 99,
    timeLimit             = utils.minutes(30),
    index                 = 20,
    entryNpc              = 'BC_Entrance',
    exitNpc               = 'Burning_Circle',
    missionArea           = xi.mission.log_id.ACP,
    mission               = xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III,
    missionStatusArea     = xi.mission.log_id.ACP,
    requiredMissionStatus = 0,
    requiredKeyItems      = { xi.ki.MARK_OF_SEED, message = qubiaID.text.LOST_KEYITEM },

    experimental = true,
})

-- TODO: This should be moved to mission script once converted to Interaction Framework
function content:onEventFinishWin(player, csid, option, npc)
    if player:getCurrentMission(xi.mission.log_id.ACP) == xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.REMEMBER_ME_IN_YOUR_DREAMS)
    end

    if
        not player:hasKeyItem(xi.ki.IVORY_KEY) and
        player:getCurrentMission(xi.mission.log_id.ACP) >= xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III
    then
        player:setCharVar('LastIvoryKey', getMidnight())
        npcUtil.giveKeyItem(player, xi.ki.IVORY_KEY)
    end
end

content.groups =
{
    {
        mobIds =
        {
            {
                qubiaID.mob.SEED_ORC,
                qubiaID.mob.SEED_ORC + 1,
                qubiaID.mob.SEED_ORC + 2,
                qubiaID.mob.SEED_ORC + 3,
            },

            {
                qubiaID.mob.SEED_ORC + 4,
                qubiaID.mob.SEED_ORC + 5,
                qubiaID.mob.SEED_ORC + 6,
                qubiaID.mob.SEED_ORC + 7,
            },

            {
                qubiaID.mob.SEED_ORC + 8,
                qubiaID.mob.SEED_ORC + 9,
                qubiaID.mob.SEED_ORC + 10,
                qubiaID.mob.SEED_ORC + 11,
            },
        },

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
