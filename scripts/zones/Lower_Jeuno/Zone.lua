-----------------------------------
-- Zone: Lower_Jeuno (245)
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
local lowerJeunoGlobal = require("scripts/zones/Lower_Jeuno/globals")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/pathfind")
require("scripts/settings/main")
require("scripts/globals/chocobo")
require("scripts/globals/status")
require("modules/module_utils")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, 23, 0, -43, 44, 7, -39) -- Inside Tenshodo HQ. TODO: Find out if this is used other than in ZM 17 (not anymore). Remove if not.
    xi.chocobo.initZone(zone)
	
	local horro = zone:insertDynamicEntity({
        objtype = xi.objType.NPC,
        name = "Hunter",
        -- See documentation model_ids.txt, or play around with !costume (remember that the bytes are swapped!)
        modelId = 2205,
        x = 6.712,
        y = 0.000,
        z = 14.788,
        rotation = 130,
        triggerable = true,
    })

    -- Use the mob object however you like
    -- horro:getID() etc.
    utils.unused(hunter)

    -- There might not be any NPCs populated for Lower_Jeuno,
    -- (see npc_list.sql) so the npcs table might not exist.
    -- We're going to make it now.
    -- This shouldn't be needed for other zones.
    -- xi.zones.Lower_Jeuno.npcs = xi.zones.Lower_Jeuno.npcs or {}

    -- Build a cache entry for the new NPC
    xi.zones.Lower_Jeuno.npcs.Hunter = {}

    -- Attach regular event handlers to that cache entry
    xi.zones.Lower_Jeuno.npcs.Hunter.onTrade = function(player, npc, trade)
    end

    xi.zones.Lower_Jeuno.npcs.Hunter.onTrigger = function(player, npc)
        player:PrintToPlayer("Welcome to Lower Jeuno!", 0, npc:getName())
    end

    xi.zones.Lower_Jeuno.npcs.Hunter.onEventUpdate = function(player, csid, option)
    end

    xi.zones.Lower_Jeuno.npcs.Hunter.onEventFinish = function(player, csid, option)
    end
--end)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    -- Retail start/end dates vary, I am going with Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:ChangeMusic(0, 239)
        player:ChangeMusic(1, 239)
        -- No need for an 'else' to change it back outside these dates as a re-zone will handle that.
    end

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
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
            npc:setPos(xi.path.first(lowerJeunoGlobal.lampPath))
            npc:pathThrough(xi.path.fromStart(lowerJeunoGlobal.lampPath), bit.bor(xi.path.flag.WALLHACK))
        end

    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return m, zone_object
