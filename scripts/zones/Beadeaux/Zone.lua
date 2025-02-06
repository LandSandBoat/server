-----------------------------------
-- Zone: Beadeaux (147)
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- The Afflictor System (ID, X, Radius, Z) for curse
    zone:registerCylindricalTriggerArea(1, -163, -137, 15) -- The Afflictor, Map 1, G-10
    zone:registerCylindricalTriggerArea(2, -209, -131, 15) -- The Afflictor, Map 1, F-10
    zone:registerCylindricalTriggerArea(3, -140, 20, 15) -- The Afflictor, Map 2, G-8
    zone:registerCylindricalTriggerArea(4, 261, 140, 15) -- The Afflictor, Map 2, L-6
    zone:registerCylindricalTriggerArea(5, 340, 100, 15) -- The Afflictor, Map 2, M-7, north-west
    zone:registerCylindricalTriggerArea(6, 380, 60, 15) -- The Afflictor, Map 2, M-7, south-east
    -- The Afflictor Warning Message
    zone:registerCylindricalTriggerArea(7, -163, -137, 30) -- The Afflictor, Map 1, G-10
    zone:registerCylindricalTriggerArea(8, -209, -131, 30) -- The Afflictor, Map 1, F-10
    zone:registerCylindricalTriggerArea(9, -140, 20, 30) -- The Afflictor, Map 2, G-8
    zone:registerCylindricalTriggerArea(10, 261, 140, 30) -- The Afflictor, Map 2, L-6
    zone:registerCylindricalTriggerArea(11, 340, 100, 30) -- The Afflictor, Map 2, M-7, north-west
    zone:registerCylindricalTriggerArea(12, 380, 60, 30) -- The Afflictor, Map 2, M-7, south-east

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-278, 1, 100, 246)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()
    local yPos     = player:getYPos()
    local time     = os.time()

    -- TODO:
    -- Packet not implemented correctly. This should be able to have the npc use an animation onto the player itself but current cannot.
    -- 0x0C target ID 0x12 target index with packet updated to allow target such as:
    -- npc:entityAnimationPacket('main')

    -- Afflictors Region of effect
    if
        triggerAreaID == 1 or
        triggerAreaID == 2 or
        ((triggerAreaID == 3 or triggerAreaID == 5 or triggerAreaID == 6) and yPos > 20) or
        (triggerAreaID == 4 and yPos > 35)
    then
        if not player:hasStatusEffect(xi.effect.CURSE_I) then
            if not player:hasStatusEffect(xi.effect.SILENCE) then
                GetNPCByID(ID.npc.AFFLICTOR_BASE + (triggerArea:getTriggerAreaID() -1)):entityAnimationPacket('main', player)
                player:setLocalVar('inRegion', time + 11) -- Start timer. We set it here to prevent double message.
                player:addStatusEffect(xi.effect.CURSE_I, 75, 0, 120)
                player:messageSpecial(ID.text.FEEL_NUMB)
            elseif player:getLocalVar('inRegion1') <= time then
                player:messageSpecial(ID.text.LIGHT_HEADED)
                player:setLocalVar('inRegion1', time + 11) -- Display message and set timer.
            end
        elseif
            player:hasStatusEffect(xi.effect.CURSE_I) and
            player:getLocalVar('inRegion') <= time
        then
            player:messageSpecial(ID.text.TOO_HEAVY)
            player:setLocalVar('inRegion', time + 11) -- Display message and set timer.
        end

    -- Afflictor warning message
    elseif
        triggerAreaID == 7 or
        triggerAreaID == 8 or
        ((triggerAreaID == 9 or triggerAreaID == 11 or triggerAreaID == 12) and yPos > 20) or
        (triggerAreaID == 10 and yPos > 35)
    then
        if player:getLocalVar('inRegion2') <= time then
            player:messageSpecial(ID.text.FEEL_COLD)
            player:setLocalVar('inRegion2', time + 11) -- Display message and set timer.
        end
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()
    local yPos      = player:getYPos()

    if
        triggerAreaID == 7 or
        triggerAreaID == 8 or
        ((triggerAreaID == 9 or triggerAreaID == 11 or triggerAreaID == 12) and yPos > 20) or
        (triggerAreaID == 10 and yPos > 35)
    then
        player:messageSpecial(ID.text.NORMAL_AGAIN)
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    local qm1 = GetNPCByID(ID.npc.QM1) -- Quest: Beaudeaux Smog

    if qm1 then
        if weather == xi.weather.RAIN or weather == xi.weather.SQUALL then
            qm1:setStatus(xi.status.NORMAL)
        else
            qm1:setStatus(xi.status.DISAPPEAR)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
