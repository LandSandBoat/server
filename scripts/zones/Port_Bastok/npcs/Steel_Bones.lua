-----------------------------------
-- Area: Port Bastok
--  NPC: Steel Bones
-- Standard Info NPC
-- Involved in Quest: Guest of Hauteur
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local GuestofHauteur = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.GUEST_OF_HAUTEUR)
    local itemEquipped = player:getEquipID(tpz.slot.MAIN)

    if GuestofHauteur == QUEST_ACCEPTED and player:getCharVar("GuestofHauteur_Event") ~= 1 and (itemEquipped == 17045 or itemEquipped == 17426) then -- Maul / Replica Maul
        player:startEvent(57)
    else
        player:startEvent(29)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 57 then
        player:setCharVar("GuestofHauteur_Event", 1)
        player:addKeyItem(tpz.ki.LETTERS_FROM_DOMIEN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.LETTERS_FROM_DOMIEN)
    end

end
