-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Charmealaut
-- Type: Merchant
-- !pos 0.000 -0.501 29.303 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
require("scripts/globals/teleports")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled ~= 0 then
        local ID = zones[player:getZoneID()]
        local smilebringersconvo = player:getCharVar("smilebringersconvo")
        local previousDay = player:getCharVar("previousDay")
        local currentDay = VanadielDayOfTheWeek()
        local fame = player:getFameLevel(xi.quest.fame_area.HOLIDAY)
        local head = player:getEquipID(xi.slot.HEAD)

        if previousDay ~= currentDay then
            player:setCharVar("smilebringersconvo", 0)
        end

        if smilebringersconvo == 0 then
            player:startEvent(768)
        elseif smilebringersconvo == 1 and (head == 15179 or head == 15178) then
            if fame < 1 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 0)
            elseif fame == 1 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 1)
            elseif fame == 2 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 1)
            elseif fame == 3 then
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 2)
            elseif fame == 4 then
                -- player:setLocalVar("famebefore", player:getFame(xi.quest.fame_area.HOLIDAY))
                -- player:startEvent(32741, 0260, 0003, 0600, 0000, 7800, 0000, 0000, 0000)
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 3)
            elseif fame == 5 then
                -- player:setLocalVar("famebefore", player:getFame(xi.quest.fame_area.HOLIDAY))
                -- player:startEvent(32741, 0260, 0004, 0600, 0000, 7800, 0000, 0000, 0000)
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 4)
            elseif fame == 6 then
                -- player:setLocalVar("famebefore", player:getFame(xi.quest.fame_area.HOLIDAY))
                -- player:startEvent(32741, 0260, 0004, 0600, 0000, 7800, 0000, 0000, 0000)
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 5)
            elseif fame == 7 then
                -- player:setLocalVar("famebefore", player:getFame(xi.quest.fame_area.HOLIDAY))
                -- player:startEvent(32741, 0260, 0005, 0600, 0000, 7800, 0000, 0000, 0000)
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 5)
            elseif fame == 8 then
                -- player:setLocalVar("famebefore", player:getFame(xi.quest.fame_area.HOLIDAY))
                -- player:startEvent(32741, 0260, 0005, 0600, 0000, 7800, 0000, 0000, 0000)
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 5)
            elseif fame == 9 then
                -- player:setLocalVar("famebefore", player:getFame(xi.quest.fame_area.HOLIDAY))
                -- player:startEvent(32741, 0260, 0006, 0600, 0000, 7800, 0000, 0000, 0000)
                player:showText(npc, ID.text.STARLIGHT_FAME_DIALOG, 0, 6)
            end
        else
            player:startEvent(32742)
        end
        player:PrintToPlayer("Please note: Teleports have been disabled for the current Starlight Celebration. Merry Starlight!", xi.msg.channel.UNKNOWN_32, "")
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- local fame = player:getFameLevel(xi.quest.fame_area.HOLIDAY)
    -- local cost = 90
    -- local famebefore = player:getLocalVar("famebefore")
    -- local fameafter = (famebefore - cost)
    -- if csid == 32741 and fame > 3 then
    --     if option == 1 then
    --         player:setFame(xi.quest.fame_area.HOLIDAY, fameafter)
    --         player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.SAN_DORIA_STARLIGHT, 0, 1)
    --     elseif option == 2 then
    --         player:setFame(xi.quest.fame_area.HOLIDAY, fameafter)
    --         player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BASTOK_STARLIGHT, 0, 1)
    --     elseif option == 3 then
    --         player:setFame(xi.quest.fame_area.HOLIDAY, fameafter)
    --         player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WINDURST_STARLIGHT, 0, 1)
    --     end
    if csid == 768 then
        if player:getFreeSlotsCount() >= 1 then
            player:addItem(1742, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.PRESENT_FOR_THE_KIDDIES)
            player:setCharVar("smilebringersconvo", 1)
            player:setCharVar("previousDay", VanadielDayOfTheWeek())
            if player:getCharVar("SmilebringersFameReset") ~= 1 then
                player:setFame(xi.quest.fame_area.HOLIDAY, 1)
                player:setCharVar("SmilebringersFameReset", 1)
            end
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.PRESENT_FOR_THE_KIDDIES)
        end
    end
end

return entity
