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
