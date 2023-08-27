-----------------------------------
-- Zone: North_Gustaberg_[S] (88)
-----------------------------------
local ID = require('scripts/zones/North_Gustaberg_[S]/IDs')
require('scripts/globals/quests')
require('scripts/globals/helm')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.helm.initZone(zone, xi.helm.type.MINING)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(380.038, -2.25, 147.627, 192)
    end

    if
        prevZone == xi.zone.BASTOK_MARKETS_S and
        player:getCampaignAllegiance() > 0 and
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR) == QUEST_AVAILABLE
    then
        cs = 1
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR)
        player:addKeyItem(xi.ki.CLUMP_OF_ANIMAL_HAIR)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CLUMP_OF_ANIMAL_HAIR)
    end
end

return zoneObject
