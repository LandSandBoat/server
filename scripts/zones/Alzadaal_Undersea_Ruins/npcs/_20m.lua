-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Runic Seal
-- !pos 125 -2 20 72
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/besieged")
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS and player:hasKeyItem(tpz.ki.NYZUL_ISLE_ROUTE) and player:getCharVar("AhtUrganStatus") == 1 then
        player:setLocalVar("PathOfDarkness", 1)
        player:startEvent(405, 58, -6, 0, 99, 5, 0)
    elseif player:getCurrentMission(TOAU) == tpz.mission.id.toau.NASHMEIRAS_PLEA and player:hasKeyItem(tpz.ki.MYTHRIL_MIRROR) and player:getCharVar("AhtUrganStatus") == 1 then
        player:setLocalVar("NashmeirasPlea", 1)
        player:startEvent(405, 59, -10, 0, 99, 5, 0)
    elseif player:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) then
        local assaultid = player:getCurrentAssault()
        local recommendedLevel = getRecommendedAssaultLevel(assaultid)
        local armband = 0
        if player:hasKeyItem(tpz.ki.ASSAULT_ARMBAND) then
            armband = 1
        end
        player:startEvent(405, assaultid, -4, 0, recommendedLevel, 5, armband)
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

function onEventUpdate(player, csid, option, target)

    if not csid == 405 then
        return
    end

    -- Begin Ugly Hack
    --
    -- For some currently unknown reason, the Nyzul event can
    -- spam event updates uncontrollably. Until we can figure
    -- out why, I used a double lock to hack around it. The
    -- first latch is auto set here, which suppresses future
    -- updates which the instance is initialized. The 2nd latch
    -- is set after the instance is created. Then we use that
    -- to force terminate the event so that we can go into the
    -- instance successfully.

    if player:getLocalVar("NyzulReady") == 1 then -- Latch 2
        player:updateEvent(405, 3, 3, 3, 3, 3, 3, 3) -- Force terminate the event
        return
    elseif player:getLocalVar("NyzulLoopGuard") == 1 then
        return -- Suppress Update Spam
    else
        player:setLocalVar("NyzulLoopGuard", 1) -- Latch 1
    end
    -- End Ugly Hack

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

    local pathOfDarkness = player:getLocalVar("PathOfDarkness")
    local nashmeirasPlea = player:getLocalVar("NashmeirasPlea")
    local party = player:getParty()

    if pathOfDarkness == 1 then

        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() then
                    if v:getCurrentMission(TOAU) < tpz.mission.id.toau.PATH_OF_DARKNESS then
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
        end

        player:createInstance(58, 77)
    elseif nashmeirasPlea == 1 then

        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() then
                    if v:getCurrentMission(TOAU) < tpz.mission.id.toau.NASHMEIRAS_PLEA then
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
        end

        player:createInstance(59, 77)
    else

        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() then
                    if not v:hasKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS) and v:getCurrentAssault() == assaultid then
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
        end

        player:createInstance(player:getCurrentAssault(), 77)
    end

end

function onEventFinish(player, csid, option, target)

    if csid == 405 and option == 1073741824 and player:getLocalVar("NyzulReady") == 1 then
        player:startEvent(116, 2) -- This means the event was force terminated. Loop into the entrance animation.
    elseif csid == 116 or (csid == 405 and option == 4) and not(option == 1073741824) then
        player:setPos(0, 0, 0, 0, 77)
    end
end

function onInstanceCreated(player, target, instance)
    local pathOfDarkness = player:getLocalVar("PathOfDarkness")
    local nashmeirasPlea = player:getLocalVar("NashmeirasPlea")

    if instance then
        if pathOfDarkness == 1 then
            player:setLocalVar("PathOfDarkness", 0)
            player:delKeyItem(tpz.ki.NYZUL_ISLE_ROUTE)
        elseif nashmeirasPlea == 1 then
            player:setLocalVar("NashmeirasPlea", 0)
            player:delKeyItem(tpz.ki.MYTHRIL_MIRROR)
        else
            instance:setLevelCap(player:getCharVar("AssaultCap"))
            player:setCharVar("AssaultCap", 0)
            player:delKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS)
            player:delKeyItem(tpz.ki.ASSAULT_ARMBAND)
        end

        player:setInstance(instance)
        player:instanceEntry(target, 4)

        local party = player:getParty()
        if party ~= nil then
            for i, v in ipairs(party) do
                if v:getID() ~= player:getID() and v:getZoneID() == player:getZoneID() then
                    v:setInstance(instance)
                    v:startEvent(116, 2)
                    v:setLocalVar("Nyzul", 1)

                    if pathOfDarkness == 1 then
                        v:delKeyItem(tpz.ki.NYZUL_ISLE_ROUTE)
                    elseif nashmeirasPlea == 1 then
                        v:delKeyItem(tpz.ki.MYTHRIL_MIRROR)
                    else
                        v:delKeyItem(tpz.ki.NYZUL_ISLE_ASSAULT_ORDERS)
                    end
                end
            end
        end
    else
        player:messageText(target, ID.text.CANNOT_ENTER, false)
        player:instanceEntry(target, 3)
    end

    -- EventUpdate Hack: 2nd latch
    player:setLocalVar("NyzulReady", 1)
end
