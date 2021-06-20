-----------------------------------
-- Area: Arrapago Reef
--  NPC: Cutter
-- The ship for The Black Coffin Battle (TOAU-15)
-- !pos -462 -2 -394 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN) then
        player:setLocalVar("theblackcoffinfight", 1)
        player:startEvent(221, 53, -6, 0, 99, 6, 0)
    elseif player:hasKeyItem(xi.ki.LIFE_FLOAT) and player:getCharVar("AgainstAllOdds") == 2 then
        player:setLocalVar("againstalloddsfight", 1)
        player:startEvent(221, 54, -9, 0, 99, 6, 0)
    else
        player:messageSpecial(ID.text.YOU_NO_REQS)
    end
end

entity.onEventUpdate = function(player, csid, option, target)

    local party = player:getParty()
    if player:getLocalVar("theblackcoffinfight") == 1 then
        if party ~= nil then
            for i, v in pairs(party) do
                if not v:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN) then
                    player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                    player:instanceEntry(target, 1)
                    return
                elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                    player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                    player:instanceEntry(target, 1)
                    return
                end
            end
        end

        player:createInstance(53)
        player:setLocalVar("theblackcoffinfight", 0)

    elseif player:getLocalVar("againstalloddsfight") == 1 then
        if (party ~= nil) then
            for i, v in pairs(party) do
                if v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                    player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                    player:instanceEntry(target, 1)
                    return
                end
            end
        end

        player:createInstance(54)
        player:setLocalVar("againstalloddsfight", 0)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 221 and option == 4 then
        local party = player:getParty()
        if (party ~= nil) then
            for i, v in pairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:startEvent(222, 6) -- may be wrong id but better than 90
                end
            end
        end
        player:setPos(0, 0, 0, 0, 60)
    end
end

entity.onInstanceCreated = function(player, target, instance)
    if instance then
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        local party = player:getParty()
        if party ~= nil then
            for i, v in pairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:instanceEntry(target, 4)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end

return entity
