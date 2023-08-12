-----------------------------------
-- Zone: Arrapago Remnants
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 420, 5, -339, 0, 0, 0)
    zone:registerTriggerArea(2, 420, 5, -499, 0, 0, 0)
    zone:registerTriggerArea(3, 259, 5, -499, 0, 0, 0)
    zone:registerTriggerArea(4, 259, 5, -339, 0, 0, 0)
    zone:registerTriggerArea(5, 340, 5, 100, 0, 0, 0)
    zone:registerTriggerArea(6, 339, 5, 419, 0, 0, 0)
    zone:registerTriggerArea(7, 339, 5, 500, 0, 0, 0)
    zone:registerTriggerArea(8, -379, 5, -620, 0, 0, 0)
    zone:registerTriggerArea(9, -300, 5, -461, 0, 0, 0)
    zone:registerTriggerArea(10, -339, 5, -99, 0, 0, 0)
    zone:registerTriggerArea(11, -339, 5, 300, 0, 0, 0)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)

        return cs
    end

    local pos = player:getPos()

    if
        pos.x == 0 and
        pos.y == 0 and
        pos.z == 0
    then
        local entrypos = instance:getEntryPos()

        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:addTempItem(5399)

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
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
