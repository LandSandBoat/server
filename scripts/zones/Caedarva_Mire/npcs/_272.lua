-----------------------------------
-- Area: Caedarva Mire
-- Door: Runic Seal
-- !pos 486 -23 -500 79
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Fix, implement & balance Assault
    --[[
    if (player:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS)) then
        local assaultid = player:getCurrentAssault()
        local recommendedLevel = getRecommendedAssaultLevel(assaultid)
        local armband = 0
        if (player:hasKeyItem(xi.ki.ASSAULT_ARMBAND)) then
            armband = 1
        end
        if (assaultid ~= 0) then
            player:startEvent(140, assaultid, -4, 0, recommendedLevel, 0, armband)
        else
            player:messageSpecial(ID.text.NOTHING_HAPPENS)
        end
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
    ]]
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

entity.onEventUpdate = function(player, csid, option, target)

    local assaultid = player:getCurrentAssault()

    local cap = bit.band(option, 0x03)
    if (cap == 0) then
        cap = 99
    elseif (cap == 1) then
        cap = 70
    elseif (cap == 2) then
        cap = 60
    else
        cap = 50
    end

    player:setCharVar("AssaultCap", cap)

    local party = player:getParty()

    if (party ~= nil) then
        for i, v in pairs(party) do
            if (not (v:hasKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS) and v:getCurrentAssault() == assaultid)) then
                player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                player:instanceEntry(target, 1)
                return
            elseif (v:getZone() == player:getZone() and v:checkDistance(player) > 50) then
                player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                player:instanceEntry(target, 1)
                return
            end
        end
    end

    player:createInstance(player:getCurrentAssault())

end

entity.onEventFinish = function(player, csid, option, target)

    if csid == 140 and option == 4 then
        player:setPos(0, 0, 0, 0, 69)
    end
end

entity.onInstanceCreated = function(player, target, instance)
    if (instance) then
        instance:setLevelCap(player:getCharVar("AssaultCap"))
        player:setCharVar("AssaultCap", 0)
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:delKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS)
        player:delKeyItem(xi.ki.ASSAULT_ARMBAND)

        local party = player:getParty()
        if (party ~= nil) then
            for i, v in pairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:startEvent(130, 0)
                    v:delKeyItem(xi.ki.LEUJAOAM_ASSAULT_ORDERS)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end

return entity
