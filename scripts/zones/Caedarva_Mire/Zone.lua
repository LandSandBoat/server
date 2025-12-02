-----------------------------------
-- Zone: Caedarva_Mire (79)
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    GetMobByID(ID.mob.KHIMAIRA):setRespawnTime(math.random(12, 36) * 3600) -- 12 to 36 hours after maintenance, in 1-hour increments

    xi.helm.initZone(zone, xi.helmType.LOGGING)
    xi.darkRider.addHoofprints(zone)

    -- All of these apply weight and/or haste
    zone:registerCylindricalTriggerArea(1, 457.4, -306.8, 7.5) -- K-8 North
    zone:registerCylindricalTriggerArea(2, 459.5, -336.7, 7.5) -- K-8 South
    zone:registerCylindricalTriggerArea(3, 300.8, -342.8, 7.5) -- J-8 North
    zone:registerCylindricalTriggerArea(4, 297.25, -378.1, 7.5) -- J-8 South
    zone:registerCylindricalTriggerArea(5, 144.07, -178.0, 7.5) -- I-7
    zone:registerCylindricalTriggerArea(6, -378.7, -142.0, 7.5) -- I-9
    zone:registerCylindricalTriggerArea(7, -420.69, -186.3, 7.5) -- H-10
    zone:registerCylindricalTriggerArea(8, -620.16, -177.9, 7.5) -- G-10
    zone:registerCylindricalTriggerArea(9, -620.16, -177.9, 15) -- Zikko
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(339.996, 2.5, -721.286, 200)
    end

    if prevZone == xi.zone.LEUJAOAM_SANCTUM then
        player:setPos(495.450, -28.25, -478.43, 32)
    end

    if prevZone == xi.zone.PERIQIA then
        player:setPos(-252.715, -7.666, -30.64, 128)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')
    player:entityVisualPacket('1pd1')
    player:entityVisualPacket('2pc1')
end

local function triggerZikkoSpawnAttempt(player)
    local zikko = GetMobByID(ID.mob.ZIKKO)
    if
        zikko and
        not zikko:isSpawned() and
        player:hasStatusEffect(xi.effect.WEIGHT) and
        GetSystemTime() > zikko:getLocalVar('cooldown')
    then
        SpawnMob(ID.mob.ZIKKO):updateEnmity(player)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    -- swamp effects
    local effectTable =
    {
        [1] = {  990, xi.effect.WEIGHT,        50,  30,  60, ID.text.LEG_STUCK         },
        [2] = {  992, xi.effect.HASTE,       1465, 180, 180, ID.text.MYSTERIOUS_EFFECT },
        [3] = {  994, xi.effect.SLOW,        3000, 180, 180, ID.text.MYSTERIOUS_EFFECT },
        [4] = {  996, xi.effect.QUICKENING,     5, 180, 180, ID.text.MYSTERIOUS_EFFECT },
        [5] = {  998, xi.effect.FLEE,       10000, 180, 180, ID.text.MYSTERIOUS_EFFECT },
        [6] = { 1000, xi.effect.STONESKIN,    350,  30,  30, ID.text.MYSTERIOUS_EFFECT },
    }

    -- swamp trigger areas
    if triggerAreaID <= 8 then
        if
            not player:hasStatusEffect(xi.effect.MOUNTED) and
            not player:hasStatusEffect(xi.effect.WEIGHT)
        then
            local random = math.random(1000)
            for i = 1, 6 do
                if random <= effectTable[i][1] then
                    player:addStatusEffect(effectTable[i][2], effectTable[i][3], 0, math.random(effectTable[i][4], effectTable[i][5]))
                    player:messageSpecial(effectTable[i][6])
                    break
                end
            end
        end

        -- the trigger for area 9 will occur before entering the weight area, so check again here
        if triggerAreaID == 8 then
            triggerZikkoSpawnAttempt(player)
        end
    end

    -- Zikko can spawn even if you aren't in the part of the swamp that weighs you down
    if triggerAreaID == 9 then
        triggerZikkoSpawnAttempt(player)
    end
end

zoneObject.onGameHour = function(zone)
    xi.darkRider.onGameHour(zone)

    if VanadielHour() == 0 then
        xi.darkRider.addHoofprints(zone)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 133 then -- enter instance, warp to periqia
        player:setPos(0, 0, 0, 0, 56)
    elseif csid == 130 then
        player:setPos(0, 0, 0, 0, 69)
    end
end

return zoneObject
