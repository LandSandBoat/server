-----------------------------------
-- Zone: Arrapago Remnants
-----------------------------------
local ID = require('scripts/zones/Arrapago_Remnants/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, 420, -339, 5)
    zone:registerCylindricalTriggerArea(2, 420, -499, 5)
    zone:registerCylindricalTriggerArea(3, 259, -499, 5)
    zone:registerCylindricalTriggerArea(4, 259, -339, 5)
    zone:registerCylindricalTriggerArea(5, 340, 100, 5)
    zone:registerCylindricalTriggerArea(6, 339, 419, 5)
    zone:registerCylindricalTriggerArea(7, 339, 500, 5)
    zone:registerCylindricalTriggerArea(8, -379, -620, 5)
    zone:registerCylindricalTriggerArea(9, -300, -461, 5)
    zone:registerCylindricalTriggerArea(10, -339, -99, 5)
    zone:registerCylindricalTriggerArea(11, -339, 300, 5)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 72)
        return cs
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:addTempItem(5399)

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    local instance = player:getInstance()
    local chars = instance:getChars()

    if csid == 1 then
        for i, v in pairs(chars) do
            v:setPos(0, 0, 0, 0, 72)
        end
    elseif csid >= 200 and csid <= 210 and option == 1 then
        for i, v in pairs(chars) do
            if v:getID() ~= player:getID() then
                v:startEvent(3)
                v:timer(4000, function(playerArg)
                    local entrypos = instance:getEntryPos()
                    playerArg:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
                end)
            end

            v:setHP(v:getMaxHP())
            v:setMP(v:getMaxMP())
            if v:getPet() then
                local pet = v:getPet()
                pet:setHP(pet:getMaxHP())
                pet:setMP(pet:getMaxMP())
            end
        end
    end
end

zoneObject.onInstanceLoadFailed = function()
    return 72
end

return zoneObject
