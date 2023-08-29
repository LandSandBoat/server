-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  mob: Quasilumin
-- Note: Escort Quest / Map Quest
--   DE: Dynamic Entity created by Cermet Alcoves
-----------------------------------
local ID = zones[xi.zone.GRAND_PALACE_OF_HUXZOI]
-----------------------------------

local escorts =
{
    -- Escort 1
    [ID.npc.CERMET_ALCOVE_OFFSET] =
    {
        direction = ID.text.PORTAL_EAST,
        complete_door = ID.npc.ESCORT_1_DOOR_OFFSET + 2,
        doors =
        {
            ID.npc.ESCORT_1_DOOR_OFFSET,
            ID.npc.ESCORT_1_DOOR_OFFSET + 1,
        },

        path =
        {
            { -260.000, 0.000, 450.000 }, -- 1
            { -260.000, 0.000, 468.000 }, -- 2
            { -260.000, -1.000, 497.000 }, -- 3
        }
    },

    -- Escort 2
    [ID.npc.CERMET_ALCOVE_OFFSET + 1] =
    {
        direction = ID.text.PORTAL_EAST,
        complete_door = ID.npc.ESCORT_2_DOOR_OFFSET,
        doors =
        {
            ID.npc.ESCORT_2_DOOR_OFFSET + 1,
            ID.npc.ESCORT_2_DOOR_OFFSET + 2,
            ID.npc.ESCORT_2_DOOR_OFFSET + 3,
            ID.npc.ESCORT_2_DOOR_OFFSET + 4,
        },

        path =
        {
            { 772.000, 0.000, 460.000 }, -- 1
            { 780.000, 0.000, 447.000 }, -- 2
            { 780.000, 0.000, 434.000 }, -- 3
            { 780.000, 0.000, 426.000 }, -- 4
            { 773.000, 0.000, 420.000 }, -- 5
            { 757.000, 0.000, 420.000 }, -- 6
            { 746.000, 0.000, 412.000 }, -- 7
            { 733.000, 0.000, 412.000 }, -- 8
            { 726.000, 0.000, 420.000 }, -- 9
            { 706.000, 0.000, 420.000 }, -- 10
            { 700.000, 0.000, 425.000 }, -- 11
            { 700.000, 0.000, 435.000 }, -- 12
            { 700.000, 0.000, 445.000 }, -- 13
            { 700.000, 0.000, 454.000 }, -- 14
            { 695.000, 0.000, 460.000 }, -- 15
            { 673.000, 0.000, 460.000 }, -- 16
            { 643.000, 0.000, 460.000 }, -- 17
            { 617.000, 0.000, 460.000 }, -- 18
            { 605.000, 0.000, 460.000 }, -- 19
            { 595.000, 0.000, 460.000 }, -- 20
            { 578.000, 0.000, 460.000 }, -- 21
            { 558.000, 0.000, 460.000 }, -- 22
            { 540.000, 0.000, 460.000 }, -- 23
            { 540.000, -1.000, 423.000 }, -- 24
        }
    },

    -- Escort 3
    [ID.npc.CERMET_ALCOVE_OFFSET + 2] =
    {
        direction = ID.text.PORTAL_WEST,
        complete_door = ID.npc.ESCORT_3_DOOR_OFFSET,
        doors =
        {
            ID.npc.ESCORT_3_DOOR_OFFSET + 1,
            ID.npc.ESCORT_3_DOOR_OFFSET + 2,
            ID.npc.ESCORT_3_DOOR_OFFSET + 3,
            ID.npc.ESCORT_3_DOOR_OFFSET + 4,
        },

        path =
        {
            { 540.000, 0.000, 274.000 }, -- 1
            { 540.000, 0.000, 260.000 }, -- 2
            { 518.000, 0.000, 260.000 }, -- 3
            { 500.000, 0.000, 260.000 }, -- 4
            { 465.000, 0.000, 260.000 }, -- 5
            { 460.000, 0.000, 253.000 }, -- 6
            { 460.000, 0.000, 226.000 }, -- 7
            { 453.000, 0.000, 220.000 }, -- 8
            { 436.000, 0.000, 220.000 }, -- 9
            { 403.000, 0.000, 220.000 }, -- 10
            { 395.000, 0.000, 220.000 }, -- 11
            { 385.000, 0.000, 220.000 }, -- 12
            { 380.000, 0.000, 226.000 }, -- 13
            { 380.000, 0.000, 244.000 }, -- 14
            { 380.000, 0.000, 253.000 }, -- 15
            { 373.000, 0.000, 260.000 }, -- 16
            { 365.000, 0.000, 260.000 }, -- 17
            { 349.000, 0.000, 260.000 }, -- 18
            { 340.000, 0.000, 260.000 }, -- 19
            { 319.000, 0.000, 260.000 }, -- 20
            { 300.000, 0.000, 260.000 }, -- 21
            { 300.000, -1.000, 297.000 }, -- 22
        }
    },

    -- Escort 4
    [ID.npc.CERMET_ALCOVE_OFFSET + 3] =
    {
        direction = ID.text.PORTAL_NORTH,
        complete_door = ID.npc.ESCORT_4_DOOR_OFFSET,
        doors =
        {
            ID.npc.ESCORT_4_DOOR_OFFSET + 1,
            ID.npc.ESCORT_4_DOOR_OFFSET + 2,
            ID.npc.ESCORT_4_DOOR_OFFSET + 3,
            ID.npc.ESCORT_4_DOOR_OFFSET + 4,
            ID.npc.ESCORT_4_DOOR_OFFSET + 5,
            ID.npc.ESCORT_4_DOOR_OFFSET + 6,
            ID.npc.ESCORT_4_DOOR_OFFSET + 7,
        },

        path =
        {
            { -540.000, 0.000, 276.000 }, -- 1
            { -540.000, 0.000, 260.000 }, -- 2
            { -519.000, 0.000, 260.000 }, -- 3
            { -500.000, 0.000, 260.000 }, -- 4
            { -500.000, 0.000, 289.000 }, -- 5
            { -500.000, 0.000, 312.000 }, -- 6
            { -500.000, 0.000, 324.000 }, -- 7
            { -500.000, 0.000, 334.000 }, -- 8
            { -507.000, 0.000, 340.000 }, -- 9
            { -540.000, 0.000, 340.000 }, -- 10
            { -540.000, 0.000, 380.000 }, -- 11
            { -514.000, 0.000, 380.000 }, -- 12
            { -506.000, 0.000, 380.000 }, -- 13
            { -500.000, 0.000, 385.000 }, -- 14
            { -500.000, 0.000, 394.000 }, -- 15
            { -500.000, 0.000, 394.000 }, -- 16
            { -500.000, 0.000, 403.000 }, -- 17
            { -500.000, 0.000, 413.000 }, -- 18
            { -505.000, 0.000, 420.000 }, -- 19
            { -521.000, 0.000, 420.000 }, -- 20
            { -525.000, 0.000, 420.000 }, -- 21
            { -533.000, 0.000, 420.000 }, -- 22
            { -540.000, 0.000, 426.000 }, -- 23
            { -540.000, 0.000, 460.000 }, -- 24
            { -540.000, 0.000, 485.000 }, -- 25
            { -540.000, 0.000, 494.000 }, -- 26
            { -533.000, 0.000, 500.000 }, -- 27
            { -525.000, 0.000, 500.000 }, -- 28
            { -515.000, 0.000, 500.000 }, -- 29
            { -506.000, 0.000, 500.000 }, -- 30
            { -500.000, 0.000, 505.000 }, -- 31
            { -500.000, 0.000, 540.000 }, -- 32
            { -479.000, 0.000, 540.000 }, -- 33
            { -460.000, 0.000, 540.000 }, -- 34
            { -420.000, 0.000, 540.000 }, -- 35
            { -420.000, 0.000, 519.000 }, -- 36
            { -420.000, 0.000, 500.000 }, -- 37
            { -382.000, -1.000, 500.000 }, -- 38
        }
    },
}

local escortProgress =
{
    NONE     = 0, -- Have not started pathing at all yet
    ENROUTE  = 1, -- Started pathing and is continuing along path
    PAUSED   = 2, -- Has paused pathing and awaiting orders
    COMPLETE = 3, -- Has reached the end of the escort mission
}

local entity = {}

entity.shouldMove = function(mob, progress)
    return not mob:isFollowingPath() and mob:getStatus() == xi.status.NORMAL and progress ~= escortProgress.COMPLETE
end

entity.closeDoor = function(mob)
    local openedDoor = mob:getLocalVar('opened_door')
    if openedDoor ~= 0 then
        local npc = GetNPCByID(openedDoor)
        npc:setAnimation(xi.animation.CLOSE_DOOR)
        mob:setLocalVar('opened_door', 0)
    end
end

entity.onMobInitialize = function(mob)
    -- mob:addStatusEffect(xi.effect.NO_REST, 1, 0, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_DESPAWN, 1)
    mob:setAutoAttackEnabled(false)
end

entity.onMobRoam = function(mob)
    mob:setStatus(xi.status.NORMAL)
    local progress = mob:getLocalVar('progress')
    local escort = escorts[mob:getLocalVar('escort')]
    if progress == escortProgress.NONE then
        mob:setLocalVar('progress', escortProgress.ENROUTE)
        local point = 1
        mob:setLocalVar('point', point)
        mob:pathThrough(escort.path[point], xi.path.flag.WALK)
    end

    local now = os.time()
    local expire = mob:getLocalVar('expire')
    if expire ~= 0 and expire <= now then
        if progress ~= escortProgress.COMPLETE then
            mob:showText(mob, ID.text.TIME_EXCEEDED)
        end

        mob:setStatus(xi.status.INVISIBLE)
        DespawnMob(mob:getID())
        entity.closeDoor(mob)
        return
    end

    local openedDoor = mob:getLocalVar('opened_door')
    if openedDoor ~= 0 then
        local npc = GetNPCByID(openedDoor)
        if mob:checkDistance(npc) > 15 then
            npc:setAnimation(xi.animation.CLOSE_DOOR)
            mob:setLocalVar('opened_door', 0)
        elseif npc:getAnimation() ~= xi.animation.OPEN_DOOR then
            npc:setAnimation(xi.animation.OPEN_DOOR)
        end
    end

    for _, doorID in ipairs(escort.doors) do
        local npc = GetNPCByID(doorID)
        if doorID ~= openedDoor and  mob:checkDistance(npc) <= 8 then
            npc:setAnimation(xi.animation.OPEN_DOOR)
            mob:setLocalVar('opened_door', doorID)
        end
    end
end

entity.onPath = function(mob)
    local progress = mob:getLocalVar('progress')
    local escort = mob:getLocalVar('escort')
    local data = escorts[escort]

    if data ~= nil and entity.shouldMove(mob, progress) then
        local point = mob:getLocalVar('point')
        if point == #data.path then
            mob:showText(mob, ID.text.PATROL_COMPLETED)
            mob:setLocalVar('progress', escortProgress.COMPLETE)
            mob:setLocalVar('expire', os.time() + 60)
        elseif progress ~= escortProgress.COMPLETE then
            point = point + 1
            mob:setLocalVar('point', point)
            mob:pathThrough(data.path[point], xi.path.flag.WALK)
        end
    end
end

entity.onTrigger = function(player, mob)
    local progress = mob:getLocalVar('progress')
    local point = mob:getLocalVar('point')
    local escort = mob:getLocalVar('escort')
    local data = escorts[escort]

    if data ~= nil then
        if progress == escortProgress.ENROUTE then
            mob:pathThrough(mob:getPos(), xi.path.flag.NONE)
            mob:showText(mob, ID.text.PATROL_SUSPENDED)
            mob:setLocalVar('progress', escortProgress.PAUSED)
        elseif progress == escortProgress.PAUSED then
            mob:showText(mob, ID.text.RECOMMENCING_PATROL)
            mob:setLocalVar('progress', escortProgress.ENROUTE)
            mob:pathThrough(data.path[point], xi.path.flag.WALK)
        elseif progress == escortProgress.COMPLETE then
            mob:showText(mob, ID.text.DUTY_COMPLETE)
            player:messageSpecial(data.direction)
            -- TODO: display animation and NPC is not pushing update packet to players in range
            mob:timer(60000, function(quasilumin)
                quasilumin:setStatus(xi.status.INVISIBLE)
                DespawnMob(quasilumin:getID())
            end)

            GetNPCByID(data.complete_door):openDoor(60)
        end
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar('progress', escortProgress.PAUSED)
    mob:disengage()
end

entity.onMobDeath = function(mob, player, optParams)
    mob:setStatus(xi.status.INVISIBLE)
end

entity.onMobDespawn = function(mob)
    entity.closeDoor(mob)
end

return entity
