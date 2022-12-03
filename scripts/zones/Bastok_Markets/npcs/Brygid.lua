-----------------------------------
-- Area: Bastok Markets
--  NPC: Brygid
-- Start & Finishes Quest: Brygid the Stylist & Brygid the Stylist Returns
-- Involved in Quests: Riding on the Clouds
-- !pos -90 -4 -108 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/settings")
require('scripts/globals/items')
require("scripts/globals/keyitems")
require("scripts/globals/equipment")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local bodyList = { 12554, 13712, 12594, 13723, 12603, 13699, 12610, 13783, 12572, 12611, 13796, 12571, 13750, 12604, 13752, 12544, 13730, 12578, 12553, 12595 }
local legsList = { 12829, 12800, 12866, 12809, 12810, 12850, 12828, 12859, 12837, 14243, 12838, 12867, 12827, 12836, 12860, 12851 }

entity.onTrade = function(player, npc, trade)
    local brygidReturns = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)
    local wantsSubligar = player:getCharVar("BrygidWantsSubligar")

    if brygidReturns == QUEST_ACCEPTED and wantsSubligar ~= 0 then
        if wantsSubligar == 13 then
            if trade:getItemCount() == 1 and trade:hasItemQty(15375 + wantsSubligar, 1) then
                player:tradeComplete()
                player:startEvent(383)
            end
        else
            if trade:getItemCount() == 1 and trade:hasItemQty(15374 + wantsSubligar, 1) then
                player:tradeComplete()
                player:startEvent(383)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local brygidTheStylist = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST)
    local brygidReturns = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)
    local head = player:getEquipID(xi.slot.HEAD)
    local body = player:getEquipID(xi.slot.BODY)
    local hands = player:getEquipID(xi.slot.HANDS)
    local legs = player:getEquipID(xi.slot.LEGS)
    local feet = player:getEquipID(xi.slot.FEET)

    local getBody = player:getCharVar("BrygidGetBody")
    local getLegs = player:getCharVar("BrygidGetLegs")
    local wantsSubligar = player:getCharVar("BrygidWantsSubligar")

    local robeEquipped = body == xi.items.ROBE and 1 or 0

    if
        brygidReturns ~= QUEST_ACCEPTED and
        brygidTheStylist == QUEST_COMPLETED and
        (
            xi.equip.isArtifactArmor(head) or
            xi.equip.isArtifactArmor(body) or
            xi.equip.isArtifactArmor(hands) or
            xi.equip.isArtifactArmor(legs) or
            xi.equip.isArtifactArmor(feet)
        )
    then
        -- Randomize and store sets here
        repeat
            getBody = bodyList[math.random(1, 20)]
        until(player:canEquipItem(getBody, false))

        repeat
            getLegs = legsList[math.random(1, 16)]
        until(player:canEquipItem(getLegs, false))

        player:setCharVar("BrygidGetBody", getBody)
        player:setCharVar("BrygidGetLegs", getLegs)

        player:startEvent(380, robeEquipped, getBody, getLegs, player:getMainJob())

    elseif
        brygidReturns == QUEST_ACCEPTED and
        body == getBody and
        legs == getLegs and
        wantsSubligar == 0
    then
        -- Have the right equips, proceed with quest
        player:startEvent(382)

    elseif brygidReturns == QUEST_ACCEPTED and wantsSubligar == 0 then
        -- Remind player what they need to wear
        player:startEvent(381, robeEquipped, getBody, getLegs, player:getMainJob())

    elseif brygidReturns == QUEST_ACCEPTED and wantsSubligar ~= 0 then
        -- Remind player what subligar they need to turn in and the reward
        if wantsSubligar == 13 then
            player:startEvent(385, 0, 14400 + wantsSubligar, 15375 + wantsSubligar)
        else
            player:startEvent(385, 0, 14400 + wantsSubligar, 15374 + wantsSubligar)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 382 then
        local canEquip = 0
        local hasBody = 0

        if player:canEquipItem(14400 + option, true) then
            canEquip = 1
        end

        if not player:hasItem(14400 + option) then
            hasBody = 1
        end

        player:updateEvent(0, option-1, hasBody, canEquip)
    end
end

entity.onEventFinish = function(player, csid, option)
    local wantsSubligar = player:getCharVar("BrygidWantsSubligar")

    if csid == 380 then
        player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)

    elseif csid == 382 and option ~= 99 then
        player:setCharVar("BrygidWantsSubligar", option)

    elseif csid == 383 then
        player:setCharVar("BrygidGetBody", 0)
        player:setCharVar("BrygidGetLegs", 0)
        player:setCharVar("BrygidWantsSubligar", 0)
        player:addTitle(xi.title.BASTOKS_SECOND_BEST_DRESSED)
        player:addItem(14400 + wantsSubligar)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 14400 + wantsSubligar)
        player:addFame(xi.quest.fame_area.BASTOK, 30)
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)
    end
end

return entity
