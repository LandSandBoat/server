-----------------------------------
-- Zone: Qufim_Island (126)
-----------------------------------
local ID = require('scripts/zones/Qufim_Island/IDs')
require('scripts/globals/conquest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-286.271, -21.619, 320.084, 255)
    end

    if prevZone == xi.zone.BEHEMOTHS_DOMINION and player:getCharVar("theTalekeepersGiftKilledNM") >= 3 then
        cs = 100
    end

    return cs
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 100 then
        npcUtil.completeQuest(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_GIFT, { item = 12638, fame = 60, title = xi.title.PARAGON_OF_WARRIOR_EXCELLENCE, var = { "theTalekeeperGiftCS", "theTalekeepersGiftKilledNM" } })
    end
end

return zoneObject
