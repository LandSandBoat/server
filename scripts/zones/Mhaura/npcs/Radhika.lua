-----------------------------------
-- Area: Mhaura
--  NPC: Radhika
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= 39 then
        local currentTime = VanadielHour() * 60 + VanadielMinute()
        while currentTime >= 480 do
            currentTime = currentTime - 480
        end

        local destination = 7
        if currentTime >= 465 then
            destination = 0
        elseif currentTime >= 400 then
            destination = 1
        elseif currentTime >= 385 then
            destination = 2
        elseif currentTime >= 240 then
            destination = 3
        elseif currentTime >= 225 then
            destination = 4
        elseif currentTime >= 160 then
            destination = 5
        elseif currentTime >= 145 then
            destination = 6
        end

        player:startEvent(224, 0, destination)

    -- Inside dock zone.
    else
        player:startEvent(222)
    end
end

return entity
