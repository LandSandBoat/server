-----------------------------------
-- Area: Throne Room
-- Name: Mission 5-2
-- !pos -111 -6 0.1 165
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.SHADOW_LORD_BATTLE,
    maxPlayers    = 6,
    levelCap      = 75,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = "_4l1",
    exitNpcs      = { "_4l2", "_4l3", "_4l4" },

    mission               = xi.mission.id.nation.SHADOW_LORD,
    requiredMissionStatus = 3,
    title                 = xi.title.SHADOW_BANISHER,
})

function content:onEventFinishBattlefield(player, csid, option)
    local battlefield = player:getBattlefield()
    local area        = battlefield:getArea()
    local phaseTwoId  = ID.mob.SHADOW_LORD_PHASE_2_OFFSET + (area - 1)
    local phaseTwo    = GetMobByID(phaseTwoId)

    if phaseTwo:isSpawned() then
        return
    end

    DespawnMob(ID.mob.SHADOW_LORD_PHASE_1_OFFSET + (area - 1))

    -- first phase dies, spawn second phase ID, make him engage, and disable
    -- magic, auto attack, and abilities (all he does is case Implode by script)
    local mob = SpawnMob(phaseTwoId)
    mob:updateEnmity(player)
    mob:setMagicCastingEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
end

content.groups =
{
    -- Phase 1
    {
        mobIds =
        {
            { ID.mob.SHADOW_LORD_PHASE_1_OFFSET     },
            { ID.mob.SHADOW_LORD_PHASE_1_OFFSET + 1 },
            { ID.mob.SHADOW_LORD_PHASE_1_OFFSET + 2 }
        },

        death = function(battlefield, mob)
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(32004)
            end
        end
    },

    -- Phase 2
    {
        mobIds =
        {
            { ID.mob.SHADOW_LORD_PHASE_2_OFFSET     },
            { ID.mob.SHADOW_LORD_PHASE_2_OFFSET + 1 },
            { ID.mob.SHADOW_LORD_PHASE_2_OFFSET + 2 }
        },

        spawned = false,
        death   = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end
    }
}

return content:register()
