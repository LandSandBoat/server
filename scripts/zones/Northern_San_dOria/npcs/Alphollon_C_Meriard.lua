-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Alphollon C Meriard
-- Type: Purifies cursed items with their corresponding abjurations.
-- !pos 98.108 -1 137.999 231
-----------------------------------
local nsandyID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:getItemCount() == 2 then
        local item = 0
        local reward = 0
        local abjurList = xi.abjurations
        for i = 1, #abjurList, 5 do
            if trade:hasItemQty(abjurList[i], 1) then
                if trade:hasItemQty(abjurList[i + 1], 1) then
                    item = abjurList[i + 1]
                    reward = abjurList[i + 3]
                elseif trade:hasItemQty(abjurList[i + 2], 1) then
                    item = abjurList[i + 2]
                    reward = abjurList[i + 4]
                end

                break
            end
        end

        if reward ~= 0 then
            --Trade pair for a nice reward.
            player:startEvent(720, item, reward)
            player:setCharVar('reward', reward)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(719)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 720 then
        local reward = player:getCharVar('reward')
        if reward ~= 0 then
            player:tradeComplete()
            player:addItem(reward)
            player:setCharVar('reward', 0)
            player:messageSpecial(nsandyID.text.ITEM_OBTAINED, reward)
        end
    end
end

return entity
