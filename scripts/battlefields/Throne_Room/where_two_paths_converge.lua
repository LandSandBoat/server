-----------------------------------
-- Area: Throne Room
-- Name: Bastok Mission 9-2
-- !pos -111 -6 0 165
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/missions")
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.WHERE_TWO_PATHS_CONVERGE,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 1,
    entryNpc      = "_4l1",
    exitNpcs      = { "_4l2", "_4l3", "_4l4" },

    missionArea           = xi.mission.log_id.BASTOK,
    mission               = xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE,
    requiredMissionStatus = 1,
    skipMissionStatus     = 4,
})

function content:onEventFinishBattlefield(player, csid, option)
    local area         = player:getBattlefield():getArea()
    local zeidId       = ID.mob.ZEID_BCNM_OFFSET + (area - 1) * 4
    local playerCoords =
    {
        [1] = { -443,      -167, -239,     127 },
        [2] = { -762.949,  -407, -478.991, 127 },
        [3] = { -1082.787, -647, -718.976, 127 },
    }

    local volkerCoords =
    {
        [1] = { -450,      -167, -239,     125 },
        [2] = { -769.949 , -407, -478.991, 125 },
        [3] = { -1089.787, -647, -718.976, 125 },
    }

    local zeid2 = SpawnMob(zeidId + 1)

    -- Set Phase 2 Zeid's HP to be same HPP as previous phase.
    local zeid1 = GetMobByID(zeidId)
    local hpp   = zeid1:getHPP() / 100
    zeid2:setHP(math.floor(zeid2:getMaxHP() * hpp))

    -- Spawn Volker helper NPC.
    local volker = player:getBattlefield():insertEntity(28, true, true)
    player:setPos(unpack(playerCoords[area]))
    volker:setSpawn(unpack(volkerCoords[area]))
    volker:spawn()
end

content.groups =
{
    -- Phase 1
    {
        mobs  = { "Zeid" },
        setup = function(battlefield, mobs)
            for _, mob in ipairs(mobs) do
                mob:setUntargetable(false)
                mob:setUnkillable(true)
                mob:removeListener("ZEID_COMBAT_TICK")

                mob:addListener("COMBAT_TICK", "ZEID_COMBAT_TICK", function(zeid)
                    if zeid:getHPP() < 70 and zeid:getLocalVar("ChangingPhase") == 0 then
                        zeid:setLocalVar("ChangingPhase", 1)

                        local players = zeid:getBattlefield():getPlayers()

                        for _, player in ipairs(players) do
                            zeid:setUntargetable(true)
                            player:startEvent(32004, 3, 3, 1, 3, 3, 3, 3, 3)
                            DespawnMob(zeid:getID())
                        end
                    end
                end)
            end
        end
    },

    -- Phase 2
    {
        mobs    = { "Zeid_2" },
        spawned = false,
        death   = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end
    },

    {
        mobs    = { "Shadow_of_Rage" },
        spawned = false,
    }
}

return content:register()
