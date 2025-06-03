-----------------------------------
-- Zone: Arrapago Remnants
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, 420, -339, 4)
    zone:registerCylindricalTriggerArea(2, 420, -499, 4)
    zone:registerCylindricalTriggerArea(3, 259, -499, 4)
    zone:registerCylindricalTriggerArea(4, 259, -339, 4)
    zone:registerCylindricalTriggerArea(5, 340, 100, 4)
    zone:registerCylindricalTriggerArea(6, 339, 419, 4)
    zone:registerCylindricalTriggerArea(7, 339, 500, 4)
    zone:registerCylindricalTriggerArea(8, -379, -620, 4)
    zone:registerCylindricalTriggerArea(9, -300, -461, 4)
    zone:registerCylindricalTriggerArea(10, -339, -99, 4)
    zone:registerCylindricalTriggerArea(11, -339, 300, 4)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(-579, -0.050, -100, 192, xi.zone.ALZADAAL_UNDERSEA_RUINS)

        return
    end

    local pos = player:getPos()

    if
        pos.x == 0 and
        pos.y == 0 and
        pos.z == 0
    then
        local entrypos = instance:getEntryPos()

        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
        player:startEvent(101)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
    if not instance then
        return
    end

    local chars    = instance:getChars()

    if csid == 1 then
        for _, players in pairs(chars) do
            players:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end

    elseif
        csid >= 200 and
        csid <= 210 and
        option == 1
    then
        for _, players in pairs(chars) do
            if players:getID() ~= player:getID() then
                players:startEvent(3)
                players:timer(4000, function(playerArg)
                    local entrypos = instance:getEntryPos()
                    playerArg:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
                end)
            end

            -- Full heal.
            players:setHP(players:getMaxHP())
            players:setMP(players:getMaxMP())
            if players:getPet() then
                local pet = players:getPet()
                pet:setHP(pet:getMaxHP())
                pet:setMP(pet:getMaxMP())
            end
        end
    end
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.ALZADAAL_UNDERSEA_RUINS
end

return zoneObject
