-----------------------------------
-- Area: Port Jeuno
--  NPC: Squintrox Dryeyes
-- Type: Addon Mission Merchant
-- !pos -100.071 -1 11.869 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count         = trade:getItemCount()
    local sLux          = trade:hasItemQty(xi.item.SEEDSPALL_LUX, 1)
    local sLuna         = trade:hasItemQty(xi.item.SEEDSPALL_LUNA, 1)
    local sAstrum       = trade:hasItemQty(xi.item.SEEDSPALL_ASTRUM, 1)
    local acpMission    = player:getCurrentMission(xi.mission.log_id.ACP)
    local hasCrimsonKey = player:hasKeyItem(xi.ki.CRIMSON_KEY)
    local lastCrimson   = player:getCharVar('LastCrimsonKey') -- When last Crimson key was obtained

    if
        xi.settings.main.ENABLE_ACP == 0 and
        xi.settings.main.ENABLE_AMK == 0 and
        xi.settings.main.ENABLE_ASA == 0
    then
        player:showText(npc, ID.text.GET_LOST)

    -- Crimson Key: Trade Seedspall's Lux, Luna, Astrum
    else
        if
            xi.settings.main.ENABLE_ACP == 1 and
            sLux and
            sLuna and
            sAstrum and
            count == 3 and
            acpMission >= xi.mission.id.acp.GATHERER_OF_LIGHT_I and
            not hasCrimsonKey and
            os.time() > lastCrimson
        then -- and timer stuff here) then
            player:tradeComplete()
            player:addKeyItem(xi.ki.CRIMSON_KEY)
            player:setCharVar('LastCrimsonKey', getMidnight())
            player:messageSpecial(ID.text.DRYEYES_2)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CRIMSON_KEY)

        elseif
            sLux and
            sLuna and
            sAstrum and
            count == 3 and
            (os.time() <= lastCrimson or hasCrimsonKey)
        then
            player:messageSpecial(ID.text.DRYEYES_3, xi.ki.CRIMSON_KEY)
        -- White Coral Key:
        -- elseif xi.settings.main.ENABLE_AMK == 1 and
            -- haven't even started AMK related trades yet.
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        xi.settings.main.ENABLE_ACP == 0 and
        xi.settings.main.ENABLE_AMK == 0 and
        xi.settings.main.ENABLE_ASA == 0
    then
        player:showText(npc, ID.text.GET_LOST)
    else
        player:startEvent(323)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local acpMission     = player:getCurrentMission(xi.mission.log_id.ACP)
    local salad          = player:hasKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
    local juice          = player:hasKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
    local grub           = player:hasKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
    local hasViridianKey = player:hasKeyItem(xi.ki.VIRIDIAN_KEY)
    local lastViridian   = player:getCharVar('LastViridianKey') -- When last Viridian key was obtained

    if csid == 323 then
        if option == 1 then
            player:showText(player, ID.text.DRYEYES_1)
        elseif option == 100 then
            if
                salad and
                juice and
                grub and
                acpMission >= xi.mission.id.acp.GATHERER_OF_LIGHT_I and
                not hasViridianKey and
                os.time() > lastViridian
            then
                player:addKeyItem(xi.ki.VIRIDIAN_KEY)
                player:delKeyItem(xi.ki.BOWL_OF_BLAND_GOBLIN_SALAD)
                player:delKeyItem(xi.ki.JUG_OF_GREASY_GOBLIN_JUICE)
                player:delKeyItem(xi.ki.CHUNK_OF_SMOKED_GOBLIN_GRUB)
                player:setCharVar('LastViridianKey', getMidnight())
                player:showText(player, ID.text.DRYEYES_2)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.VIRIDIAN_KEY)

            elseif
                os.time() <= lastViridian or
                hasViridianKey
            then
                player:messageSpecial(ID.text.DRYEYES_3, xi.ki.VIRIDIAN_KEY)

            else
                -- player:showText(player, ?)
                -- Doesn't seem to be a message for trying when you don't have the key items?
            end
        -- Blue coral Key
        -- elseif option == 101 then
        end
    end
end

return entity
