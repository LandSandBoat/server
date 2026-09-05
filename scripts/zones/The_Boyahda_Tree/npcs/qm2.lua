-----------------------------------
-- Area: The Boyahda Tree
--  NPC: qm2 (???)
-- Involved in Quest: Searching for the Right Words
-- !pos 34.651 -20.183 -61.647 153
-----------------------------------
local ID = zones[xi.zone.THE_BOYAHDA_TREE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- ??? is active between 19:00 and 4:00, except during the New Moon.
    local currentHour = VanadielHour()

    if
        (currentHour >= 19 or currentHour < 4) and
        getVanadielMoonCycle() ~= xi.moonCycle.NEW_MOON
    then
        player:messageSpecial(ID.text.CAN_SEE_SKY)
    else
        player:messageSpecial(ID.text.CANNOT_SEE_MOON)
    end
end

return entity
