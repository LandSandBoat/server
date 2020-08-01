-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Gateway (Arrapago)
-- !pos -580 0 -159 72
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.REMNANTS_PERMIT) then
        local mask = -2
        if player:getMainLvl() >= 96 then
            mask = -14
        elseif player:getMainLvl() >= 65 then
            mask = -6
        end

        player:startEvent(410, 0, mask, 0, 0, 10)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option, target)
    local instanceid = bit.rshift(option, 19) + 70

    local party = player:getParty()

    if party ~= nil then
        for i, v in ipairs(party) do
            if not v:hasKeyItem(tpz.ki.REMNANTS_PERMIT) then
                player:messageText(target, ID.text.MEMBER_NO_REQS, false)
                player:instanceEntry(target, 1)
                return
            elseif v:getZoneID() == player:getZoneID() and v:checkDistance(player) > 50 then
                player:messageText(target, ID.text.MEMBER_TOO_FAR, false)
                player:instanceEntry(target, 1)
                return
            elseif v:checkImbuedItems() then
                player:messageText(target, ID.text.MEMBER_IMBUED_ITEM, false)
                player:instanceEntry(target, 1)
                return
            end
        end
    end

    player:createInstance(instanceid, 76)

end

function onEventFinish(player, csid, option, target)
    if (csid == 410 and option == 4) or csid == 116 then
        player:setPos(0, 0, 0, 0, 76)
    end
end

function onInstanceCreated(player, target, instance)
    if instance then
        player:setInstance(instance)
        player:instanceEntry(target, 4)
        player:delKeyItem(tpz.ki.REMNANTS_PERMIT)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:startEvent(116, 2)
                    v:delKeyItem(tpz.ki.REMNANTS_PERMIT)
                    v:setLocalVar("SalvageSilverSea", 1)
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end
end
