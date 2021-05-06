-----------------------------------
-- Area: Port Jeuno
--  NPC: Squintrox Dryeyes
-- Type: Addon Mission Merchant
-- !pos -100.071 -1 11.869 246
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    local count = trade:getItemCount()
    local sLux = trade:hasItemQty(2740, 1)
    local sLuna = trade:hasItemQty(2741, 1)
    local sAstrum = trade:hasItemQty(2742, 1)
    local orcArmor = trade:hasItemQty(2757, 1)
    local quadavBack = trade:hasItemQty(596, 1)
    local yagCaulk = trade:hasItemQty(2759, 1)
    local eKitBlind = trade:hasItemQty(2780, 1)
    local eKitPoison = trade:hasItemQty(2779, 1)
    local eKitSilence = trade:hasItemQty(2782, 1)
    local eKitSleep = trade:hasItemQty(2781, 1)
    local uggalepihWhistle = trade:hasItemQty(1184, 1)
    local ACPm = player:getCurrentMission(ACP)
    local AMKm = player:getCurrentMission(AMK)
    local ASAm = player:getCurrentMission(ASA)
    local CrimsonKey = player:hasKeyItem(xi.ki.CRIMSON_KEY)
    local LastCrimson = player:getCharVar("LastCrimsonKey") -- When last Crimson key was obtained

    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA ==0) then
        player:showText(npc, ID.text.GET_LOST)
    else    -- Crimson Key: Trade Seedspall's Lux, Luna, Astrum
        if (ENABLE_ACP == 1 and sLux and sLuna and sAstrum and count == 3 and ACPm >= xi.mission.id.acp.GATHERER_OF_LIGHT_I and CrimsonKey == false and os.time() > LastCrimson) then -- and timer stuff here) then
            player:tradeComplete()
            player:addKeyItem(xi.ki.CRIMSON_KEY)
            player:setCharVar("LastCrimsonKey", getMidnight())
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CRIMSON_KEY)
        elseif (sLux and sLuna and sAstrum and count == 3 and (os.time() <= LastCrimson or CrimsonKey == true)) then
            player:messageSpecial(ID.text.DRYEYES_3, xi.ki.CRIMSON_KEY)
        -- White Coral Key:
        -- elseif (ENABLE_AMK == 1 and
            -- haven't even started AMK related trades yet.
        end
    end
end

entity.onTrigger = function(player, npc)
    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA ==0) then
        player:showText(npc, ID.text.GET_LOST)
    else
        player:startEvent(323)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- uncommented printf till we have all optionIDs mapped out.
    local ACPm = player:getCurrentMission(ACP)
    local AMKm = player:getCurrentMission(AMK)
    local ASAm = player:getCurrentMission(ASA)
    local salad = player:hasKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
    local juice = player:hasKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
    local grub = player:hasKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
    local ViridianKey = player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    local LastViridian = player:getCharVar("LastViridianKey") -- When last Viridian key was obtained

    if (csid == 323) then
        if (option == 1) then
            player:showText(player, ID.text.DRYEYES_1)
        elseif (option == 100) then
            if (salad and juice and grub and ACPm >= xi.mission.id.acp.GATHERER_OF_LIGHT_I and ViridianKey == false and os.time() > LastViridian) then
                player:addKeyItem(xi.ki.VIRIDIAN_KEY)
                player:delKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
                player:delKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
                player:delKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
                player:setCharVar("LastViridianKey", getMidnight())
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.VIRIDIAN_KEY)
            elseif (os.time() <= LastViridian or ViridianKey == true) then
                player:messageSpecial(ID.text.DRYEYES_3, xi.ki.VIRIDIAN_KEY)
            else
                -- player:showText(player, ? )
                -- Doesn't seem to be a message for trying when you don't have the key items?
            end
        -- Blue coral Key
        -- elseif (option == 101) then
            -- if
            -- end
        end
    end
end

return entity
