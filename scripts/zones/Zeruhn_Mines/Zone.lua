-----------------------------------
--
-- Zone: Zeruhn_Mines (172)
--
-----------------------------------
local ID = require("scripts/zones/Zeruhn_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/quests")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.MINING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if prevZone == xi.zone.PALBOROUGH_MINES then
        cs = 150
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED then
            if player:getCharVar("ZeruhnMines_Zeid_CS") == 0 then
                cs = 130
            elseif not player:hasItem(16607) then
                cs = 131
            end
        elseif player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED then
            if not player:hasItem(16607) then
                cs = 131
            end
        end
    elseif player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-270.707, 14.159, -20.268, 0)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 130 or csid == 131 then
        if player:getFreeSlotsCount() > 0 then
            player:addItem(16607)
            player:setCharVar("ChaosbringerKills", 0)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16607)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16607)
        end
        player:setCharVar("ZeruhnMines_Zeid_CS", 1)
    end
end

return zone_object
