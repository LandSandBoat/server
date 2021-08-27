-----------------------------------
--
-- Zone: Beadeaux (147)
--
-----------------------------------
local ID = require("scripts/zones/Beadeaux/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/treasure")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Regions 1-6 are for the Afflictor System (RegionID, X, Radius, Z)
    zone:registerRegion(1, -163, 10, -137, 0, 0, 0)
    zone:registerRegion(2, -209, 10, -131, 0, 0, 0)
    zone:registerRegion(3, -140, 10,   20, 0, 0, 0)
    zone:registerRegion(4,  261, 10,  140, 0, 0, 0)
    zone:registerRegion(5,  340, 10,  100, 0, 0, 0)
    zone:registerRegion(6,  380, 10,   60, 0, 0, 0)

    xi.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(387.382, 38.029, 19.694, 3)
    end

    if prevZone == xi.zone.PASHHOW_MARSHLANDS then
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED and player:getCharVar("ChaosbringerKills") >= 100 then
            cs = 121
        elseif player:getMainJob() == xi.job.DRK and player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET) == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL) == QUEST_AVAILABLE then
            cs = 122
        end
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    if region:GetRegionID() <= 6 then
        if not player:hasStatusEffect(xi.effect.CURSE_I) and not player:hasStatusEffect(xi.effect.SILENCE) then
            player:addStatusEffect(xi.effect.CURSE_I, 50, 0, 300)
            if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_CURSE_COLLECTOR) == QUEST_ACCEPTED and player:getCharVar("cCollectCurse") == 0 then
                player:setCharVar("cCollectCurse", 1)
            end
        end
    end
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 121 and npcUtil.completeQuest(player, BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS, {title=xi.title.DARK_SIDER, var="ZeruhnMines_Zeid_CS"}) then
        player:unlockJob(xi.job.DRK)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_DARK_KNIGHT)
    elseif csid == 122 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL)
    end
end

return zone_object
