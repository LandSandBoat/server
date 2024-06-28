-----------------------------------
-- Area: The Celestial Nexus
-- Name: The Celestial Nexus (ZM16)
-----------------------------------
local celestialNexusID = zones[xi.zone.THE_CELESTIAL_NEXUS]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.THE_CELESTIAL_NEXUS,
    battlefieldId = xi.battlefield.id.CELESTIAL_NEXUS,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = '_513',

    -- TODO: This needs verification, and potentially updating the door inside of the arena to not open
    -- and display appropriate message.
    exitNpcs      = { },

    missionArea           = xi.mission.log_id.ZILART,
    mission               = xi.mission.id.zilart.THE_CELESTIAL_NEXUS,
    missionStatusArea     = xi.mission.log_id.ZILART,
    requiredMissionStatus = 0,
})

function content:onEventFinishBattlefield(player, csid, option, npc)
    if csid == 32004 then
        local battlefield = player:getBattlefield()
        local phaseTwoId  = content.groups[4]['mobIds'][battlefield:getArea()][1]
        local phaseTwo    = GetMobByID(phaseTwoId)

        if phaseTwo:isSpawned() then
            return
        end

        DespawnMob(content.groups[1]['mobIds'][battlefield:getArea()][1])
        SpawnMob(phaseTwoId)

        phaseTwo:setLocalVar('targetId', player:getTargID())
        phaseTwo:timer(30000, function(mobArg)
            phaseTwo:engage(mobArg:getLocalVar('targetId'))
        end)
    end
end

content.groups =
{
    -- Phase 1 - Eald'narche
    {
        mobIds =
        {
            { celestialNexusID.mob.EALDNARCHE      },
            { celestialNexusID.mob.EALDNARCHE + 5  },
            { celestialNexusID.mob.EALDNARCHE + 10 },
        },

        death = function(battlefield, mob)
            local mobId = mob:getID()
            for orbitalId = mobId + 3, mobId + 4 do
                DespawnMob(orbitalId)
            end

            local players = battlefield:getPlayers()
            for _, player in pairs(players) do
                player:startEvent(32004, battlefield:getArea())
            end
        end
    },

    -- Phase 1 - Exoplates
    {
        mobIds =
        {
            { celestialNexusID.mob.EALDNARCHE + 1  },
            { celestialNexusID.mob.EALDNARCHE + 6  },
            { celestialNexusID.mob.EALDNARCHE + 11 },
        },
    },

    -- Phase 1 - Orbitals
    {
        mobIds =
        {
            {
                celestialNexusID.mob.EALDNARCHE + 3,
                celestialNexusID.mob.EALDNARCHE + 4,
            },

            {
                celestialNexusID.mob.EALDNARCHE + 8,
                celestialNexusID.mob.EALDNARCHE + 9,
            },

            {
                celestialNexusID.mob.EALDNARCHE + 13,
                celestialNexusID.mob.EALDNARCHE + 14,
            },
        },

        spawned = false,
    },

    -- Phase 2 - Eald'narche
    {
        mobIds =
        {
            { celestialNexusID.mob.EALDNARCHE + 2  },
            { celestialNexusID.mob.EALDNARCHE + 7  },
            { celestialNexusID.mob.EALDNARCHE + 12 },
        },

        spawned = false,
        death   = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end
    },
}

return content:register()
