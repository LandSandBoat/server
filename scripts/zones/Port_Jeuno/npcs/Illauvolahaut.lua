-----------------------------------
-- Area: Port Jeuno
--  NPC: Illauvolahaut
-- !pos -12 8 54 246
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local KazhPass = player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
    local Gil = player:getGil()

    if not KazhPass then
        player:startEvent(35) -- without pass
    elseif KazhPass and Gil < 200 then
        player:startEvent(45) -- Pass without money
    elseif KazhPass then
        player:startEvent(37) -- Pass with money
    end
end

-- 41  without addons (ZM) ?
entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 37 then
        local Z = player:getZPos()

        if Z >= 58 and Z <= 61 then
            player:delGil(200)
        end
    end
end

return entity
