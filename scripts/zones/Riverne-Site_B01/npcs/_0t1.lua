-----------------------------------
-- Area: Riverne Site #B01
--  NPC: Unstable Displacement
-----------------------------------
local riverneBGlobal = require("scripts/zones/Riverne-Site_B01/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    riverneBGlobal.unstableDisplacementTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    riverneBGlobal.unstableDisplacementTrigger(player, npc, 7)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 7 then
        for _, entry in pairs(player:getNotorietyList()) do
            entry:clearEnmity(player) -- reset hate on player after teleporting
        end
    end
end

return entity
