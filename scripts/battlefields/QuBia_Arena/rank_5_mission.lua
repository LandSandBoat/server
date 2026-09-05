-----------------------------------
-- Rank 5 Mission
-- Qu'Bia Arena mission battlefield
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------

-- Each pair shares a home point and produces at most one Warrior per pulse.
local warriorOffsetsBySpawnPoint = { { 3, 5 }, { 4, 6 } }

local content = BattlefieldMission:new({
    zoneId                = xi.zone.QUBIA_ARENA,
    battlefieldId         = xi.battlefield.id.RANK_5_MISSION,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    timeLimit             = utils.minutes(15),
    index                 = 0,
    entryNpc              = 'BC_Entrance',
    exitNpc               = 'Burning_Circle',
    mission               = xi.mission.id.nation.ARCHLICH,
    requiredMissionStatus = 11,
    title                 = xi.title.ARCHMAGE_ASSASSIN,
})

function content:entryRequirement(player, npc, isRegistrant, trade)
    return player:hasCompletedMission(player:getNation(), self.mission) or
        player:hasKeyItem(xi.ki.NEW_FEIYIN_SEAL)
end

content.groups =
{
    {
        mobIds =
        {
            { qubiaID.mob.ARCHLICH_TABERQUOAN      },
            { qubiaID.mob.ARCHLICH_TABERQUOAN + 7  },
            { qubiaID.mob.ARCHLICH_TABERQUOAN + 14 },
        },

        allDeath = function(battlefield, archlich)
            for offset = 1, 6 do
                local add = GetMobByID(archlich:getID() + offset)

                if add and add:isSpawned() then
                    -- Retail removes remaining add models and nameplates in the Archlich death frame.
                    for _, player in pairs(battlefield:getPlayers()) do
                        player:sendEntityUpdateToPlayer(add, xi.entityUpdate.ENTITY_DESPAWN, xi.updateType.UPDATE_NONE)
                    end

                    DespawnMob(add:getID())
                end
            end

            battlefield:setStatus(xi.battlefield.status.WON)
        end,

        superlinkGroup = 1,
    },

    -- Sorcerers
    {
        mobIds =
        {
            {
                qubiaID.mob.ARCHLICH_TABERQUOAN + 1,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 2,
            },

            {
                qubiaID.mob.ARCHLICH_TABERQUOAN + 8,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 9,
            },

            {
                qubiaID.mob.ARCHLICH_TABERQUOAN + 15,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 16,
            },
        },

        superlinkGroup = 1,
    },

    -- Warriors
    {
        mobIds =
        {
            {
                qubiaID.mob.ARCHLICH_TABERQUOAN + 3,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 4,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 5,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 6,
            },

            {
                qubiaID.mob.ARCHLICH_TABERQUOAN + 10,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 11,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 12,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 13,
            },

            {
                qubiaID.mob.ARCHLICH_TABERQUOAN + 17,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 18,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 19,
                qubiaID.mob.ARCHLICH_TABERQUOAN + 20,
            },
        },

        spawned        = false,
        superlinkGroup = 1,
    },
}

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    if battlefield:getStatus() ~= xi.battlefield.status.LOCKED then
        return
    end

    local currentTime = GetSystemTime()
    if currentTime < battlefield:getLocalVar('nextWarriorRespawn') then
        return
    end

    local mobBaseId = qubiaID.mob.ARCHLICH_TABERQUOAN + (battlefield:getArea() - 1) * 7
    local archlich  = GetMobByID(mobBaseId)
    if not archlich then
        return
    end

    local archlichTarget = archlich:getTarget()
    if not archlichTarget then
        return
    end

    battlefield:setLocalVar('nextWarriorRespawn', currentTime + 10)

    for _, spawnPointOffsets in ipairs(warriorOffsetsBySpawnPoint) do
        for _, offset in ipairs(spawnPointOffsets) do
            local warrior = GetMobByID(mobBaseId + offset)

            if warrior and not warrior:isSpawned() then
                warrior:spawn()
                -- Seed threat before directly entering the attack state.
                warrior:addEnmity(archlichTarget, 1, 0)
                warrior:engage(archlichTarget:getTargID())
                break
            end
        end
    end
end

return content:register()
