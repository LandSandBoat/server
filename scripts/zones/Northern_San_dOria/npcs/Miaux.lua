-----------------------------------
-- Area: Northern San d'Oria
--   NPC: Miaux
-- Type: Quest Giver
-- !pos -169.127 2.999 158.677 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local aCraftsmansWork = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.A_CRAFTSMAN_S_WORK)
    local Quotas_Status = player:getCharVar("ChasingQuotas_Progress")

    if (player:getMainJob() == tpz.job.DRG and player:getMainLvl() >= AF1_QUEST_LEVEL and aCraftsmansWork == QUEST_AVAILABLE) then
        if (player:getCharVar("has_seen_drgaf1_quest_already") == 0) then
            player:startEvent(73)
        else -- If player has seen the big cut scene, give them a smaller one.
            player:startEvent(71)
        end
    elseif (aCraftsmansWork == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.ALTEPA_POLISHING_STONE) == false) then
        player:startEvent(69)
    elseif (aCraftsmansWork == QUEST_ACCEPTED) then
            player:startEvent(70)
    elseif (Quotas_Status == 2) then
        player:startEvent(67) -- I found this earring.
    elseif (Quotas_Status == 3 or Quotas_Status == 4) then
        player:startEvent(68) -- Post-earring, move along.
    elseif (Quotas_Status >= 5) then
        player:startEvent(66) -- The earring was helpful?
    else
        player:startEvent(11)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 73 and option == 0) then -- first part of long CS -- declines questgiver
        player:setCharVar("has_seen_drgaf1_quest_already", 1)
    elseif ((csid == 73 or csid == 71) and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.A_CRAFTSMAN_S_WORK)
        player:setCharVar("has_seen_drgaf1_quest_already", 0)
        player:setCharVar("aCraftsmanWork", 1)
    elseif (csid == 70) then -- This is only if player has Altepa Polishing Stone
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16887)-- Peregrine (DRG AF1)
        else
            player:setCharVar("aCraftsmanWork", 0)
            player:delKeyItem(tpz.ki.ALTEPA_POLISHING_STONE)
            player:addItem(16887)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16887) -- Peregrine (DRG AF1)
            player:addFame(SANDORIA, 20)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.A_CRAFTSMAN_S_WORK)
        end
    elseif (csid == 67) then
        player:addKeyItem(tpz.ki.SHINY_EARRING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SHINY_EARRING)
        player:setCharVar("ChasingQuotas_Progress", 3)
    end

end
-- 11 Miaux : "<Sigh> Why must all craftsmen be so uptight?"
-- 73 Miaux : "I wish to have a breastplate repaired... Y/N dialog
-- 71 Miaux : "I...I hesitate to impose upon you again, but would it be possible for you to find
-- me an Altepa polishing stone? Naturplayer, I will pay you for your troubles...
-- accept the task? Yes/No dialog Thank you.  It would mean so much to me."
-- 69 Miaux : "The Altepa polishing stone can be found in the Eastern Altepa Desert.  Please take
-- care on your travels!"
-- 70 Miaux : "So this is the Altepa polishing stone that Ranchuriome was talking about.  I am
-- most grateful for your help.  Please accept this as payment." ------------------------------------------Reward gil
-- "Miaux : Here, Ranchuriome.  <Character> is the reason we have this!"
-- Ranchuriome : "Excellent! You managed to find one.  Now I can start on those repairs.  I'll
-- have it ready for you by dinnertime."
-- Ranchuriome : "I've really been feeling my years lately... No matter.  I'm sure I'll perk up
-- once I start working."
-- Miaux : "I'm most grateful to you!"
-- 72 Miaux : "You don't see many people with that kind of integrity around anymore.  If my
-- father was still alive, they would have struck up a solid friendship, I'm sure."
-- 66 Miaux : "Oh, that shiny earring came in handy after all?  That's wonderful!  I'm glad
-- I could help someone out in the same way that you and Ranchuriome helped me.
-- Miaux: I don't think I'm suited for a career as a detective, though... I think I'll concentrate
-- on helping people in a way that's more within my capabilities."
-- (10)10 Miaux : "Thanks to your help, my father's breastplate is looking like new, but...
-- That nice old man, Ranchuriome, has passed away.
-- Miaux : "I can't help but think it's my fault in some way...that the repairs he did for me were
-- too strenuous.  When I attended the funeral to pay my respects, though, his features seemed to
-- be at peace."
-- (67)67 Miaux : "I attended Ranchuriome's funeral to pay my respects and express my thanks for
-- his kindness.  During the ceremony, I was distracted by an unusal lady among the mourners.
-- Miaux : "Something about this woman seemed out of place.  I tried to follow her after the funeral
-- ended, but... I lost sight of her not long after.  I searched around, trying to find her again.
-- Instead, I came across Ranchuriome's son lying unconscious on the ground.  I tended to his wound,
-- and thankfully, he soon regained consciousness.  I found this lying nearby.
-- Miaux : "This shiny earring might be a clue as to what happened. It's probably just my overactive
-- imagination, but perhaps it will help in some way.  Here, you should hold onto it, just in case."
-- (68)68 Miaux : "A suspicious woman and a shiny earring... Probably just my overactive imagination."
-- (535)535 City - The fortress of sandy... But now, her reign of glory... The sun set on the kingdom
-- of knights... Yet young Elvaan knights still venture proudly... On this particular day there comes a new...
-- The king wishes to bolster his ranks, and <Character>... Should fortune favor her, bards across the land...
-- Of course, she has only begun her rise to glory... Never before has she set foot within the Elvaan Capital...
-- Rochefogne : "Say, are you an adventurer?"
