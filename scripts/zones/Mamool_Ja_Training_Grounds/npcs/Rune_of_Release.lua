-----------------------------------
-- Area: Mamool Ja Training Grounds
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
require("scripts/globals/assault")
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
        xi.assaultUtil.runeReleaseFinish(player)
    end
end

return entity
