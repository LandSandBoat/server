-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Shajaf
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local imperialStanding = player:getCurrency('imperial_standing')

    -- ISNM accepted but not completed. TODO: Check if KIs expire aswell.
    if
        player:hasKeyItem(xi.ki.CONFIDENTIAL_IMPERIAL_ORDER) or
        player:hasKeyItem(xi.ki.SECRET_IMPERIAL_ORDER)
    then
        player:startEvent(161)

    -- ISNM completed. 1 day lockout hasn't expired.
    elseif player:getCharVar('[ISNM]Accepted') == 1 then
        player:startEvent(163)

    -- Can purchuase KI.
    elseif player:hasKeyItem(xi.ki.PSC_WILDCAT_BADGE) then
        player:startEvent(160, imperialStanding, 1)

    -- Default.
    else
        player:startEvent(162)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local imperialStanding = player:getCurrency('imperial_standing')

    if csid == 160 then
        -- Lv. 60 fight
        if
            option == 1 and
            imperialStanding >= 2000
        then
            player:setCharVar('[ISNM]Accepted', 1, getMidnight())
            player:delCurrency('imperial_standing', 2000)
            npcUtil.giveKeyItem(player, xi.ki.CONFIDENTIAL_IMPERIAL_ORDER)

        -- Lv. 75 fight
        elseif
            option == 2 and
            imperialStanding >= 3000
        then
            player:setCharVar('[ISNM]Accepted', 1, getMidnight())
            player:delCurrency('imperial_standing', 3000)
            npcUtil.giveKeyItem(player, xi.ki.SECRET_IMPERIAL_ORDER)
        end
    end
end

return entity
