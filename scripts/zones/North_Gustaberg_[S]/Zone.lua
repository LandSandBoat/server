-----------------------------------
--
-- Zone: North_Gustaberg_[S] (88)
--
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(380.038, -2.25, 147.627, 192)
    end
    if (prevZone == tpz.zone.BASTOK_MARKETS_S and player:getCampaignAllegiance() > 0 and player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.BETTER_PART_OF_VALOR) == QUEST_AVAILABLE) then
        cs = 1
    end
    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if (csid == 1) then
        player:addQuest(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.BETTER_PART_OF_VALOR)
        player:addKeyItem(tpz.ki.CLUMP_OF_ANIMAL_HAIR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CLUMP_OF_ANIMAL_HAIR)
    end
end

return zone_object
