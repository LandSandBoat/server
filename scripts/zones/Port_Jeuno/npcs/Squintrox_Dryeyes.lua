-----------------------------------
-- Area: Port Jeuno
--   NPC: Squintrox Dryeyes
-- Type: Addon Mission Merchant
-- !pos -100.071 -1 11.869 246
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/missions")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)

    local now = tonumber(os.date("%j"))
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
    local CrimsonKey = player:hasKeyItem(tpz.ki.CRIMSON_KEY)
    local LastCrimson = player:getCharVar("LastCrimsonKey") -- When last Crimson key was obtained

    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA ==0) then
        player:showText(npc, ID.text.GET_LOST)
    else    -- Crimson Key: Trade Seedspall's Lux, Luna, Astrum
        if (ENABLE_ACP == 1 and sLux and sLuna and sAstrum and count == 3 and ACPm >= tpz.mission.id.acp.GATHERER_OF_LIGHT_I and CrimsonKey == false and now ~= LastCrimson) then -- and timer stuff here) then
            player:tradeComplete()
            player:addKeyItem(tpz.ki.CRIMSON_KEY)
            player:setCharVar("LastCrimsonKey", os.date("%j"))
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CRIMSON_KEY)
        elseif (sLux and sLuna and sAstrum and count == 3 and (now == LastCrimson or CrimsonKey == true)) then
            player:messageSpecial(ID.text.DRYEYES_3, tpz.ki.CRIMSON_KEY)
        -- White Coral Key:
        -- elseif (ENABLE_AMK == 1 and
            -- haven't even started AMK related trades yet.
        end
    end
end

function onTrigger(player, npc)
    if (ENABLE_ACP == 0 and ENABLE_AMK == 0 and ENABLE_ASA ==0) then
        player:showText(npc, ID.text.GET_LOST)
    else
        player:startEvent(323)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- uncommented printf till we have all optionIDs mapped out.
    local now = tonumber(os.date("%j"))
    local ACPm = player:getCurrentMission(ACP)
    local AMKm = player:getCurrentMission(AMK)
    local ASAm = player:getCurrentMission(ASA)
    local salad = player:hasKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
    local juice = player:hasKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
    local grub = player:hasKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
    local ViridianKey = player:hasKeyItem(tpz.ki.VIRIDIAN_KEY)
    local LastViridian = player:getCharVar("LastViridianKey") -- When last Viridian key was obtained

    if (csid == 323) then
        if (option == 1) then
            player:showText(player, ID.text.DRYEYES_1)
        elseif (option == 100) then
            if (salad and juice and grub and ACPm >= tpz.mission.id.acp.GATHERER_OF_LIGHT_I and ViridianKey == false and now ~= LastViridian) then
                player:addKeyItem(tpz.ki.VIRIDIAN_KEY)
                player:delKeyItem(tpz.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
                player:delKeyItem(tpz.ki.JUG_OF_GREASY_GOBLIN_JUICE)
                player:delKeyItem(tpz.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
                player:setCharVar("LastViridianKey", os.date("%j"))
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.VIRIDIAN_KEY)
            elseif (now == LastViridian or ViridianKey == true) then
                player:messageSpecial(ID.text.DRYEYES_3, tpz.ki.VIRIDIAN_KEY)
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
