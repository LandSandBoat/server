-----------------------------------
-- Area: Throne Room
-- Name: Mission 5-2
-- !pos -111 -6 0.1 165
-----------------------------------
local ID = zones[xi.zone.THRONE_ROOM]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId        = xi.zone.THRONE_ROOM,
    battlefieldId = xi.battlefield.id.SHADOW_LORD_BATTLE,
    canLoseExp    = false,
    isMission     = true,
    allowTrusts   = true,
    maxPlayers    = 6,
    levelCap      = xi.settings.main.MAX_LEVEL,
    timeLimit     = utils.minutes(30),
    index         = 0,
    entryNpc      = '_4l1',
    exitNpcs      = { '_4l2', '_4l3', '_4l4' },

    mission               = xi.mission.id.nation.SHADOW_LORD,
    requiredMissionStatus = 3,
    title                 = xi.title.SHADOW_BANISHER,
})

function content:onEventFinishBattlefield(player, csid, option, npc)
    local battlefield = player:getBattlefield()
    local area        = battlefield:getArea()
    local phaseTwoId  = ID.mob.SHADOW_LORD_RANK_5_OFFSET + area + 2
    local phaseTwo    = GetMobByID(phaseTwoId)

    if phaseTwo and phaseTwo:isSpawned() then
        return
    end

    DespawnMob(ID.mob.SHADOW_LORD_RANK_5_OFFSET + area - 1)

    -- first phase dies, spawn second phase ID, make him engage, and disable
    -- magic, auto attack, and abilities (all he does is case Implode by script)
    local mob = SpawnMob(phaseTwoId)
    if mob then
        mob:updateEnmity(player)
    end
end

content.groups =
{
    -- Phase 1
    {
        mobIds =
        {
            { ID.mob.SHADOW_LORD_RANK_5_OFFSET     },
            { ID.mob.SHADOW_LORD_RANK_5_OFFSET + 1 },
            { ID.mob.SHADOW_LORD_RANK_5_OFFSET + 2 }
        },

        death = function(battlefield, mob)
            local players = battlefield:getPlayers()

            for _, player in pairs(players) do
                player:startEvent(32004, battlefield:getArea())
            end
        end
    },

    -- Phase 2
    {
        mobIds =
        {
            { ID.mob.SHADOW_LORD_RANK_5_OFFSET + 3 },
            { ID.mob.SHADOW_LORD_RANK_5_OFFSET + 4 },
            { ID.mob.SHADOW_LORD_RANK_5_OFFSET + 5 }
        },

        spawned = false,
        death   = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end
    }
}

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    if battlefield:getStatus() ~= xi.battlefield.status.LOCKED then
        return
    end

    local phaseTwo = GetMobByID(ID.mob.SHADOW_LORD_RANK_5_OFFSET + battlefield:getArea() + 2)
    if not phaseTwo or not phaseTwo:isAlive() then
        return
    end

    local defeated = phaseTwo:getLocalVar('[ShadowLord]Defeated')
    if defeated == 0 then
        return
    end

    local defeatTime = phaseTwo:getLocalVar('[ShadowLord]DefeatTime')

    -- The mobskill stamps DefeatTime when the animation starts.
    -- A wipe before his next tp move leaves it unset.
    if defeatTime == 0 then
        defeatTime = defeated + 30
    end

    if GetSystemTime() < defeatTime then
        return
    end

    phaseTwo:setUnkillable(false)
    phaseTwo:setHP(0)
end

return content:register()
