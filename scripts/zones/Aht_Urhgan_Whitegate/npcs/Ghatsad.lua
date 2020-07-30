-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ghatsad
-- Standard Info NPC
-- Involved in quest: No String Attached
-----------------------------------
require("scripts/globals/common")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/keyitems")
-----------------------------------

-- Items in trades
BRASS_SHEET            = 661
ROSEWOOD_LUMBER        = 718
GOLD_THREAD            = 823
VELVET_CLOTH           = 828
KARAKUL_LEATHER        = 879
WAMOURA_COCOON         = 2173
IMPERIAL_SILVER_PIECE  = 2185
IMPERIAL_MYTHRIL_PIECE = 2186
IMPERIAL_GOLD_PIECE    = 2187
KARAKUL_CLOTH          = 2288
WAMOURA_CLOTH          = 2289
IMPERIAL_CERMET        = 2290
BLACK_PUPPET_TURBAN    = 2501
WHITE_PUPPET_TURBAN    = 2502
SCROLL_CURE_V          = 4613
SCROLL_REGEN           = 4716
SCROLL_STONE_IV        = 4770
SCROLL_CURE_II         = 4610
SCROLL_FIRE            = 4752
SCROLL_ABSORB_INT      = 4878
IMPERIAL_COFFEE        = 5592
BRASS_RING             = 13465
PATAS                  = 16419
HEAVY_CROSSBOW         = 17220

function satisfy_attachment(player, new_attachmentStatus, new_attachmentReady)
    player:tradeComplete()
    player:startEvent(625)
    player:setCharVar("PUP_AttachmentStatus", new_attachmentStatus)
    player:setCharVar("PUP_AttachmentReady", new_attachmentReady)
end

function play_event624(player, attachments, new_attachmentStatus)
    player:tradeComplete()
    if attachments == 0 then
        player:startEvent(624, 0, 0, 0, 0, 0, IMPERIAL_SILVER_PIECE, 3)
    elseif attachments == 1 then
        player:startEvent(624, 0, 0, 0, 0, 0, IMPERIAL_MYTHRIL_PIECE, 3)
    elseif attachments == 2 then
        player:startEvent(624, 0, 0, 0, 0, 0, IMPERIAL_GOLD_PIECE, 1)
    end
    player:setCharVar("PUP_AttachmentStatus", new_attachmentStatus)
end

function play_event902(player, new_attachmentStatus, new_attachmentWait)
    player:tradeComplete()
    player:setCharVar("PUP_AttachmentStatus", new_attachmentStatus)
    player:setCharVar("PUP_AttachmentReady", getVanaMidnight())
    player:setCharVar("PUP_AttachmentWait", new_attachmentWait)
    player:startEvent(902)
end



function onTrade(player, npc, trade)
    local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")
    local attachments = player:getCharVar("PUP_Attachments")
    local unlockedAttachments = player:getCharVar("PUP_AttachmentUnlock")
    local attachmentTime = player:getCharVar("PUP_AttachmentReady")
    local attachmentReady = (attachmentTime ~= 0 and attachmentTime < os.time())
    local attachmentWait = player:getCharVar("PUP_AttachmentWait")

    local payment_received =
           attachments == 0 and trade:getItemQty(IMPERIAL_SILVER_PIECE) == 3
        or attachments == 1 and trade:getItemQty(IMPERIAL_MYTHRIL_PIECE) == 3
        or attachments == 2 and trade:getItemQty(IMPERIAL_GOLD_PIECE) == 1
        or attachments == 3 and trade:getItemQty(IMPERIAL_MYTHRIL_PIECE) == 2
        or attachments == 4 and trade:getItemQty(IMPERIAL_MYTHRIL_PIECE) == 4

    local valoredge_items_traded = trade:getItemQty(BRASS_SHEET) == 1
        and trade:getItemQty(WAMOURA_COCOON) == 1
        and trade:getItemQty(IMPERIAL_CERMET) == 1
        and trade:getItemQty(PATAS) == 1

    local sharpshot_items_traded = trade:getItemQty(ROSEWOOD_LUMBER) == 1
        and trade:getItemQty(KARAKUL_CLOTH) == 1
        and trade:getItemQty(KARAKUL_LEATHER) == 1
        and trade:getItemQty(HEAVY_CROSSBOW) == 1

    local stormwaker_items_traded = trade:getItemQty(GOLD_THREAD) == 1
        and trade:getItemQty(VELVET_CLOTH) == 1
        and trade:getItemQty(WAMOURA_CLOTH) == 1
        and trade:getItemQty(BRASS_RING) == 1

    if attachmentStatus == 2 then
        if trade:getSlotCount() == 4 then
            --Valoredge X-900
            if valoredge_items_traded then
                play_event624(player, attachments, 5)
            end
        elseif trade:getSlotCount() == 5 then
            if valoredge_items_traded and payment_received then
                satisfy_attachment(player, 8, getVanaMidnight())
            end
        end
    elseif attachmentStatus == 3 then
        if trade:getSlotCount() == 4 then
            -- Sharpshot Z-500
            if sharpshot_items_traded then
                play_event624(player, attachments, 6)
            end
        elseif trade:getSlotCount() == 5 then
            if sharpshot_items_traded and payment_received then
                satisfy_attachment(player, 9, getVanaMidnight())
            end
        end
    elseif attachmentStatus == 4 then
        if trade:getSlotCount() == 4 then
            -- Stormwaker Y-700
            if stormwaker_items_traded then
                play_event624(player, attachments, 7)
            end
        elseif trade:getSlotCount() == 5 then
            if stormwaker_items_traded and payment_received then
                satisfy_attachment(player, 10, getVanaMidnight())
            end
        end
    elseif attachmentStatus == 5 then
        if payment_received and trade:getSlotCount()==1 then
            satisfy_attachment(player, 8, getVanaMidnight())
        end
    elseif attachmentStatus == 6 then
        if payment_received and trade:getSlotCount()==1 then
            satisfy_attachment(player, 9, getVanaMidnight())
        end
    elseif attachmentStatus == 7 then
        if payment_received and trade:getSlotCount()==1 then
            satisfy_attachment(player, 10, getVanaMidnight())
        end
    elseif attachments == 3 and attachmentStatus == 11 or attachments == 4 and attachmentStatus == 14 then
        if trade:getSlotCount() == 3 then
            if payment_received then
                if trade:getItemQty(WHITE_PUPPET_TURBAN) == 1 and (unlockedAttachments < 16 or unlockedAttachments >=32) then
                    if trade:getItemQty(SCROLL_CURE_V) == 1 then
                        play_event902(player, 12, math.random(1, 3))
                    elseif trade:getItemQty(SCROLL_REGEN) == 1 then
                        play_event902(player, 12, math.random(2, 3))
                    elseif trade:getItemQty(SCROLL_CURE_II) == 1 then
                        play_event902(player, 12, 4)
                    end
                elseif trade:getItemQty(BLACK_PUPPET_TURBAN) == 1 and unlockedAttachments < 32 then
                    if trade:getItemQty(SCROLL_STONE_IV) == 1 then
                        play_event902(player, 13, math.random(1, 3))
                    elseif trade:getItemQty(SCROLL_ABSORB_INT) == 1 then
                        play_event902(player, 13, math.random(2, 3))
                    elseif trade:getItemQty(SCROLL_FIRE) == 1 then
                        play_event902(player, 13, math.random(1, 3))
                    end
                end
            end
        end
    elseif (attachmentStatus == 12 or attachmentStatus == 13) and attachmentWait > 0 and attachmentReady == true then
        if trade:getSlotCount() == 1 and trade:getItemQty(IMPERIAL_COFFEE) == 1 then
            player:tradeComplete()
            player:setCharVar("PUP_AttachmentReady", getVanaMidnight())
            player:setCharVar("PUP_AttachmentWait", attachmentWait - 1)
            player:startEvent(904)
        end
    end
end

function onTrigger(player, npc)

    --cs 620 - new frame - param 6: itemid payment param 7: number of payment param 8: bitpack choices (bit 0 no thanks, bit 1 VE, bit 2 SS, bit 3 SW)
    --cs 621 - new frame (if canceled previous)
    --cs 622 - bring me mats
    --cs 624 - all mats, just need payment
    --cs 625 - thanks, have everything, come back later
    --cs 626 - come back later
    --cs 627 - automaton frame done (param 2: frame)
    --cs 628 - you can customise automaton by changing frame
    --cs 629 - you can alter automatons abilities and character by equipping attachments (what are these last 2 for?)
    --cs 900 - start soulsoother/spiritreaver
    --cs 901 - start second head
    --cs 902 - start work on chosen head
    --cs 903 - head almost done
    --cs 904 - give coffee
    --cs 905 - head complete

    local NoStringsAttached = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED)
    local NoStringsAttachedProgress = player:getCharVar("NoStringsAttachedProgress")
    local Automaton = player:hasKeyItem(tpz.ki.ANTIQUE_AUTOMATON)
    local automatonName = player:getAutomatonName()
    local CreationStarted_Day = player:getCharVar("CreationStarted_Day")
    local currentDay = VanadielDayOfTheYear()
    local CreationReady = ((CreationStarted_Day < currentDay) or (player:getCharVar("CreationStarted_Year") < VanadielYear()))
    local attachments = player:getCharVar("PUP_Attachments")
    local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")
    local unlockedAttachments = player:getCharVar("PUP_AttachmentUnlock")
    local attachmentTime = player:getCharVar("PUP_AttachmentReady")
    local attachmentReady = (attachmentTime ~= 0 and attachmentTime < os.time())
    local attachmentWait = player:getCharVar("PUP_AttachmentWait")
    local playerLvl = player:getMainLvl()

    --[[
        attachment status:
        0 - none
        1 - declined a new frame
        2 - accepted valoredge
        3 - accepted sharphot
        4 - accepted stormwaker
        5 - paid mats for valoredge
        6 - paid mats for sharpshot
        7 - paid mats for stormwaker
        8 - paid mats+coins for valoredge
        9 - paid mats+coins for sharpshot
        10 - paid mats+coins for stormwaker
        11 - asked about soulsoother/spiritreaver
        12 - paid for soulsoother
        13 - paid for spiritreaver
        14 - asked about soulsoother/spiritreaver (after obtaining the first)
    ]]

    if NoStringsAttached == QUEST_ACCEPTED then
        if NoStringsAttachedProgress == 2 then
            player:startEvent(262) -- he want you to go to Arrapago
        elseif NoStringsAttachedProgress == 3 then
            player:startEvent(263) -- reminder to go to Arrapago
        elseif NoStringsAttachedProgress == 4 and Automaton == true then
            player:startEvent(264) -- you give the antique automaton to him and need to wait a gameday
        elseif NoStringsAttachedProgress == 5 and CreationReady == true then
            player:startEvent(265) -- you go back for your automaton
        end
    elseif NoStringsAttached == QUEST_COMPLETED and player:getMainJob() == tpz.job.PUP then
        if attachments == 0 and attachmentStatus == 0 and playerLvl >= 10 then
            player:startEventString(620, automatonName, automatonName, automatonName, automatonName, attachments, 0, 0, 0, 0, 2185, 3, unlockedAttachments)
        elseif attachments == 0 and attachmentStatus == 1 then
            player:startEvent(621, 0, 0, 0, 0, 0, 2185, 3, unlockedAttachments)
        elseif attachments == 1 and attachmentStatus == 0 and playerLvl >= 20 then
            player:startEventString(620, automatonName, automatonName, automatonName, automatonName, attachments, 0, 0, 0, 0, 2186, 3, unlockedAttachments)
        elseif attachments == 1 and attachmentStatus == 1 then
            player:startEvent(621, 0, 0, 0, 0, 0, 2186, 3, unlockedAttachments)
        elseif attachments == 2 and attachmentStatus == 0 and playerLvl >= 30 then
            player:startEventString(620, automatonName, automatonName, automatonName, automatonName, attachments, 0, 0, 0, 0, 2187, 1, unlockedAttachments)
        elseif attachments == 3 and attachmentStatus == 0 and playerLvl >= 40 then
            player:startEventString(900, automatonName, automatonName, automatonName, automatonName, 0, 0, 0, 0, 0, 2186, 2)
        elseif attachments == 4 and attachmentStatus == 0 and playerLvl >= 50 then
            if unlockedAttachments == 30 then
                player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 1, 0, 0, 0, 0, 2186, 4)
            elseif unlockedAttachments == 46 then
                player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 0, 0, 0, 0, 0, 2186, 4)
            end
        elseif attachments == 2 and attachmentStatus == 1 then
            player:startEvent(621, 0, 0, 0, 0, 0, 2187, 1, unlockedAttachments)
        elseif attachmentStatus >= 8 and attachmentStatus <= 10 and attachmentReady == false then
            player:startEvent(626)
        elseif attachmentStatus == 8 and attachmentReady == true then
            player:startEventString(627, automatonName, automatonName, automatonName, automatonName, 0, 1)
        elseif attachmentStatus == 9 and attachmentReady == true then
            player:startEventString(627, automatonName, automatonName, automatonName, automatonName, 0, 2)
        elseif attachmentStatus == 10 and attachmentReady == true then
            player:startEventString(627, automatonName, automatonName, automatonName, automatonName, 0, 3)
        elseif attachmentStatus >= 2 and attachmentStatus <= 4 then
            if attachments == 0 then
                player:startEvent(622, 0, 1, 0, 0, 0, 2185, 3)
            elseif attachments == 1 then
                player:startEvent(622, 0, 1, 0, 0, 0, 2186, 3)
            elseif attachments == 2 then
                player:startEvent(622, 0, 1, 0, 0, 0, 2187, 1)
            end
        elseif attachmentStatus >= 5 and attachmentStatus <= 7 then
            if attachments == 0 then
                player:startEvent(624, 0, 0, 0, 0, 0, 2185, 3)
            elseif attachments == 1 then
                player:startEvent(624, 0, 0, 0, 0, 0, 2186, 3)
            elseif attachments == 2 then
                player:startEvent(624, 0, 0, 0, 0, 0, 2187, 1)
            end
        elseif attachmentStatus == 11 and attachments == 3 then
            player:startEventString(900, automatonName, automatonName, automatonName, automatonName, 0, 0, 1, 0, 0, 2186, 2)
        elseif (attachmentStatus == 12 or attachmentStatus == 13) then
            if attachmentReady == false then
                player:startEvent(903, attachmentWait, 1)
            elseif attachmentReady == true and attachmentWait > 0 then
                player:startEvent(903, attachmentWait, 0)
            elseif attachmentReady == true and attachmentWait == 0 then
                player:startEvent(905, attachmentStatus-12)
            end
        elseif attachmentStatus == 14 then
            if unlockedAttachments == 30 then
                player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 1, 0, 1, 0, 0, 2186, 4)
            elseif unlockedAttachments == 46 then
                player:startEventString(901, automatonName, automatonName, automatonName, automatonName, 0, 0, 1, 0, 0, 2186, 4)
            end
        end
    elseif attachments > 0 then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(628)
        else
            player:startEventString(629, automatonName, automatonName, automatonName, automatonName)
        end
    else
        player:startEvent(256)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 262 then
        player:setCharVar("NoStringsAttachedProgress", 3)
    elseif csid == 264 then
        player:setCharVar("CreationStarted_Day", VanadielDayOfTheYear())
        player:setCharVar("CreationStarted_Year", VanadielYear())
        player:setCharVar("NoStringsAttachedProgress", 5)
        player:delKeyItem(tpz.ki.ANTIQUE_AUTOMATON)
    elseif csid == 265 then
        player:setCharVar("NoStringsAttachedProgress", 6)
        player:setCharVar("CreationStarted_Day", 0)
        player:setCharVar("CreationStarted_Year", 0)
    elseif csid == 620 or csid == 621 then
        player:setCharVar("PUP_AttachmentStatus", option+1)
    elseif csid == 627 then
        local attachments = player:getCharVar("PUP_Attachments")
        local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")
        local unlockedAttachments = player:getCharVar("PUP_AttachmentUnlock")
        if attachmentStatus == 8 then
            player:unlockAttachment(8225)
            player:unlockAttachment(8194)
            player:setCharVar("PUP_AttachmentStatus", 0)
            player:setCharVar("PUP_Attachments", attachments+1)
            player:setCharVar("PUP_AttachmentUnlock", unlockedAttachments+2)
            player:setCharVar("PUP_AttachmentReady", 0)
            player:messageSpecial(ID.text.AUTOMATON_VALOREDGE_UNLOCK)
        elseif attachmentStatus == 9 then
            player:unlockAttachment(8226)
            player:unlockAttachment(8195)
            player:setCharVar("PUP_AttachmentStatus", 0)
            player:setCharVar("PUP_Attachments", attachments+1)
            player:setCharVar("PUP_AttachmentUnlock", unlockedAttachments+4)
            player:setCharVar("PUP_AttachmentReady", 0)
            player:messageSpecial(ID.text.AUTOMATON_SHARPSHOT_UNLOCK)
        elseif attachmentStatus == 10 then
            player:unlockAttachment(8227)
            player:unlockAttachment(8196)
            player:setCharVar("PUP_AttachmentStatus", 0)
            player:setCharVar("PUP_Attachments", attachments+1)
            player:setCharVar("PUP_AttachmentUnlock", unlockedAttachments+8)
            player:setCharVar("PUP_AttachmentReady", 0)
            player:messageSpecial(ID.text.AUTOMATON_STORMWAKER_UNLOCK)
        end
    elseif csid == 900 then
        player:setCharVar("PUP_AttachmentStatus", 11)
    elseif csid == 901 then
        player:setCharVar("PUP_AttachmentStatus", 14)
    elseif csid == 905 then
        local attachments = player:getCharVar("PUP_Attachments")
        local attachmentStatus = player:getCharVar("PUP_AttachmentStatus")
        local unlockedAttachments = player:getCharVar("PUP_AttachmentUnlock")
        if attachmentStatus == 12 then
            player:unlockAttachment(8197)
            player:setCharVar("PUP_AttachmentStatus", 0)
            player:setCharVar("PUP_Attachments", attachments+1)
            player:setCharVar("PUP_AttachmentReady", 0)
            player:setCharVar("PUP_AttachmentUnlock", unlockedAttachments+16)
            player:messageSpecial(ID.text.AUTOMATON_SOULSOOTHER_UNLOCK)
        elseif attachmentStatus == 13 then
            player:unlockAttachment(8198)
            player:setCharVar("PUP_AttachmentStatus", 0)
            player:setCharVar("PUP_Attachments", attachments+1)
            player:setCharVar("PUP_AttachmentReady", 0)
            player:setCharVar("PUP_AttachmentUnlock", unlockedAttachments+32)
            player:messageSpecial(ID.text.AUTOMATON_SPIRITREAVER_UNLOCK)
        end
    end
end
