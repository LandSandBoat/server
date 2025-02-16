-----------------------------------
-- Zone: Attohwa_Chasm (7)
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Poison Flowers!
    zone:registerCylindricalTriggerArea(1, -475.809, 316.499, 5)
    zone:registerCylindricalTriggerArea(2, -440.938, 281.749, 7)
    zone:registerCylindricalTriggerArea(3, -388.027, 264.831, 5)
    zone:registerCylindricalTriggerArea(4, -534.104, 217.833, 5)
    zone:registerCylindricalTriggerArea(5, -530.000, 210.000, 5)
    zone:registerCylindricalTriggerArea(6, -482.192, 198.647, 5)
    zone:registerCylindricalTriggerArea(7, -595.756, 157.532, 7)
    zone:registerCylindricalTriggerArea(8, -514.000, 166.000, 5)
    zone:registerCylindricalTriggerArea(9, -396.844, 164.790, 5)
    zone:registerCylindricalTriggerArea(10, -382.919, 143.572, 5)
    zone:registerCylindricalTriggerArea(11, -537.558, 102.683, 5)
    zone:registerCylindricalTriggerArea(12, -393.979, 101.877, 5)
    zone:registerCylindricalTriggerArea(13, -367.892, 75.774, 5)
    zone:registerCylindricalTriggerArea(14, -369.333, 69.333, 5)
    zone:registerCylindricalTriggerArea(15, -351.717, 64.773, 5)
    zone:registerCylindricalTriggerArea(16, -386.000, 50.000, 5)
    zone:registerCylindricalTriggerArea(17, -360.705, 51.505, 5)
    zone:registerCylindricalTriggerArea(18, -475.667, 37.081, 5)
    zone:registerCylindricalTriggerArea(19, -321.902, 36.697, 5)
    zone:registerCylindricalTriggerArea(20, -351.916, 10.501, 5)
    zone:registerCylindricalTriggerArea(21, -554.739, -3.057, 5)
    zone:registerCylindricalTriggerArea(22, -397.667, -5.563, 5)
    zone:registerCylindricalTriggerArea(23, -330.062, -18.832, 5)
    zone:registerCylindricalTriggerArea(24, -233.015, -19.049, 5)
    zone:registerCylindricalTriggerArea(25, -553.523, -72.071, 5)
    zone:registerCylindricalTriggerArea(26, -535.904, -67.914, 7)
    zone:registerCylindricalTriggerArea(27, -435.438, -74.171, 5)
    zone:registerCylindricalTriggerArea(28, -369.343, -73.449, 5)
    zone:registerCylindricalTriggerArea(29, -238, -118, 5)
    zone:registerCylindricalTriggerArea(30, -385.349, -173.973, 5)

    xi.helm.initZone(zone, xi.helmType.EXCAVATION)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-159, 10, -261, 0)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    -- TODO: Gasponia's shouldn't "always" poison you. However, in retail trigger areas constantly reapply themselves without having to re-enter the trigger area.
    -- That doesn't happen currently so I'm leaving it as-is for now.
    local triggerAreaID = triggerArea:getTriggerAreaID()

    if triggerAreaID <= 30 then
        local gasponia = GetNPCByID(ID.npc.GASPONIA_OFFSET + triggerAreaID - 1)
        if gasponia ~= nil then
            gasponia:openDoor(3)

            if not player:hasStatusEffect(xi.effect.POISON) then
                player:addStatusEffect(xi.effect.POISON, 15, 0, math.random(30, 60))
                player:messageSpecial(ID.text.GASPONIA_POISON)
            end
        end
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onGameHour = function()
    --[[
        the hard-coded id that was here was wrong. there are 22 miasmas in attohwa chasm
        starting at ID.npc.MIASMA_OFFSET. some are supposed to toggle open, but need retail test
        to determine which.  for now, they're just statically set per npc_list.animation
    --]]
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
