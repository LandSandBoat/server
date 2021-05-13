-----------------------------------
-- Area: Mamool Ja Training Grounds
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/utils/assault")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if instance:completed() then
        player:startEvent(100, 1)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 100 and option == 1 then
        assaultUtil.runeReleaseFinish(player, MAMOOL_ASSAULT_POINT, ID.text)
    elseif csid == 102 then
        local instance = player:getInstance()
        local chars = instance:getChars()

        for i, v in pairs(chars) do
            v:setPos(0, 0, 0, 0, xi.zone.BHAFLAU_THICKETS)
        end
    end
end

return entity
