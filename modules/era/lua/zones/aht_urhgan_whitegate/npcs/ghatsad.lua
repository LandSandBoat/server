-----------------------------------
-- Choosing an Automaton Frame
-- Restores the JST midnight waits for Ghatsad to finish new automaton frames and heads.
-- Ghatsad stops work on a head each midnight until he is given the day's Imperial Coffee.
-- The June 7, 2016 version update shortened the frame wait to one Vana'diel day.
-- The September 11, 2017 version update changed the head waits to count Vana'diel days.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://forum.square-enix.com/ffxi/threads/53127-September.-11-2017-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/13124.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_choosing_an_automaton_frame', xi.pre(xi.expansion.ROV))

-- Heads are built one work day at a time.
-- A work day requires the day's coffee and completes when JST midnight passes.

-- A fueled work day that reached midnight is complete.
local function settleHeadWork(player)
    local fueledUntil = player:getCharVar('[PUP]HeadFueled')

    if fueledUntil ~= 0 and JstMidnight() > fueledUntil then
        local daysRemaining = player:getCharVar('[PUP]HeadDaysRemaining') - 1

        player:setCharVar('[PUP]HeadDaysRemaining', daysRemaining)
        player:setCharVar('[PUP]HeadFueled', 0)

        -- Finished. The base script's Vana'diel day timer no longer applies.
        if
            daysRemaining <= 0 and
            player:getCharVar('PUP_AttachmentReady') > VanadielUniqueDay()
        then
            player:setCharVar('PUP_AttachmentReady', VanadielUniqueDay())
        end
    end
end

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Ghatsad.onTrade', function(player, npc, trade)
    local attachmentStatus = player:getCharVar('PUP_AttachmentStatus')

    -- The day's coffee gets Ghatsad back to work on a head.
    if attachmentStatus == 12 or attachmentStatus == 13 then
        settleHeadWork(player)

        if player:getCharVar('[PUP]HeadDaysRemaining') > 0 then
            if
                player:getCharVar('[PUP]HeadFueled') == 0 and
                npcUtil.tradeMatches(trade, { { xi.item.CUP_OF_IMPERIAL_COFFEE, 1 } })
            then
                player:startEvent(904)
            end

            return
        end
    end

    super(player, npc, trade)

    -- The trade commissioned a head. The rolled wait becomes days of work.
    local newStatus = player:getCharVar('PUP_AttachmentStatus')

    if
        newStatus ~= attachmentStatus and
        (newStatus == 12 or newStatus == 13)
    then
        -- The commission day is worked for free.
        player:setCharVar('[PUP]HeadDaysRemaining', player:getCharVar('PUP_AttachmentReady') - VanadielUniqueDay())
        player:setCharVar('[PUP]HeadFueled', JstMidnight())
    end
end)

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Ghatsad.onTrigger', function(player, npc)
    local attachmentStatus = player:getCharVar('PUP_AttachmentStatus')

    -- Paid in full for a frame. Ghatsad works on it until real midnight passes.
    if attachmentStatus >= 8 and attachmentStatus <= 10 then
        local completionTime = player:getCharVar('[PUP]FrameCompletion')

        if completionTime ~= 0 then
            if JstMidnight() <= completionTime then
                player:startEvent(626)
                return
            end

            -- Midnight has passed. The base script's Vana'diel day timer no longer applies.
            player:setCharVar('[PUP]FrameCompletion', 0)

            if player:getCharVar('PUP_AttachmentReady') > VanadielUniqueDay() then
                player:setCharVar('PUP_AttachmentReady', VanadielUniqueDay())
            end
        end

    -- Paid in full for a head.
    elseif attachmentStatus == 12 or attachmentStatus == 13 then
        settleHeadWork(player)

        local daysRemaining = player:getCharVar('[PUP]HeadDaysRemaining')

        if daysRemaining > 0 then
            if player:getCharVar('[PUP]HeadFueled') ~= 0 then
                player:startEvent(903, daysRemaining, 1)
            else
                -- Param 2 = 0 adds the drowsy dialogue. No work until he gets the day's coffee.
                player:startEvent(903, daysRemaining, 0)
            end

            return
        end
    end

    super(player, npc)
end)

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs.Ghatsad.onEventFinish', function(player, csid, option, npc)
    super(player, csid, option, npc)

    -- Frame commission accepted. It is finished once real midnight passes.
    if csid == 625 then
        player:setCharVar('[PUP]FrameCompletion', JstMidnight())

    -- Coffee accepted. Ghatsad works until midnight.
    -- Players already mid-wait when the module deployed keep the base coffee behavior.
    elseif csid == 904 and player:getCharVar('[PUP]HeadDaysRemaining') > 0 then
        player:setCharVar('[PUP]HeadFueled', JstMidnight())

    -- Frame or head handed over.
    elseif csid == 627 or csid == 905 then
        player:setCharVar('[PUP]FrameCompletion', 0)
        player:setCharVar('[PUP]HeadDaysRemaining', 0)
        player:setCharVar('[PUP]HeadFueled', 0)
    end
end)
