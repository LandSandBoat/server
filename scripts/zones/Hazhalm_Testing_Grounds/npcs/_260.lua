-----------------------------------
-- Area: Hazhalm_Testing_Grounds
-- NPC: Entry Gate (_260)
-----------------------------------
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

local function releaseLamp(player)
    local tradeContainer = player:getTrade()
    if tradeContainer then
        tradeContainer:clean()
    end
end

entity.onTrade = function(player, npc, trade)
    if not xi.einherjar.settings.EINHERJAR_ENABLED then
        return
    end

    if npcUtil.tradeHasExactly(trade, { xi.item.SMOLDERING_LAMP }) then
        if not xi.einherjar.meetsRequirementsForReservation(player) then
            releaseLamp(player)
            return
        end

        player:startEvent(2,
                0,
                xi.besieged.getMercenaryRank(player),
                xi.einherjar.settings.EINHERJAR_KO_EXPEL_TIME,
                xi.einherjar.settings.EINHERJAR_REENTRY_TIME,
                0, -- Unknown
                xi.einherjar.getChambersMenu(player),
                xi.item.SMOLDERING_LAMP,
                xi.item.GLOWING_LAMP
        )
        -- Continued in onEventUpdate 2
    end

    if npcUtil.tradeHasExactly(trade, { xi.item.GLOWING_LAMP }) then
        local lampObj = trade:getItem()
        local lampData = xi.einherjar.decypherLamp(lampObj)

        releaseLamp(player)
        local chamberData = xi.einherjar.getChamber(lampData.chamber)

        if not chamberData then
            xi.einherjar.voidLamp(player, lampObj)
            player:messageSpecial(ID.text.REQUIREMENTS_UNMET)
            return
        end

        if not xi.einherjar.meetsRequirementsForEntry(player, lampData.chamber) then
            return
        end

        player:setLocalVar('[ein]requestedChamber', lampData.chamber)
        player:setLocalVar('[ein]requestedStart', lampData.startTime)

        player:startEvent(3,
                0x1D + lampData.chamber,
                xi.besieged.getMercenaryRank(player),
                xi.einherjar.settings.EINHERJAR_KO_EXPEL_TIME,
                xi.einherjar.settings.EINHERJAR_REENTRY_TIME,
                0, -- Unknown
                xi.einherjar.getChambersMenu(player),
                xi.item.SMOLDERING_LAMP,
                xi.item.GLOWING_LAMP
        )
        -- Continued in onEventFinish 3,1
    end
end

entity.onTrigger = function(player, npc)
    -- TODO: Entry point for The Rider Cometh
    -- If The Rider Cometh is flagged, no lockout message will show
    -- but the battlefield selection menu will show up
    local lockout = xi.einherjar.isLockedOut(player)
    if lockout ~= 0 then
        player:messageSpecial(ID.text.ENTRY_PROHIBITED, lockout)
        return
    end

    player:messageSpecial(ID.text.GATE_FIRMLY_CLOSED)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 2 and (option >= 1 and option <= 10) then
        local mask = xi.einherjar.getChambersMenu(player)
        local chamberEntry = xi.einherjar.chambers[option]

        if not chamberEntry or bit.band(mask, chamberEntry.menu) ~= 0 then
            releaseLamp(player)
            print(string.format("Einherjar: %s attempted to reserve a chamber they don't have access to.", player:getName()))
            player:messageSpecial(ID.text.COULD_NOT_GATHER_DATA)
            player:instanceEntry(npc, 3)
            return
        end

        player:updateEvent(0,
            10,
            xi.settings.main.EINHERJAR_KO_EXPEL_TIME,
            xi.settings.main.EINHERJAR_REENTRY_TIME,
            0,
            xi.einherjar.getChambersMenu(player),
            xi.item.SMOLDERING_LAMP,
            xi.item.GLOWING_LAMP
        )
        if player:getFreeSlotsCount() ~= 0 then
            local chamberData = xi.einherjar.getChamber(option)
            if chamberData then
                releaseLamp(player)
                player:instanceEntry(npc, 3) -- 3 == chamber reservation failed
                player:messageSpecial(ID.text.CHAMBER_OCCUPIED, option)
                return
            else
                chamberData = xi.einherjar.createNewChamber(option, player)
                if not chamberData then
                    releaseLamp(player)
                    player:messageSpecial(ID.text.COULD_NOT_GATHER_DATA)
                    player:instanceEntry(npc, 3)
                    return
                end
            end

            xi.einherjar.makeLamp(player, chamberData.id, chamberData.startTime, chamberData.endTime)
            xi.einherjar.recordLockout(player)
            player:instanceEntry(npc, 4)
            -- Continued in onEventFinish 2
        else
            releaseLamp(player)
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.GLOWING_LAMP)
            player:instanceEntry(npc, 3)
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    -- Player has registered their lamp
    if csid == 2 then
        if option >= 65 and option <= 74 then -- > Rossweisse's Chamber < to < Odin's Chamber
            player:messageSpecial(ID.text.GLOWING_LAMP_OBTAINED, xi.item.GLOWING_LAMP)
            player:messageSpecial(ID.text.CLAIM_RELINQUISH, xi.item.GLOWING_LAMP, xi.einherjar.settings.EINHERJAR_RESERVATION_TIMEOUT)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.GLOWING_LAMP)
            player:confirmTrade()
        else -- event cancelled
            releaseLamp(player)
        end
    elseif csid == 3 and option == 1 then -- player requested entry into chamber
        local requestedChamber = player:getLocalVar('[ein]requestedChamber')
        local requestedStart = player:getLocalVar('[ein]requestedStart')
        player:setLocalVar('[ein]requestedChamber', 0)
        player:setLocalVar('[ein]requestedStart', 0)

        if requestedChamber == 0 or requestedStart == 0 then
            player:messageSpecial(ID.text.COULD_NOT_GATHER_DATA)
            return
        end

        local chamberData = xi.einherjar.getChamber(requestedChamber)
        if chamberData and chamberData.startTime == requestedStart then
            xi.einherjar.onChamberEnter(chamberData, player)
        end
    end
end

return entity
