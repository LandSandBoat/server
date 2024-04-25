-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Shajaf
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local imperialStanding = player:getCurrency('imperial_standing')

    -- Players can only purchase a KI once every real-life day.
    -- This var is set onEventFinish
    if player:getCharVar('isnmAccepted') == 1 then
        -- 'I don't have any offers for you at the moment'
        player:startEvent(163)
    elseif
        player:hasKeyItem(xi.ki.CONFIDENTIAL_IMPERIAL_ORDER) or
        player:hasKeyItem(xi.ki.SECRET_IMPERIAL_ORDER)
    then
        -- 'What are you doing, running off from a job?'
        player:startEvent(161, 0)
    elseif
        player:hasKeyItem(xi.ki.PSC_WILDCAT_BADGE) and
        imperialStanding >= 2000 -- Prevent against packet injection
    then
        --TODO: It is unclear what params 3-9 affect.
        player:startEvent(160, imperialStanding, 1, 1791, 0, 0, 0, 2, 4095)
    else
        player:startEvent(162)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    local imperialStanding = player:getCurrency('imperial_standing')

    if
        csid == 160
    then
        if
            option == 1 and
            imperialStanding >= 2000 and
            npcUtil.giveKeyItem(player, xi.ki.CONFIDENTIAL_IMPERIAL_ORDER)
        then
            player:setCharVar('isnmAccepted', 1, getMidnight())
            player:delCurrency('imperial_standing', 2000) -- Lv. 60 fight
        elseif
            option == 2 and
            imperialStanding >= 3000 and
            npcUtil.giveKeyItem(player, xi.ki.SECRET_IMPERIAL_ORDER)
        then
            player:setCharVar('isnmAccepted', 1, getMidnight())
            player:delCurrency('imperial_standing', 3000) -- Lv. Uncapped fight
        end
    end
end

return entity
