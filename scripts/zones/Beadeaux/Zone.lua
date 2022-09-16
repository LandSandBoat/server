-----------------------------------
-- Zone: Beadeaux (147)
-----------------------------------
local ID = require('scripts/zones/Beadeaux/IDs')
require('scripts/globals/conquest')
require('scripts/globals/npc_util')
require('scripts/globals/treasure')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/titles')
require('scripts/globals/zone')
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- The Afflictor System (RegionID, X, Radius, Z) for curse
    zone:registerRegion( 1, -163, 15, -137, 0, 0, 0) -- The Afflictor, Map 1, G-10
    zone:registerRegion( 2, -209, 15, -131, 0, 0, 0) -- The Afflictor, Map 1, F-10
    zone:registerRegion( 3, -140, 15,   20, 0, 0, 0) -- The Afflictor, Map 2, G-8
    zone:registerRegion( 4,  261, 15,  140, 0, 0, 0) -- The Afflictor, Map 2, L-6
    zone:registerRegion( 5,  340, 15,  100, 0, 0, 0) -- The Afflictor, Map 2, M-7, north-west
    zone:registerRegion( 6,  380, 15,   60, 0, 0, 0) -- The Afflictor, Map 2, M-7, south-east
    -- The Afflictor Warning Message
    zone:registerRegion( 7, -163, 30, -137, 0, 0, 0) -- The Afflictor, Map 1, G-10
    zone:registerRegion( 8, -209, 30, -131, 0, 0, 0) -- The Afflictor, Map 1, F-10
    zone:registerRegion( 9, -140, 30,   20, 0, 0, 0) -- The Afflictor, Map 2, G-8
    zone:registerRegion(10,  261, 30,  140, 0, 0, 0) -- The Afflictor, Map 2, L-6
    zone:registerRegion(11,  340, 30,  100, 0, 0, 0) -- The Afflictor, Map 2, M-7, north-west
    zone:registerRegion(12,  380, 30,   60, 0, 0, 0) -- The Afflictor, Map 2, M-7, south-east

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
    local regionID = region:GetRegionID()
    local yPos     = player:getYPos()
    local time     = os.time()

    -- TODO:
    -- Packet not implemented correctly. This should be able to have the npc use an animation onto the player itself but current cannot.
    -- 0x0C target ID 0x12 target index with packet updated to allow target such as:
    -- npc:entityAnimationPacket("main")

    -- Afflictors Region of effect
    if
        regionID == 1 or
        regionID == 2 or
        ((regionID == 3 or regionID == 5 or regionID == 6) and yPos > 20) or
        (regionID == 4 and yPos > 35)
    then
        if not player:hasStatusEffect(xi.effect.CURSE_I) then
            if not player:hasStatusEffect(xi.effect.SILENCE) then
                GetNPCByID(ID.npc.AFFLICTOR_BASE + (region:GetRegionID() -1)):entityAnimationPacket("main", player)
                player:setLocalVar("inRegion", time + 11) -- Start timer. We set it here to prevent double message.
                player:addStatusEffect(xi.effect.CURSE_I, 75, 0, 120)
                player:messageSpecial(ID.text.FEEL_NUMB)
            elseif player:getLocalVar("inRegion1") <= time then
                player:messageSpecial(ID.text.LIGHT_HEADED)
                player:setLocalVar("inRegion1", time + 11) -- Display message and set timer.
            end
        elseif player:hasStatusEffect(xi.effect.CURSE_I) and player:getLocalVar("inRegion") <= time then
            player:messageSpecial(ID.text.TOO_HEAVY)
            player:setLocalVar("inRegion", time + 11) -- Display message and set timer.
        end

    -- Afflictor warning message
    elseif
        regionID == 7 or
        regionID == 8 or
        ((regionID == 9 or regionID == 11 or regionID == 12) and yPos > 20) or
        (regionID == 10 and yPos > 35)
    then
        if player:getLocalVar("inRegion2") <= time then
            player:messageSpecial(ID.text.FEEL_COLD)
            player:setLocalVar("inRegion2", time + 11) -- Display message and set timer.
        end
    end
end

zone_object.onRegionLeave = function(player, region)
    local regionID = region:GetRegionID()
    local yPos      = player:getYPos()

    if
        regionID == 7 or
        regionID == 8 or
        ((regionID == 9 or regionID == 11 or regionID == 12) and yPos > 20) or
        (regionID == 10 and yPos > 35)
    then
        player:messageSpecial(ID.text.NORMAL_AGAIN)
    end
end

zone_object.onZoneWeatherChange = function(weather)
    local qm1 = GetNPCByID(ID.npc.QM1) -- Quest: Beaudeaux Smog
    if weather == xi.weather.RAIN or weather == xi.weather.SQUALL then
        qm1:setStatus(xi.status.NORMAL)
    else
        qm1:setStatus(xi.status.DISAPPEAR)
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 121 and npcUtil.completeQuest(player, xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS, {title=xi.title.DARK_SIDER, var="ZeruhnMines_Zeid_CS"}) then
        player:unlockJob(xi.job.DRK)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_DARK_KNIGHT)
    elseif csid == 122 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL)
    end
end

return zone_object
