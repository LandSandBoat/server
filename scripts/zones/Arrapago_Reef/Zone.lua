-----------------------------------
-- Zone: Arrapago_Reef (54)
-----------------------------------
---@type TZone
local zoneObject = {}

local function applyDeathListener(player)
    player:addListener('DEATH', 'LAMIA_19_TRIGGER', function(playerArg)
        local ID = zones[xi.zone.ARRAPAGO_REEF]

        -- Early return: No mob object.
        local mob = GetMobByID(ID.mob.LAMIA_NO19)
        if not mob then
            return
        end

        -- Early return: Mob isn't spawned.
        if not mob:isSpawned() then
            return
        end

        -- Early return: Mob is already triggered and aggresive.
        if mob:getLocalVar('state') ~= 0 then
            return
        end

        -- Early return: Player is too far away from mob.
        if mob:checkDistance(playerArg) > 15 then
            return
        end

        -- Early return: No zone object.
        local zone = mob:getZone()
        if not zone then
            return
        end

        -- Send message.
        local players = zone:getPlayers()
        for _, person in pairs(players) do
            if person:checkDistance(playerArg) <= 30 then
                person:messageSpecial(ID.text.FOREBODING)
            end
        end

        -- Early return: Doesn't get triggered. 80% chance she answers it (estimate from current captures; needs more data for a precise rate)
        if math.randomInt(1, 100) > 80 then
            return
        end

        -- Handle local variables.
        mob:setLocalVar('state', 1)
        mob:setLocalVar('appearTime', GetSystemTime())

        mob:clearPath()
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setPos(playerArg:getXPos(), playerArg:getYPos(), playerArg:getZPos())

        mob:setStatus(xi.status.UPDATE)
        mob:hideHP(false)
        mob:hideName(false)
        mob:setUntargetable(false)

        -- While visible she is always aggressive and has true sight
        mob:setAggressive(true)
        mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
        mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)
        mob:setTrueDetection(true)
    end)
end

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -462, -4, -420, -455, -1, -392) -- approach the Cutter
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-456, -3, -405, 64)
    end

    if prevZone == xi.zone.ILRUSI_ATOLL then
        player:setPos(26, -7, 606, 222)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')

    applyDeathListener(player)
end

zoneObject.onZoneOut = function(player)
    player:removeListener('LAMIA_19_TRIGGER')
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function()
    xi.apkallu.updateHate(xi.zone.ARRAPAGO_REEF, -3)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 108 then -- enter instance: illrusi atoll
        player:setPos(0, 0, 0, 0, 55)
    elseif csid == 222 then -- Enter instance: Black coffin
        player:setPos(0, 0, 0, 0, 60)
    end
end

return zoneObject
