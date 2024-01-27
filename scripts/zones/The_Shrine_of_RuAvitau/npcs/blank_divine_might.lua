-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? divine might mission
-- !pos -40 0 -151 178
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local currentZM    = player:getCurrentMission(xi.mission.log_id.ZILART)
    local zmProgress   = player:getMissionStatus(xi.mission.log_id.ZILART)
    local dmStatus     = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
    local dmRepeat     = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
    local aaKeyitems   = 0
    local dmEarrings   = 0
    local divineStatus = player:getCharVar('DivineMight')
    local hasMoonOre   = player:hasKeyItem(xi.ki.MOONLIGHT_ORE)

    -- Count keyitems
    for i = xi.ki.SHARD_OF_APATHY, xi.ki.SHARD_OF_RAGE do
        if player:hasKeyItem(i) then
            aaKeyitems = aaKeyitems + 1
        end
    end

    -- Count Earrings
    for i = xi.item.SUPPANOMIMI, xi.item.BUSHINOMIMI do
        if player:hasItem(i) then
            dmEarrings = dmEarrings + 1
        end
    end

    -- Reminder CS/starts Divine Might (per Wiki)
    if
        currentZM == xi.mission.id.zilart.ARK_ANGELS and
        zmProgress == 1 and
        divineStatus < 2
    then
        player:startEvent(54, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK, xi.item.ARK_PENTASPHERE)

    -- Alternative cutscene for those that have done one or more AA fight
    elseif
        currentZM >= xi.mission.id.zilart.ARK_ANGELS and
        dmStatus == QUEST_AVAILABLE and
        aaKeyitems > 0
    then
        player:startEvent(56, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK, xi.item.ARK_PENTASPHERE)

    -- CS when player has completed Divine might, award earring
    elseif
        dmStatus == QUEST_ACCEPTED and
        divineStatus >= 2
    then
        player:startEvent(55, xi.item.SUPPANOMIMI, xi.item.KNIGHTS_EARRING, xi.item.ABYSSAL_EARRING, xi.item.BEASTLY_EARRING, xi.item.BUSHINOMIMI)

    -- You threw away old Earring, start the repeat quest
    elseif
        dmStatus == QUEST_COMPLETED and
        dmEarrings < xi.settings.main.NUMBER_OF_DM_EARRINGS and
        dmRepeat ~= QUEST_ACCEPTED
    then
        player:startEvent(57, player:getCharVar('DM_Earring'))

    -- Moonlight Ore/Ark Pentasphere reminders
    elseif
        dmRepeat == QUEST_ACCEPTED and
        divineStatus < 2
    then
        if not hasMoonOre then
            player:startEvent(58) -- Reminder for Moonlight Ore
        else
            player:startEvent(56, xi.item.SHEET_OF_PARCHMENT, xi.item.BOTTLE_OF_ILLUMININK, xi.item.ARK_PENTASPHERE) -- Reminder for Ark Pentasphere
        end

    -- Repeat turn in
    elseif
        dmRepeat == QUEST_ACCEPTED and
        divineStatus == 2 and
        hasMoonOre
    then
        player:startEvent(59)

    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY) -- Need some kind of feedback
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if
        (csid == 55 or csid == 59) and
        option == 2
    then
        player:updateEvent(xi.item.SUPPANOMIMI, xi.item.KNIGHTS_EARRING, xi.item.ABYSSAL_EARRING, xi.item.BEASTLY_EARRING, xi.item.BUSHINOMIMI)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Flag Divine Might
    if
        (csid == 54 or csid == 56) and
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT) == QUEST_AVAILABLE
    then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)

    -- Divine Might Repeat
    elseif csid == 57 then
        player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)

    -- Turning in Divine Might or Repeat
    elseif
        csid == 55 or
        csid == 59
    then
        local reward = 0

        if option == 1 then
            reward = xi.item.SUPPANOMIMI
        elseif option == 2 then
            reward = xi.item.KNIGHTS_EARRING
        elseif option == 3 then
            reward = xi.item.ABYSSAL_EARRING
        elseif option == 4 then
            reward = xi.item.BEASTLY_EARRING
        elseif option == 5 then
            reward = xi.item.BUSHINOMIMI
        end

        if reward ~= 0 then
            if
                player:getFreeSlotsCount() >= 1 and
                not player:hasItem(reward)
            then
                player:addItem(reward)
                player:messageSpecial(ID.text.ITEM_OBTAINED, reward)

                if csid == 55 then
                    player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
                else
                    player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)
                    player:delKeyItem(xi.ki.MOONLIGHT_ORE)
                end

                player:setCharVar('DivineMight', 0)
                player:setCharVar('DM_Earring', reward)
                player:addTitle(xi.title.PENTACIDE_PERPETRATOR)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
            end
        end
    end
end

return entity
