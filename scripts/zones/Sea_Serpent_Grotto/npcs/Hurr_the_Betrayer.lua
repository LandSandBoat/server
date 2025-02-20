-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Hurr the Betrayer
-- Type: Involved in the 'Sahagin Key Quest'
-- !pos 305.882 26.768 234.279 176
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar('SahaginKeyItems') == 1 then -- If player was told to use 3 Mythril Beastcoins
        if npcUtil.tradeHas(trade, { { xi.item.MYTHRIL_BEASTCOIN, 3 }, { xi.item.NORG_SHELL, 1 } }) then
            player:startEvent(107)
        end
    elseif player:getCharVar('SahaginKeyItems') == 2 then -- If player was told to use a Gold Beastcoin
        if npcUtil.tradeHas(trade, { xi.item.GOLD_BEASTCOIN, xi.item.NORG_SHELL }) then
            player:startEvent(107)
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getCharVar('SahaginKeyProgress') == 2 and
        not player:hasItem(xi.item.SAHAGIN_KEY)
    then
        -- If player has never before finished the quest
        player:startEvent(105)
        player:setCharVar('SahaginKeyItems', 1)
    elseif
        player:getCharVar('SahaginKeyProgress') == 3 and
        player:getCharVar('SahaginKeyItems') == 0 and
        not player:hasItem(xi.item.SAHAGIN_KEY)
    then
        if math.random(1, 100) <= 50 then
            player:startEvent(105) -- Requires 3 Mythril Beastcoins and a Norg Shell
            player:setCharVar('SahaginKeyItems', 1)
        else
            player:startEvent(106) -- Requires Gold Beastcoin and a Norg Shell
            player:setCharVar('SahaginKeyItems', 2)
        end
    elseif
        player:getCharVar('SahaginKeyProgress') == 3 and
        player:getCharVar('SahaginKeyItems') == 1
    then
        player:startEvent(105) -- If player was told to use 3 Mythril Beastcoins
    elseif
        player:getCharVar('SahaginKeyProgress') == 3 and
        player:getCharVar('SahaginKeyItems') == 2
    then
        player:startEvent(106) -- If player was told to use a Gold Beastcoin
    elseif
        player:getCharVar('SahaginKeyProgress') == 2 and
        player:hasItem(xi.item.SAHAGIN_KEY)
    then
        player:startEvent(104) -- Doesn't offer the key again if the player has one
    else
        player:startEvent(104) -- Doesn't offer the key if the player hasn't spoken to the first 2 NPCs
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 107 and
        player:getCharVar('SahaginKeyProgress') == 2 and
        npcUtil.giveItem(player, xi.item.SAHAGIN_KEY)
    then
        player:confirmTrade()
        player:setCharVar('SahaginKeyProgress', 3) -- Mark the quest progress
        player:setCharVar('SahaginKeyItems', 0)
    elseif
        csid == 107 and
        player:getCharVar('SahaginKeyProgress') == 3 and
        npcUtil.giveItem(player, xi.item.SAHAGIN_KEY)
    then
        player:confirmTrade()
        player:setCharVar('SahaginKeyItems', 0)
    end
end

return entity
