-----------------------------------
-- Area: Caedarva Mire
-- Door: Runic Seal
-- !pos -353 -3 -20 79
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Caedarva_Mire/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT) then
        player:setCharVar("ShadesOfVengeance", 1)
        player:startEvent(143, 79, -6, 0, 99, 3, 0)
    elseif player:hasKeyItem(tpz.ki.PERIQIA_ASSAULT_ORDERS) then
        local assaultid = player:getCurrentAssault()
        local recommendedLevel = getRecommendedAssaultLevel(assaultid)
        local armband = 0
        if player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) then
            armband = 1
        end
        player:startEvent(143, assaultid, -4, 0, recommendedLevel, 3, armband)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option, target)

    local assaultid = player:getCurrentAssault()

    local cap = bit.band(option, 0x03)
    if cap == 0 then
        cap = 99
    elseif cap == 1 then
        cap = 70
    elseif cap == 2 then
        cap = 60
    else
        cap = 50
    end

    player:setCharVar("AssaultCap", cap)

    local party = player:getParty()

    if player:getCharVar("ShadesOfVengeance") == 1 then
        if (party ~= nil) then
            for i, v in ipairs(party) do
                if v:getCurrentMission(TOAU) < tpz.mission.id.toau.SHADES_OF_VENGEANCE then
                    player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                    player:instanceEntry(target, 1)
                elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                    player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                    player:instanceEntry(target, 1)
                    return
                end
            end
        end

        player:createInstance(79, 56)
    else
        if party ~= nil then
            for i, v in ipairs(party) do
                if (not (v:hasKeyItem(tpz.ki.PERIQIA_ASSAULT_ORDERS) and v:getCurrentAssault() == assaultid)) then
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

        player:createInstance(player:getCurrentAssault(), 56)
    end

end

function onEventFinish(player, csid, option, target)

    if csid == 133 or (csid == 143 and option == 4) then
        player:setPos(0, 0, 0, 0, 56)
    end
end

function onInstanceCreated(player, target, instance)
    if instance and player:getCharVar("ShadesOfVengeance") == 1 then
        player:setInstance(instance)
        player:instanceEntry(target, 4)

        player:setCharVar("ShadesOfVengeance", 0)
        player:delKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if (v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID()) then
                    v:setInstance(instance)
                    v:startEvent(133)
                    v:delKeyItem(tpz.ki.PERIQIA_ASSAULT_AREA_ENTRY_PERMIT)
                end
            end
        end
    elseif (instance) then
        instance:setLevelCap(player:getCharVar("AssaultCap"))
        player:setCharVar("AssaultCap", 0)
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:delKeyItem(tpz.ki.PERIQIA_ASSAULT_ORDERS)
        player:delKeyItem(tpz.ki.ASSAULT_ARMBAND)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:startEvent(133, 3)
                    v:delKeyItem(tpz.ki.PERIQIA_ASSAULT_ORDERS)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end
