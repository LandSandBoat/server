-----------------------------------
-- Zone: Lower_Jeuno (245)
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/zones/Lower_Jeuno/globals")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/pathfind")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 23, 0, -43, 44, 7, -39) -- Inside Tenshodo HQ
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if (month == 12 and day >= 5) or (month == 1 and day <= 5) then
        player:ChangeMusic(0, 239)
        player:ChangeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    if player:getCurrentMission(COP) == xi.mission.id.cop.TENDING_AGED_WOUNDS and player:getCharVar("PromathiaStatus") == 0 then
        player:setCharVar("PromathiaStatus", 1)
        cs = 70
    elseif ENABLE_ACP == 1 and player:getCurrentMission(ACP) == xi.mission.id.acp.A_CRYSTALLINE_PROPHECY and player:getMainLvl() >=10 then
        cs = 10094
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(41.2, -5, 84, 85)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local VanadielHour = VanadielHour()
    local playerOnQuestId = GetServerVariable("[JEUNO]CommService")
    local playerOnQuest = GetPlayerByID(playerOnQuestId)

    -- Community Service Quest
    -- 7AM: it's daytime. turn off all the lights
    if VanadielHour == 7 then
        for i=0, 11 do
            local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
            lamp:setAnimation(xi.anim.CLOSE_DOOR)
        end

    -- 8PM: make quest available
    -- notify anyone in zone with membership card that zauko is recruiting
    elseif VanadielHour == 18 then
        SetServerVariable("[JEUNO]CommService", 0)
        local players = zone:getPlayers()
        for name, player in pairs(players) do
            if player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) then
                player:messageSpecial(ID.text.ZAUKO_IS_RECRUITING)
            end
        end

    -- 9PM: notify the person on the quest that they can begin lighting lamps
    elseif VanadielHour == 21 then
        local playerOnQuest = GetPlayerByID(GetServerVariable("[JEUNO]CommService"))
        if playerOnQuest then
            playerOnQuest:startEvent(114)
        end

    -- 1AM: if nobody has accepted the quest yet, NPC Vhana Ehgaklywha takes up the task
    -- she starts near Zauko and paths all the way to the Rolanberry exit.
    -- xi.path.flag.WALLHACK because she gets stuck on some terrain otherwise.
    elseif VanadielHour == 1 then
        if playerOnQuestId == 0 then
            local npc = GetNPCByID(ID.npc.VHANA_EHGAKLYWHA)
            npc:clearPath()
            npc:setStatus(0)
            npc:initNpcAi()
            npc:setPos(xi.path.first(LOWER_JEUNO.lampPath))
            npc:pathThrough(xi.path.fromStart(LOWER_JEUNO.lampPath), bit.bor(xi.path.flag.WALLHACK))
        end

    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 10094 then
        player:completeMission(xi.mission.log_id.ACP, xi.mission.id.acp.A_CRYSTALLINE_PROPHECY)
        player:addMission(xi.mission.log_id.ACP, xi.mission.id.acp.THE_ECHO_AWAKENS)
    end
end

return zone_object
